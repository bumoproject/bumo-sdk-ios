//
//  BUChainKey.m
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/18.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import "BUChainKey.h"
#import "Tools.h"
#import "Hash.h"
#import "Base58.h"
#import "sha.h"
#import "ripemd.h"
#import "hmac.h"
#import "ec.h"


@interface BUChainKey ()
@property(nonatomic, readwrite) NSData* identifier;
@property(nonatomic, readwrite) uint32_t fingerprint;
@property(nonatomic, readwrite) uint32_t parentFingerprint;
@property(nonatomic, readwrite) uint32_t index;
@property(nonatomic, readwrite) uint8_t depth;
@property(nonatomic, readwrite) BOOL hardened;

@property(nonatomic, readwrite) NSData* chainCode;
@property(nonatomic) NSData* privateKey;
@property(nonatomic) NSData* publicKey;
@end

@implementation BUChainKey
- (id) initWithSeed:(NSData*)seed {
    if (self = [super init]) {
        if (!seed) return nil;
        
        NSData* hmac = [Hash hmacSHA512WithKey: seed : [@"Bitcoin seed" dataUsingEncoding: NSUTF8StringEncoding]];
        _privateKey = [hmac subdataWithRange:NSMakeRange(0, 32)];
        _chainCode  = [hmac subdataWithRange:NSMakeRange(32, 32)];
        _publicKey = [self generatePublicKeyWithPrivateKey: _privateKey compression: true];
    }
    return self;
}

- (NSString *) getEncPrivateKey {
    if ([Tools isEmpty : _privateKey]) {
        return nil;
    }
    return [self encPrivateKey : _privateKey];
}

- (NSString *) encPrivateKey : (NSData *) rawPrivKey {
    uint8_t buf[rawPrivKey.length + 9];
    buf[0] = 0xDA;
    buf[1] = 0x37;
    buf[2] = 0x9F;
    buf[3] = 0x01;
    const uint8_t *rawPriv = [rawPrivKey bytes];
    memcpy(&buf[4], rawPriv, 32);
    buf[36] = 0x00;
    NSData *hash1 = [Hash sha256: [NSData dataWithBytes: buf length : 37]];
    NSData *hash2 = [Hash sha256: hash1];
    const uint8_t *hash = [hash2 bytes];
    memcpy(&buf[37], hash, 4);
    return [[Base58 new] encode: [NSData dataWithBytes: buf length: 41]];
}

- (NSString *) encPublicKey : (NSData *) rawPubKey {
    uint8_t buf[rawPubKey.length + 6];
    buf[0] = 0xB0;
    buf[1] = 0x01;
    const uint8_t *rawPub = [rawPubKey bytes];
    memcpy(&buf[2], rawPub, 32);
    NSData *hash1 = [Hash sha256: [NSData dataWithBytes: buf length : 34]];
    NSData *hash2 = [Hash sha256: hash1];
    const uint8_t *hash = [hash2 bytes];
    memcpy(&buf[34], hash, 4);
    return [Tools dataToHexStr:[NSData dataWithBytes: buf length: 38]];
}

- (BUChainKey*) derivedKeychainWithPath:(NSString*)path {
    
    if (path == nil) return nil;
    
    if ([path isEqualToString:@"m"] ||
        [path isEqualToString:@"M"] ||
        [path isEqualToString:@"/"] ||
        [path isEqualToString:@""]) {
        return self;
    }
    
    BUChainKey* kc = self;
    
    if ([path rangeOfString:@"m/"].location == 0 || [path rangeOfString:@"M/"].location == 0) { // strip "m/" from the beginning.
        path = [path substringFromIndex:2];
    }
    for (NSString* chunk in [path componentsSeparatedByString:@"/"]) {
        if (chunk.length == 0) {
            continue;
        }
        BOOL hardened = NO;
        NSString* indexString = chunk;
        if ([chunk rangeOfString:@"'"].location == chunk.length - 1 || [chunk rangeOfString:@"H"].location == chunk.length - 1) {
            hardened = YES;
            indexString = [chunk substringToIndex:chunk.length - 1];
        }
        
        // Make sure the chunk is just a number
        NSInteger i = [indexString integerValue];
        if (i >= 0 && [@(i).stringValue isEqualToString:indexString]) {
            kc = [kc derivedKeychainAtIndex:(uint32_t)i hardened:hardened];
        } else {
            return nil;
        }
    }
    return kc;
}

- (BUChainKey*) derivedKeychainAtIndex:(uint32_t)index hardened:(BOOL)hardened {
    BN_CTX *ctx = BN_CTX_new();
    
    NSMutableData *data = [NSMutableData data];
    if (hardened) {
        uint8_t padding = 0;
        [data appendBytes:&padding length:1];
        [data appendData:self.privateKey];
    } else {
        [data appendData:self.publicKey];
    }
    
    BUChainKey* derivedKeychain = [[BUChainKey alloc] init];
    
    uint32_t childIndex = OSSwapHostToBigInt32(hardened ? (0x80000000 | index) : index);
    [data appendBytes:&childIndex length:sizeof(childIndex)];
    
    NSData *digest = [Hash hmacSHA512WithKey:data :_chainCode];
    NSData *derivedPrivateKey = [digest subdataWithRange:NSMakeRange(0, 32)];
    
    BIGNUM *curveOrder = BN_new();
    BN_hex2bn(&curveOrder, "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141");
    
    BIGNUM *factor = BN_new();
    BN_bin2bn(derivedPrivateKey.bytes, (int)derivedPrivateKey.length, factor);
    // Factor is too big, this derivation is invalid.
    if (BN_cmp(factor, curveOrder) >= 0) {
        return nil;
    }
    
    derivedKeychain.chainCode = [digest subdataWithRange:NSMakeRange(32, 32)];
    
    NSMutableData *result;
    if (self.privateKey) {
        BIGNUM *privateKey = BN_new();
        BN_bin2bn(self.privateKey.bytes, (int)self.privateKey.length, privateKey);
        
        BN_mod_add(privateKey, privateKey, factor, curveOrder, ctx);
        // Check for invalid derivation.
        if (BN_is_zero(privateKey)) {
            return nil;
        }
        
        int numBytes = BN_num_bytes(privateKey);
        result = [NSMutableData dataWithLength:numBytes];
        BN_bn2bin(privateKey, result.mutableBytes);
        derivedKeychain.privateKey = [result copy];
        derivedKeychain.publicKey = [self generatePublicKeyWithPrivateKey: derivedKeychain.privateKey compression: true];
        BN_free(privateKey);
    } else {
        BIGNUM *publicKey = BN_new();
        BN_bin2bn(self.publicKey.bytes, (int)self.publicKey.length, publicKey);
        EC_GROUP *group = EC_GROUP_new_by_curve_name(NID_secp256k1);
        
        EC_POINT *point = EC_POINT_new(group);
        EC_POINT_bn2point(group, publicKey, point, ctx);
        EC_POINT_mul(group, point, factor, point, BN_value_one(), ctx);
        // Check for invalid derivation.
        if (EC_POINT_is_at_infinity(group, point) == 1) {
            return nil;
        }
        
        BIGNUM *n = BN_new();
        result = [NSMutableData dataWithLength:33];
        
        EC_POINT_point2bn(group, point, POINT_CONVERSION_COMPRESSED, n, ctx);
        BN_bn2bin(n, result.mutableBytes);
        derivedKeychain.publicKey = [result copy];
        
        BN_free(n);
        BN_free(publicKey);
        EC_POINT_free(point);
        EC_GROUP_free(group);
    }
    
    BN_free(factor);
    BN_free(curveOrder);
    BN_CTX_free(ctx);
    
    derivedKeychain.depth = _depth + 1;
    derivedKeychain.parentFingerprint = self.fingerprint;
    derivedKeychain.index = childIndex;
    derivedKeychain.hardened = hardened;

    return derivedKeychain;
}

- (NSData *)generatePublicKeyWithPrivateKey:(NSData *)privateKeyData compression:(BOOL)isCompression {
    BN_CTX *ctx = BN_CTX_new();
    EC_KEY *key = EC_KEY_new_by_curve_name(NID_secp256k1);
    const EC_GROUP *group = EC_KEY_get0_group(key);
    
    BIGNUM *prv = BN_new();
    BN_bin2bn(privateKeyData.bytes, (int)privateKeyData.length, prv);
    
    EC_POINT *pub = EC_POINT_new(group);
    EC_POINT_mul(group, pub, prv, nil, nil, ctx);
    EC_KEY_set_private_key(key, prv);
    EC_KEY_set_public_key(key, pub);
    
    NSMutableData *result;
    if (isCompression) {
        EC_KEY_set_conv_form(key, POINT_CONVERSION_COMPRESSED);
        unsigned char *bytes = NULL;
        int length = i2o_ECPublicKey(key, &bytes);
        result = [NSMutableData dataWithBytesNoCopy:bytes length:length];
    } else {
        result = [NSMutableData dataWithLength:65];
        BIGNUM *n = BN_new();
        EC_POINT_point2bn(group, pub, POINT_CONVERSION_UNCOMPRESSED, n, ctx);
        BN_bn2bin(n, result.mutableBytes);
        BN_free(n);
    }
    
    BN_free(prv);
    EC_POINT_free(pub);
    EC_KEY_free(key);
    BN_CTX_free(ctx);
    
    return result;
}
@end
