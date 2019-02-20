//
//  TransactionEnv.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionEnvInfo.h"
#import "YYModelClass.h"

@implementation TransactionEnvInfo
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"transaction" : TransactionInfo.class,
             @"trigger" : TransactionInfo.class};
}
@end
