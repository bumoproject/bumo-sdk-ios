//
//  ValidatorInfo.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ValidatorInfo.h"
#import "YYModelClass.h"

@implementation ValidatorInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"pledgeCoinAmount" : @"pledge_coin_amount"};
}
@end
