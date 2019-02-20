//
//  AssetSendInfo.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AssetSendInfo.h"
#import "YYModelClass.h"

@implementation AssetSendInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"destAddress" : @"dest_address",
             @"asset" : @"token"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"asset" : AssetInfo.class};
}
@end
