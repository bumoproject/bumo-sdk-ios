//
//  ContractInvokeByAssetOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractInvokeByAssetOperation.h"

@implementation ContractInvokeByAssetOperation
- (instancetype)init {
    _operationType = CONTRACT_INVOKE_BY_ASSET;
    return [super init];
}

- (void) setContractAddress : (NSString *) contractAddress {
    _contractAddress = contractAddress;
}
- (NSString *) getContractAddress {
    return _contractAddress;
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

- (void) setInput : (NSString *) input {
    _input = input;
}
- (NSString *) getInput {
    return _input;
}
@end
