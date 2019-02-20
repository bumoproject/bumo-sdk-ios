//
//  AssetGetInfoResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AssetGetInfoResult.h"
#import "YYModelClass.h"

@implementation AssetGetInfoResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"assets" : [AssetInfo class]};
}
@end
