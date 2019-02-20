//
//  LogInfo.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "LogInfo.h"
#import "YYModelClass.h"

@implementation LogInfo
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"datas" : [NSString class]};
}
@end
