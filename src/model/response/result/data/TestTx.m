//
//  TestTx.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TestTx.h"
#import "YYModelClass.h"

@implementation TestTx
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"transactionEnv" : @"transaction_env"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"transactionEnv" : TestTransactionFees.class};
}
@end
