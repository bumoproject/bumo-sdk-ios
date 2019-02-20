//
//  Tools.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/1.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Tools.h"
#import <CommonCrypto/CommonHMAC.h>
#import "PrivateKey.h"
#import "my_crypto.h"
#import "SDKError.h"
#import "SDKException.h"

@implementation Tools
+ (BOOL) isEmpty: (id) thing {
    return thing == nil
    || [thing isKindOfClass:[NSNull class]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

+ (BOOL) isPrivateKeyValid : (NSString *) privateKey {
    BOOL isVaid = false;
    if (![Tools isEmpty : privateKey]) {
        std::string privateKeyStr([privateKey UTF8String]);
        PrivateKey privKey;
        if (privKey.From(privateKeyStr)) {
            isVaid = true;
        }
    }
    return isVaid;
}

+ (BOOL) isAddressValid : (NSString *) address {
    BOOL isValid = false;
    if (![Tools isEmpty:address]) {
        std::string addr([address UTF8String]);
        if (PublicKey::IsAddressValid(addr)) {
            isValid = true;
        }
    }
    return isValid;
}

+ (NSDictionary *) createAccount {
    PrivateKey privKey;
    NSString *privateKey = [NSString stringWithCString:privKey.GetEncPrivateKey().c_str() encoding:[NSString defaultCStringEncoding]];
    NSString *publicKey = [NSString stringWithCString:privKey.GetEncPublicKey().c_str() encoding:[NSString defaultCStringEncoding]];
    NSString *address = [NSString stringWithCString:privKey.GetEncAddress().c_str() encoding:[NSString defaultCStringEncoding]];
    return [[NSDictionary alloc] initWithObjectsAndKeys:privateKey, @"privateKey", publicKey, @"publicKey", address, @"address", nil];
}

+ (NSString *) sign : (NSString *) privateKey : (NSData *) data {
    const char *value = (const char *)[data bytes];
    std::string valueStr(value, [data length]);
    std::string privateKeyStr([privateKey UTF8String]);
    PrivateKey privKey;
    if (!privKey.From(privateKeyStr)) {
        return nil;
    }
    std::string sign = privKey.Sign(valueStr);
    std::string signHexStr = utils::String::BinToHexString(sign);
    NSString *signHex = [NSString stringWithCString : signHexStr.c_str() encoding : [NSString defaultCStringEncoding]];
    return signHex;
}

+ (NSString *) getPublicKey : (NSString *) privateKey {
    std::string privateKeyStr([privateKey UTF8String]);
    PrivateKey privKey;
    if (!privKey.From(privateKeyStr)) {
        return nil;
    }
    std::string publicKeyStr = privKey.GetEncPublicKey();
    NSString *publicKey = [NSString stringWithCString : publicKeyStr.c_str() encoding : [NSString defaultCStringEncoding]];
    return publicKey;
}

+ (NSData *) hexStrToData:(NSString *) hexStr {
    if (!hexStr || [hexStr length] == 0) {
        return nil;
    }
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([hexStr length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [hexStr length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [hexStr substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [data appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return data;
}

+ (NSString *) dataToHexStr : (NSData *) data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *hexStr = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexByte = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexByte length] == 2) {
                [hexStr appendString:hexByte];
            } else {
                [hexStr appendFormat:@"0%@", hexByte];
            }
        }
    }];
    
    return hexStr;
}

+ (NSArray *) dataToBitArray : (NSData *)hexData {
    NSMutableArray *bitArray = [NSMutableArray arrayWithCapacity:(int)hexData.length * 8];
    NSString *hexStr = [self dataToHexStr: hexData];
    
    for(NSUInteger i = 0 ; i < [hexStr length] ; i++)
    {
        NSString *bin = [self hexCharToBinary:[hexStr characterAtIndex:i]];
        
        for(NSUInteger j = 0 ; j < bin.length ; j++)
        {
            [bitArray addObject:@([[NSString stringWithFormat:@"%C",[bin characterAtIndex:j]] intValue])];
        }
    }
    
    return [NSArray arrayWithArray:bitArray];
}

+ (NSString *) generateHashHex : (NSData *) data {
    const char *value = (const char *)[data bytes];
    std::string valueStr(value, [data length]);
    std::string hash = utils::Sha256::Crypto(valueStr);
    std::string hashHexStr = utils::String::BinToHexString(hash);
    NSString *hashHex = [NSString stringWithCString : hashHexStr.c_str() encoding : [NSString defaultCStringEncoding]];
    return hashHex;
}

+ (BOOL) regexMatch : (NSString *) pattern : (NSString *) message : (NSError **) error {
    BOOL isMatch = false;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern : pattern options : 0 error : error];
    if (![Tools isEmpty : *error]) {
        return false;
    }
    NSArray *results = [regex matchesInString : message options : 0 range : NSMakeRange(0, message.length)];
    if (results.count > 0) {
        isMatch = true;
    }
    return isMatch;
}

/**
 * @author riven
 * @param amountWithoutDecimals The amount without decimals, that must be a number smaller than LONG.MAX_VALUE
 * @param decimals The decimals, that should be bigger than and equal to 0 and should be smaller than 19
 * @return The amount with decimals, which means that amountWithDecimals * 10 ^ decimals
 * @date 2018/12/13 16:00
 */
+ (NSDecimalNumber *) unitWithDecimals : (NSString *)amountWithoutDecimals : (int) decimals {
    if (decimals < 0 || decimals > 18) {
        return nil;
    }
    NSString *regex = [NSString stringWithFormat: @"(^0(\\.[0-9]{0,%d}[1-9])?$)|(^[1-9][0-9]{0,%d}(\\.[0-9]{0,%d}[1-9])?$)", decimals - 1, 18 - decimals, decimals - 1];
    NSError *error = nil;
    BOOL match = [Tools regexMatch:regex :amountWithoutDecimals :&error];
    if (![Tools isEmpty : error] || !match) {
        return nil;
    }
    
    NSDecimalNumber *uint = [NSDecimalNumber decimalNumberWithString:amountWithoutDecimals];
    NSDecimalNumber *dec = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",1]] decimalNumberByMultiplyingByPowerOf10: decimals];
    
    NSDecimalNumber *num = [uint decimalNumberByMultiplyingBy:dec];
    if ([num compare: [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lld",INT64_MAX]]] == NSOrderedDescending) {
        return nil;
    }
    
    return num;
}

/**
 * @author riven
 * @param amountWithDecimals The amount without decimals
 * @param decimals The decimals, that cannot be bigger than 18
 * @return The amount with decimals, which means that amountWithDecimals * 10 ^ decimals, but should be bigger than LONG.MAX_VALUE
 * @date 2018/12/13 16:00
 */
+ (NSDecimalNumber *)unitWithoutDecimals : (NSString *)amountWithDecimals : (int) decimals {
    if (decimals < 0 || decimals > 18) {
        return nil;
    }
    NSString *regex = [NSString stringWithFormat: @"(^0?$)|(^[1-9][0-9]{0,18}?$)"];
    NSError *error = nil;
    BOOL match = [Tools regexMatch:regex :amountWithDecimals :&error];
    if (![Tools isEmpty : error] || !match) {
        return nil;
    }
    if ([amountWithDecimals compare: [NSString stringWithFormat: @"%lld", INT64_MAX]] > 0) {
        return nil;
    }
    NSDecimalNumber *uint = [NSDecimalNumber decimalNumberWithString:amountWithDecimals];
    NSDecimalNumber *dec = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",1]] decimalNumberByMultiplyingByPowerOf10: decimals];
    
    NSDecimalNumber *num = [uint decimalNumberByDividingBy:dec];
    return num;
}

+ (NSDecimalNumber *) MO2BU : (NSString *) mo {
    return  [Tools unitWithoutDecimals:mo :8];
}
+ (NSDecimalNumber *) BU2MO : (NSString *) bu {
    return  [Tools unitWithDecimals:bu :8];
}

+ (NSString *)hexCharToBinary: (unichar) hexChar {
    switch (hexChar)
    {
        case '0': return @"0000";
        case '1': return @"0001";
        case '2': return @"0010";
        case '3': return @"0011";
        case '4': return @"0100";
        case '5': return @"0101";
        case '6': return @"0110";
        case '7': return @"0111";
        case '8': return @"1000";
        case '9': return @"1001";
        case 'a':
        case 'A':
            return @"1010";
        case 'b':
        case 'B':
            return @"1011";
        case 'c':
        case 'C':
            return @"1100";
        case 'd':
        case 'D':
            return @"1101";
        case 'e':
        case 'E':
            return @"1110";
        case 'f':
        case 'F':
            return @"1111";
    }
    return @"-1";
}
@end
