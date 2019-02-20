//
//  Keypair.m
//  sdk-ios
//
//  Created by riven on 2018/8/18.
//  Copyright © 2018 dlx. All rights reserved.
//

#import "Keypair.h"
#import "ed25519.h"
#import "Tools.h"
#import "Hash.h"
#import "Base58.h"

@implementation Keypair

- (instancetype)init {
    NSMutableData* randomBytes = [NSMutableData dataWithLength:32];
    int err = 0;
    err = SecRandomCopyBytes(kSecRandomDefault,32,[randomBytes mutableBytes]);
    if(err != noErr && [randomBytes length] != 32) {
        @throw [NSException exceptionWithName:@"random problem" reason:@"problem generating the random " userInfo:nil];
    }
    _privateKey = [NSData dataWithData:randomBytes];
    uint8_t rawPublicKey[33] = { 0 };
    memset(rawPublicKey, 0, 33);
    ed25519_publickey((const unsigned char*)[_privateKey bytes], (unsigned char*)rawPublicKey);
    _publicKey = [NSData dataWithBytes: rawPublicKey length: 32];
    return [super init];
}

- (instancetype)initWithData : (NSData *)data {
    if (data.length == 32) {
        _privateKey = [NSData dataWithData:data];
        uint8_t rawPublicKey[33] = { 0 };
        memset(rawPublicKey, 0, 33);
        ed25519_publickey((const unsigned char*)[_privateKey bytes], (unsigned char*)rawPublicKey);
        _publicKey = [NSData dataWithBytes: rawPublicKey length: 32];
    }
    return self;
}

- (NSString *) getEncPrivateKey {
    if ([Tools isEmpty : _privateKey]) {
        return nil;
    }
    return [Keypair encPrivateKey : _privateKey];
}
- (NSString *) getEncPublicKey {
    if ([Tools isEmpty : _publicKey]) {
        return nil;
    }
    return [Keypair encPublicKey : _publicKey];
}
- (NSString *) getEncAddress {
    if ([Tools isEmpty : _publicKey]) {
        return nil;
    }
    return [Keypair encAddress : _publicKey];
}
- (NSData *) sign : (NSData *) data {
    uint8_t sig[65] = { 0 };
    memset(sig, 0, 65);
    uint8_t* input = (uint8_t*)[data bytes];
    ed25519_sign((unsigned char *)input, [data length], (const unsigned char*)[_privateKey bytes], (unsigned char*)[_publicKey bytes], sig);
    return [NSData dataWithBytes: sig length: 64];
}

- (BOOL) verify : (NSData *)signature : (NSData *)data {
    return ed25519_sign_open((unsigned char *)[data bytes], [data length], (unsigned char *)[_publicKey bytes], (unsigned char *)[signature bytes]) == 0;
}

+ (NSString *) getEncPublicKey : (NSString *) privateKey {
    NSData *rawPrivateKey = [self decodePrivateKey : privateKey];
    if ([Tools isEmpty: rawPrivateKey]) {
        return nil;
    }
    uint8_t rawPublicKey[33] = {0};
    memset(rawPublicKey, 0, 33);
    ed25519_publickey((const unsigned char*)rawPrivateKey.bytes, (unsigned char*)rawPublicKey);
    return [Keypair encPublicKey:[NSData dataWithBytes: rawPublicKey length: 32]];
}

+ (NSString *) getEncAddress : (NSString *) publicKey {
    NSData *rawPublicKey = [self decodePublicKey: publicKey];
    if ([Tools isEmpty: rawPublicKey]) {
        return nil;
    }
    
    return [Keypair encAddress: rawPublicKey];
}

+ (NSString *) getEncAddressFromPrivateKey : (NSString *) privateKey {
    NSData *rawPrivateKey = [self decodePrivateKey : privateKey];
    if ([Tools isEmpty: rawPrivateKey]) {
        return nil;
    }
    uint8_t rawPublicKey[33] = {0};
    memset(rawPublicKey, 0, 33);
    ed25519_publickey((const unsigned char*)rawPrivateKey.bytes, (unsigned char*)rawPublicKey);
    NSData *rawPubKey = [NSData dataWithBytes: rawPublicKey length: 32];;
    return [Keypair encAddress : rawPubKey];
}

+ (NSData *) sign : (NSData *) data : (NSString *) privateKey {
    NSData *rawPrivateKey = [self decodePrivateKey : privateKey];
    if ([Tools isEmpty: rawPrivateKey]) {
        return nil;
    }
    uint8_t rawPublicKey[33] = {0};
    memset(rawPublicKey, 0, 33);
    ed25519_publickey((const unsigned char*)rawPrivateKey.bytes, (unsigned char*)rawPublicKey);
    
    uint8_t sig[65] = { 0 };
    memset(sig, 0, 65);
    ed25519_sign((unsigned char *)data.bytes, [data length], (const unsigned char*)rawPrivateKey.bytes, (unsigned char*)rawPublicKey, sig);
    return [NSData dataWithBytes: sig length: 64];
}

+ (BOOL) verify : (NSData *)signature : (NSData *) data : (NSString *) publicKey {
    NSData *rawPublicKey = [self decodePublicKey: publicKey];
    if ([Tools isEmpty: rawPublicKey]) {
        return false;
    }
    return ed25519_sign_open((unsigned char *)[data bytes], [data length], (unsigned char *)rawPublicKey.bytes, (unsigned char *)[signature bytes]) == 0;
}

+ (BOOL) isPrivateKeyValid : (NSString *) privateKey {
    NSData *rawPrivateKey = [self decodePrivateKey : privateKey];
    if ([Tools isEmpty: rawPrivateKey]) {
        return false;
    }
    return true;
}

+ (BOOL) isPublicKeyValid : (NSString *) publicKey {
    NSData *rawPublicKey = [self decodePublicKey: publicKey];
    if ([Tools isEmpty: rawPublicKey]) {
        return false;
    }
    return true;
}

+ (BOOL) isAddressValid : (NSString *) address {
    if ([Tools isEmpty : address]) {
        return false;
    }
    NSData *decodeAddress = [[Base58 new] decode : address];
    const uint8_t *buf = [decodeAddress bytes];
    if (decodeAddress.length != 27 || buf[0] != 0x01 || buf[1] != 0x56 || buf[2] != 0x01) {
        return false;
    }
    uint8_t addressHeader[24];
    memset(addressHeader, 0, 24);
    memcpy(addressHeader, buf, 23);
    NSData *hash1 = [Hash sha256: [NSData dataWithBytes: buf length : 23]];
    NSData *hash2 = [Hash sha256: hash1];
    const uint8_t *hash = [hash2 bytes];
    
    uint8_t checkSum[4];
    memcpy(checkSum, &buf[23], 4);
    if (hash[0] != checkSum[0] || hash[1] != checkSum[1] || hash[2] != checkSum[2] || hash[3] != checkSum[3]) {
        return false;
    }
    
    return true;
}

+ (NSString *) encPrivateKey : (NSData *) rawPrivKey {
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

+ (NSString *) encPublicKey : (NSData *) rawPubKey {
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

+ (NSString *) encAddress : (NSData *) rawPubKey {
    uint8_t buf[27];
    buf[0] = 0x01;
    buf[1] = 0x56;
    buf[2] = 0x01;
    NSData *pubHashData = [Hash sha256: rawPubKey];
    const uint8_t *pubHash = [pubHashData bytes];
    memcpy(&buf[3], &pubHash[12], 20);
    NSData *hash1 = [Hash sha256: [NSData dataWithBytes: buf length : 23]];
    NSData *hash2 = [Hash sha256: hash1];
    const uint8_t *hash = [hash2 bytes];
    memcpy(&buf[23], hash, 4);
    return [[Base58 new] encode: [NSData dataWithBytes: buf length: 27]];
}

+ (NSData *)decodePrivateKey : (NSString *)encPrivateKey {
    if ([Tools isEmpty : encPrivateKey]) {
        return nil;
    }
    NSData *decodePrivateKey = [[Base58 new] decode : encPrivateKey];
    const uint8_t *buf = [decodePrivateKey bytes];
    if (decodePrivateKey.length != 41 || buf[0] != 0xDA || buf[1] != 0x37 || buf[2] != 0x9F || buf[3] != 0x01 || buf[36] != 0x00) {
        return nil;
    }
    uint8_t rawPrivHeader[38];
    memset(rawPrivHeader, 0, 38);
    memcpy(rawPrivHeader, buf, 37);
    NSData *hash1 = [Hash sha256: [NSData dataWithBytes: rawPrivHeader length : 37]];
    NSData *hash2 = [Hash sha256: hash1];
    const uint8_t *hash = [hash2 bytes];
    
    uint8_t checkSum[5];
    memset(checkSum, 0, 5);
    memcpy(checkSum, &buf[37], 4);
    if (hash[0] != checkSum[0] || hash[1] != checkSum[1] || hash[2] != checkSum[2] || hash[3] != checkSum[3]) {
        return nil;
    }
    
    uint8_t rawPriv[33] = { 0 };
    memset(rawPriv, 0, 33);
    memcpy(rawPriv, &buf[4], 32);
    
    return [NSData dataWithBytes: rawPriv length: 32];
}

+ (NSData *) decodePublicKey : (NSString *) encPublicKey {
    if ([Tools isEmpty : encPublicKey]) {
        return nil;
    }
    NSData *decodePublicKey = [Tools hexStrToData: encPublicKey];
    const uint8_t *buf = [decodePublicKey bytes];
    if (decodePublicKey.length != 38 || buf[0] != 0xb0 || buf[1] != 0x01) {
        return nil;
    }
    
    uint8_t rawPubHeader[35] = { 0 };
    memset(rawPubHeader, 0, 35);
    memcpy(rawPubHeader, buf, 34);
    NSData *hash1 = [Hash sha256: [NSData dataWithBytes: rawPubHeader length : 34]];
    NSData *hash2 = [Hash sha256: hash1];
    const uint8_t *hash = [hash2 bytes];
    
    uint8_t checkSum[5];
    memset(checkSum, 0, 5);
    memcpy(checkSum, &buf[34], 4);
    if (hash[0] != checkSum[0] || hash[1] != checkSum[1] || hash[2] != checkSum[2] || hash[3] != checkSum[3]) {
        return nil;
    }
    
    uint8_t rawPub[33] = { 0 };
    memset(rawPub, 0, 33);
    memcpy(rawPub, &buf[2], 32);
    
    return [NSData dataWithBytes: rawPub length: 32];
}

@end
