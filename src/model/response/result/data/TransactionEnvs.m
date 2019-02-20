//
//  TransactionEnvs.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionEnvs.h"
#import "YYModelClass.h"

@implementation TransactionEnvs
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"transactionEnv" : @"transaction_env"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"transactionEnv" : TransactionEnvInfo.class};
}
@end
