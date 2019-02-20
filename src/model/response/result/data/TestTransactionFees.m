//
//  TestTransactionFees.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TestTransactionFees.h"
#import "YYModelClass.h"

@implementation TestTransactionFees
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"transactionFees" : @"transaction"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"transactionFees" : TransactionFees.class};
}
@end
