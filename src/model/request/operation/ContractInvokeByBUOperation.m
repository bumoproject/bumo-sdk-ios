//
//  ContractInvokeByBUOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractInvokeByBUOperation.h"

@implementation ContractInvokeByBUOperation
- (instancetype)init {
    _operationType = CONTRACT_INVOKE_BY_BU;
    return [super init];
}

- (void) setContractAddress : (NSString *) contractAddress {
    _contractAddress = contractAddress;
}
- (NSString *) getContractAddress {
    return _contractAddress;
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
