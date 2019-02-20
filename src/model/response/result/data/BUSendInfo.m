//
//  BUSendInfo.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BUSendInfo.h"
#import "YYModelClass.h"

@implementation BUSendInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"destAddress" : @"dest_address"};
}
@end
