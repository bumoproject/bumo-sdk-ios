//
//  TransactionEnv.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionInfo.h"
#import "ContractTrigger.h"

@interface TransactionEnvInfo : NSObject
@property (nonatomic, strong) TransactionInfo *transaction;
@property (nonatomic, strong) ContractTrigger *trigger;
@end
