//
//  SDK.m
//  sdk-ios
//
//  Created by dxl on 2018/8/8.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "KeyStore.h"
#import "libscrypt.h"
#import "random.h"
#import "PrivateKey.h"
#import "my_crypto.h"
#import "Tools.h"
#import "Hash.h"


@implementation KeyStore

/*
 {
 "version" : 1,
 "scrypt_params" : {"n": 16384, "p": 8, "r" : 1,"salt" :"1234"},
 "aes128ctr_iv" : "",
 "cypher_text": ""
 }
 */
+ (KeyStoreEty *) generateKeyStoreFromData: (NSData *) password Data: (NSData *) data : (int32_t) version{
    return [self generateKeyStoreFromData: password Data: data : 16384 : 8 : 1 : version];
}

+ (KeyStoreEty *) generateKeyStoreFromData: (NSData *) password Data: (NSData *) data : (uint64_t) n : (uint32_t) r : (uint32_t) p : (int32_t) version {
    KeyStoreEty *keyStoreEty = [self keyStoreEncipher:password Data:data :n :r :p :version];
    if ([Tools isEmpty: keyStoreEty]) {
        return nil;
    }
    keyStoreEty.address = [Tools dataToHexStr: [Hash sha256: data]];
    return keyStoreEty;
}

+ (NSData *) decipherKeyStoreWithData: (KeyStoreEty *) keyStore : (NSData *) password {
    NSData *data = [self keyStoreDecipher:keyStore :password];
    if ([Tools isEmpty: data]) {
        return nil;
    }
    NSString *checkSum = [Tools dataToHexStr: [Hash sha256: data]];
    if ([keyStore.address compare: checkSum] != NSOrderedSame) {
        return nil;
    }
    
    return data;
}

/*
 {
 "version" : 1,
 "scrypt_params" : {"n": 16384, "p": 8, "r" : 1,"salt" :"1234"},
 "aes128ctr_iv" : "",
 "cypher_text": ""
 }
 */
+ (KeyStoreEty *) generateKeyStore: (NSData *) password PrivateKey: (NSString *) newPrivKey : (int32_t) version {
    return [self generateKeyStore: password PrivateKey: newPrivKey : 16384 : 8 : 1 : version];
}

+ (KeyStoreEty *) generateKeyStore: (NSData *) password PrivateKey: (NSString *) privateKey : (uint64_t) n : (uint32_t) r : (uint32_t) p : (int32_t) version {
    std::string newPrivateKey;
    std::string address;
    if ([Tools isEmpty: privateKey]) {
        PrivateKey priv_key;
        if (!priv_key.IsValid()) {
            return nil;
        }
        newPrivateKey = priv_key.GetEncPrivateKey();
        address = priv_key.GetEncAddress();
    }
    else {
        newPrivateKey = std::string([privateKey UTF8String]);
        PrivateKey priv_key;
        if (!priv_key.From(newPrivateKey)) {
            return nil;
        }
        address = priv_key.GetEncAddress();
    }
    NSData *data = [[NSData alloc] initWithBytes: newPrivateKey.c_str() length: newPrivateKey.length()];
    KeyStoreEty *keyStoreEty = (KeyStoreEty *)[self generateKeyStoreFromData: password Data: data : n : r : p : version];
    if ([Tools isEmpty: keyStoreEty]) {
        return nil;
    }
    keyStoreEty.address = [NSString stringWithCString : address.c_str() encoding : [NSString defaultCStringEncoding]];
    return keyStoreEty;
}

+ (NSString *) decipherKeyStore: (KeyStoreEty *) key_store : (NSData *) password {
    NSData *data = [self keyStoreDecipher : key_store : password];
    if ([Tools isEmpty: data]) {
        return nil;
    }
    std::string priv_key_de((const char *)data.bytes, data.length);
    std::string address([key_store.address UTF8String]);
    
    PrivateKey key(priv_key_de);
    if (!key.IsValid()){
        return nil;
    }
    if (key.GetEncAddress().compare(address) != 0){
        return nil;
    }
    NSString *priv_key = [NSString stringWithCString : priv_key_de.c_str() encoding : [NSString defaultCStringEncoding]];
    return priv_key;
}

+ (KeyStoreEty *) keyStoreEncipher : (NSData *) password Data: (NSData *) data : (uint64_t) n : (uint32_t) r : (uint32_t) p : (int32_t) version {
    if ([Tools isEmpty: password]) {
        return nil;
    }
    if ([Tools isEmpty: data]) {
        return nil;
    }
    
    //Produce 256 bit random.
    std::string salt;
    utils::GetStrongRandBytes(salt);
    
    std::string aes_iv;
    utils::GetStrongRandBytes(aes_iv);
    aes_iv.resize(16);
    
    std::string dk;
    dk.resize(32);
    libscrypt_scrypt((uint8_t *)password.bytes, password.length, (uint8_t *)salt.c_str(), salt.size(), n, r, p, (uint8_t *)dk.c_str(), dk.size());
    
    utils::AesCtr aes((uint8_t *)aes_iv.c_str(), dk);
    
    std::string cyper_text;
    const char *value = (const char *)[data bytes];
    std::string valueStr(value, [data length]);
    aes.Encrypt(valueStr, cyper_text);
    
    KeyStoreEty *keyStoreEty = [KeyStoreEty new];
    keyStoreEty.version = version;
    keyStoreEty.aesctrIv = [Tools dataToHexStr: [NSData dataWithBytes:aes_iv.c_str() length:aes_iv.length()]];
    keyStoreEty.cypherText = [Tools dataToHexStr: [NSData dataWithBytes:cyper_text.c_str() length:cyper_text.length()]];
    ScryptParamsEty *scryptParams = [ScryptParamsEty new];
    scryptParams.n = n;
    scryptParams.p = p;
    scryptParams.r = r;
    scryptParams.salt = [Tools dataToHexStr: [NSData dataWithBytes:salt.c_str() length:salt.length()]];
    keyStoreEty.scryptParams = scryptParams;
    return keyStoreEty;
}

+ (NSData *) keyStoreDecipher:(KeyStoreEty *) keyStore :(NSData *) password {
    if ([Tools isEmpty: keyStore]) {
        return nil;
    }
    
    int32_t version = keyStore.version;
    ScryptParamsEty *scryptParams = keyStore.scryptParams;
    uint64_t n = scryptParams.n;
    uint32_t r = scryptParams.r;
    uint32_t p = scryptParams.p;
    NSData *saltData = [Tools hexStrToData: scryptParams.salt];
    std::string salt((const char *)saltData.bytes, saltData.length);
    
    std::string aes_iv;
    int32_t nkeylen = 16;
    if (version == 1) {
        NSData *aesIvData = [Tools hexStrToData: keyStore.aes128ctrIv];
        aes_iv = std::string((const char *)aesIvData.bytes, aesIvData.length);
        nkeylen = 16;
    }
    else if (version == 2) {
        NSData *aesIvData = [Tools hexStrToData: keyStore.aesctrIv];
        aes_iv = std::string((const char *)aesIvData.bytes, aesIvData.length);
        nkeylen = 32;
    }
    NSData *cypherTextData = [Tools hexStrToData: keyStore.cypherText];
    std::string cypher_text((const char *)cypherTextData.bytes, cypherTextData.length);
    
    if (aes_iv.size() != 16){
        return nil;
    }
    
    std::string dk;
    dk.resize(32);
    int32_t ret = libscrypt_scrypt((uint8_t *)password.bytes, password.length, (uint8_t *)salt.c_str(), salt.size(), n, r, p, (uint8_t *)dk.c_str(), dk.size());
    if (ret != 0 ){
        return nil;
    }
    
    dk.resize(nkeylen);
    utils::AesCtr aes((uint8_t *)aes_iv.c_str(), dk);
    std::string dataStr;
    aes.Encrypt(cypher_text, dataStr);
    if (dataStr.empty()) {
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBytes: dataStr.c_str() length: dataStr.length()];
    return data;
}
@end
