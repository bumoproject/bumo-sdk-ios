//
//  ContractInvokeByBUOperation.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@interface ContractInvokeByBUOperation : BaseOperation {
@private
    NSString *_contractAddress;
    int64_t _amount;
    NSString *_input;
}

- (void) setContractAddress : (NSString *) contractAddress;
- (NSString *) getContractAddress;

- (void) setAmount : (int64_t) amount;
- (int64_t) getAmount;

- (void) setInput : (NSString *) input;
- (NSString *) getInput;
@end
