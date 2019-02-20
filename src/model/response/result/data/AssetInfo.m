//
//  AssetInfo.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AssetInfo.h"
#import "YYModelClass.h"

@implementation AssetInfo
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"key" : [AssetKeyInfo class]};
}
@end
