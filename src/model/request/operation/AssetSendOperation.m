//
//  AssetSendOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AssetSendOperation.h"

@implementation AssetSendOperation

- (instancetype)init {
    _operationType = ASSET_SEND;
    return [super init];
}

- (void) setDestAddress : (NSString *) destAddress {
    _destAddress = destAddress;
}
- (NSString *) getDestAddress {
    return _destAddress;
}

- (void) setCode : (NSString *) code {
    _code = code;
}
- (NSString *) getCode {
    return _code;
}

- (void) setIssuer : (NSString *) issuer {
    _issuer = issuer;
}
- (NSString *) getIssuer {
    return _issuer;
}

- (void) setAmount : (int64_t) amount {
    _amount = amount;
}
- (int64_t) getAmount {
    return _amount;
}

@end
