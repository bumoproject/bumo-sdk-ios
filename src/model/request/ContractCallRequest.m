//
//  ContractCallRequest.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractCallRequest.h"

@implementation ContractCallRequest
- (void) setSourceAddress : (NSString *)sourceAddress {
    _sourceAddress = sourceAddress;
}
- (NSString *) getSourceAddress {
    return _sourceAddress;
}

- (void) setContractAddress : (NSString *) contractAddress {
    _contractAddress = contractAddress;
}
- (NSString *) getContractAddress {
    return _contractAddress;
}

- (void) setCode : (NSString *)code {
    _code = code;
}
- (NSString *) getCode {
    return _code;
}

- (void) setInput : (NSString *)input {
    _input = input;
}
- (NSString *) getInput {
    return _input;
}

- (void) setContractBalance : (int64_t) contractBalance {
    _contractBalance = contractBalance;
}
- (int64_t) getContractBalance {
    return _contractBalance;
}

- (void) setOptType : (int32_t) optType {
    _optType = optType;
}
- (int32_t) getOptType {
    return _optType;
}

- (void) setGasPrice : (int64_t) gasPrice {
    _gasPrice = gasPrice;
}
- (int64_t) getGasPrice {
    return _gasPrice;
}

- (void) setFeeLimit : (int64_t) feeLimit {
    _feeLimit = feeLimit;
}
- (int64_t) getFeeLimit {
    return _feeLimit;
}
@end
