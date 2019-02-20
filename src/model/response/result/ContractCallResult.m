//
//  ContractCallResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractCallResult.h"
#import "YYModelClass.h"

@implementation ContractCallResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"queryRets" : @"query_rets"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"queryRets" : [NSDictionary class],
             @"stat" : ContractStat.class,
             @"txs" : [TransactionEnvs class]};
}
@end
