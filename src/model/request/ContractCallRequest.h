//
//  ContractCallRequest.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContractCallRequest : NSObject {
@private
    NSString *_sourceAddress;
    NSString *_contractAddress;
    NSString *_code;
    NSString *_input;
    int64_t _contractBalance;
    int32_t _optType;
    int64_t _feeLimit;
    int64_t _gasPrice;
}

- (void) setSourceAddress : (NSString *)sourceAddress;
- (NSString *) getSourceAddress;

- (void) setContractAddress : (NSString *) contractAddress;
- (NSString *) getContractAddress;

- (void) setCode : (NSString *)code;
- (NSString *) getCode;

- (void) setInput : (NSString *)input;
- (NSString *) getInput;

- (void) setContractBalance : (int64_t) contractBalance;
- (int64_t) getContractBalance;

- (void) setOptType : (int32_t) optType;
- (int32_t) getOptType;

- (void) setGasPrice : (int64_t) gasPrice;
- (int64_t) getGasPrice;

- (void) setFeeLimit : (int64_t) feeLimit;
- (int64_t) getFeeLimit;

@end
