//
//  ContractStat.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractStat.h"
#import "YYModelClass.h"

@implementation ContractStat
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"applyTime" : @"apply_time",
             @"memoryUsage" : @"memory_usage",
             @"stackUsage" : @"stack_usage",
             @"step" : @"step"};
}
@end
