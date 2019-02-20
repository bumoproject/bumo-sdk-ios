//
//  AccountGetAssetsResult.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountGetAssetsResult.h"
#import "YYModelClass.h"

@implementation AccountGetAssetsResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"assets" : [AssetInfo class]};
}
@end
