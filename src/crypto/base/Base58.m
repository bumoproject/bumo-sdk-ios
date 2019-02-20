//
//  Base58.m
//  examples
//
//  Created by riven on 2018/8/17.
//  Copyright © 2018 dlx. All rights reserved.
//

#import "Base58.h"

@implementation Base58
- (instancetype)init {
    _alphabet = @"123456789AbCDEFGHJKLMNPQRSTuVWXYZaBcdefghijkmnopqrstUvwxyz";
    _base256 = @"256";
    _base58 = [NSString stringWithFormat: @"%lu", (unsigned long)[_alphabet length]];
    unsigned char* index = (unsigned char*)malloc(128);
    for (int i = 0; i < 128; i++) {
        index[i] = -1;
    }
    NSData *alphabet = [_alphabet dataUsingEncoding: NSUTF8StringEncoding];
    const unsigned char* calphabet = [alphabet bytes];
    for (int i = 0; i < _alphabet.length; i++) {
        index[calphabet[i]] = i;
    }
    _index = [[NSData alloc] initWithBytes: index length: 128];
    free(index);
    return [super init];
}

- (uint8_t) divmo58 : (NSData **) input : (NSUInteger) startAt {
    int32_t remainder = 0;
    uint8_t* usInput = (uint8_t*)[*input bytes];
    for (NSUInteger i = startAt; i < (*input).length; i++) {
        int32_t digit256 = (int32_t)usInput[i] & 0xFF;
        int32_t temp = remainder * [_base256 intValue] + digit256;
        usInput[i] = (uint8_t)(temp / [_base58 intValue]);
        remainder = temp % [_base58 intValue];
    }
    *input = [[NSData alloc] initWithBytes: usInput length: (*input).length];
    return (uint8_t)remainder;
}

- (uint8_t) divmod256 : (NSData **)input : (NSUInteger) startAt {
    int32_t remainder = 0;
    uint8_t* usInput = (uint8_t*)[*input bytes];
    for (NSUInteger i = startAt; i < (*input).length; i++) {
        int32_t digit58 = (int32_t)usInput[i] & 0xFF;
        int32_t temp = remainder * [_base58 intValue] + digit58;
        usInput[i] = (uint8_t)(temp / [_base256 intValue]);
        remainder = temp % [_base256 intValue];
    }
    *input = [[NSData alloc] initWithBytes: usInput length: (*input).length];
    return (uint8_t)remainder;
}

- (NSString *) encode : (NSData *) data {
    if (0 == [data length]) {
        return nil;
    }
    NSData *alphabet = [_alphabet dataUsingEncoding: NSUTF8StringEncoding];
    const uint8_t* calphabet = [alphabet bytes];
    NSData *input = [data copy];
    int32_t zeroCount = 0;
    const uint8_t* usInput = [input bytes];
    while (zeroCount < input.length && usInput[zeroCount] == 0) {
        ++zeroCount;
    }
    NSUInteger j = input.length * 2;
    uint8_t temp[j];
    
    NSUInteger startAt = zeroCount;
    while (startAt < input.length) {
        uint8_t mod = [self divmo58: &input : startAt];
        const uint8_t* usInput = [input bytes];
        if (usInput[startAt] == 0) {
            ++startAt;
        }
        temp[--j] = calphabet[mod];
    }
    while (j < input.length * 2 && temp[j] == calphabet[0]) {
        ++j;
    }
    while (--zeroCount >= 0) {
        temp[--j] = calphabet[0];
    }
    
    return [[NSString alloc] initWithBytes: &temp[j] length: (input.length * 2 - j) encoding: NSUTF8StringEncoding];
}

- (NSData *) decode : (NSString *) data {
    if (0 == [data length]) {
        return nil;
    }
    
    NSData *input = [data dataUsingEncoding: NSUTF8StringEncoding];
    const uint8_t* ucInput = [input bytes];
    uint8_t* input58 = (uint8_t*)malloc([input length]);
    const uint8_t* index = [_index bytes];
    for (NSInteger i = 0; i < [input length]; i++) {
        char c = ucInput[i];
        
        int digit58 = -1;
        if (c > 0) {
            digit58 = index[c];
        }
        if (digit58 < 0) {
            return nil;
        }
        input58[i] = (uint8_t)digit58;
    }
    int zeroCount = 0;
    while (zeroCount < input.length && input58[zeroCount] == 0) {
        ++zeroCount;
    }
    NSUInteger j = [input length];
    uint8_t temp[j];
    
    int startAt = zeroCount;
    NSData *base58Data = [[NSData alloc] initWithBytes: input58 length:[input length]];
    while (startAt < base58Data.length) {
        uint8_t mod = [self divmod256: &base58Data : startAt];
        const uint8_t* usInput = [base58Data bytes];
        if (usInput[startAt] == 0) {
            ++startAt;
        }
        temp[--j] = mod;
    }
    
    while (j < [base58Data length] && temp[j] == 0) {
        ++j;
    }
    
    return [[NSData alloc] initWithBytes: &temp[j - zeroCount] length: ([base58Data length] - j + zeroCount)];
}
@end
