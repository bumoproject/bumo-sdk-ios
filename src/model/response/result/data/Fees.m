//
//  Fees.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Fees.h"
#import "YYModelClass.h"

@implementation Fees
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"baseReserve" : @"base_reserve",
             @"gasPrice" : @"gas_price"};
}
@end
