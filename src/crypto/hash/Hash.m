//
//  Sha.m
//  sdk-ios
//
//  Created by riven on 2018/8/18.
//  Copyright © 2018 dlx. All rights reserved.
//

#import "Hash.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation Hash

+ (NSData *) md5 : (NSData *) data {
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, digest);
    return [NSData dataWithBytes: digest length: CC_MD5_DIGEST_LENGTH];
}

+ (NSData *) sha224 : (NSData *) data {
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224([data bytes], (CC_LONG)[data length], digest);
    return [NSData dataWithBytes: digest length: CC_SHA224_DIGEST_LENGTH];
}

+ (NSData *) sha256 : (NSData *) data {
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    return [NSData dataWithBytes: digest length: CC_SHA256_DIGEST_LENGTH];
}

+ (NSData *) sha384 : (NSData *) data {
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(data.bytes, (CC_LONG)data.length, digest);
    return [NSData dataWithBytes: digest length: CC_SHA384_DIGEST_LENGTH];
}

+ (NSData *) sha512 : (NSData *) data {
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    return [NSData dataWithBytes: digest length: CC_SHA512_DIGEST_LENGTH];
}

+ (NSData *) hmacMD5WithKey : (NSData *) data : (NSData *) key {
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgMD5, key.bytes, (CC_LONG)key.length, [data bytes], [data length], digest);
    return [NSData dataWithBytes: digest length: CC_MD5_DIGEST_LENGTH];
}

+ (NSData *) hmacSHA1WithKey : (NSData *) data : (NSData *) key {
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, key.bytes, (CC_LONG)key.length, [data bytes], [data length], digest);
    return [NSData dataWithBytes: digest length: CC_SHA1_DIGEST_LENGTH];
}

+ (NSData *) hmacSHA224WithKey : (NSData *) data : (NSData *) key {
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA224, key.bytes, (CC_LONG)key.length, [data bytes], [data length], digest);
    return [NSData dataWithBytes: digest length: CC_SHA224_DIGEST_LENGTH];
}

+ (NSData *) hmacSHA256WithKey : (NSData *) data : (NSData *) key {
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, key.bytes, (CC_LONG)key.length, [data bytes], [data length], digest);
    return [NSData dataWithBytes: digest length: CC_SHA256_DIGEST_LENGTH];
}

+ (NSData *) hmacSHA384WithKey : (NSData *) data : (NSData *) key {
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA384, key.bytes, (CC_LONG)key.length, [data bytes], [data length], digest);
    return [NSData dataWithBytes: digest length: CC_SHA384_DIGEST_LENGTH];
}

+ (NSData *) hmacSHA512WithKey : (NSData *) data : (NSData *) key {
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, key.bytes, (CC_LONG)key.length, [data bytes], [data length], digest);
    return [NSData dataWithBytes: digest length: CC_SHA512_DIGEST_LENGTH];
}

@end
