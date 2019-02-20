//
//  TransactionFees.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionFees.h"
#import "YYModelClass.h"

@implementation TransactionFees
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"feeLimit" : @"fee_limit",
             @"gasPrice" : @"gas_price"};
}
@end
