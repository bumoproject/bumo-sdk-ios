//
//  ContractCallInput.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContractCallInput : NSObject
@property (nonatomic, copy) NSString *sourceAddress;
@property (nonatomic, copy) NSString *contractAddress;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *input;
@property (nonatomic, assign) int32_t optType;
@property (nonatomic, assign) int64_t contractBalance;
@property (nonatomic, assign) int64_t feeLimit;
@property (nonatomic, assign) int64_t gasPrice;
@end
