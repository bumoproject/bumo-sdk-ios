//
//  AccountCheckValidResult.m
//  test-sdk-ios
//
//  Created by dxl on 2018/7/31.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountCheckValidResult.h"
#import "YYModelClass.h"

@implementation AccountCheckValidResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"isValid" : @"is_valid"};
}
@end
