//
//  BlockHeader.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockHeader.h"
#import "YYModelClass.h"

@implementation BlockHeader
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"closeTime" : @"close_time",
             @"number" : @"seq",
             @"txCount" : @"tx_count"};
}
@end
