//
//  TokenCheckValidResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenCheckValidResult.h"
#import "YYModelClass.h"

@implementation Ctp10TokenCheckValidResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"isValid" : @"is_valid"};
}
@end
