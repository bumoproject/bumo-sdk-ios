//
//  TransactionItem.m
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/30.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import "TransactionItem.h"
#import "YYModelClass.h"

@implementation TransactionItem
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"transactionJson" : @"transaction_json"};
}
@end
