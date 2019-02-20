//
//  BlockGetTransactionsResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetTransactionsResult.h"
#import "YYModelClass.h"

@implementation BlockGetTransactionsResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"totalCount" : @"total_count"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"transactions" : [TransactionHistory class]};
}
@end
