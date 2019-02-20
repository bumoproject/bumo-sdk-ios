//
//  Threshold.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Threshold.h"
#import "YYModelClass.h"

@implementation Threshold
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"txThreshold" : @"tx_threshold",
             @"typeThresholds" : @"type_thresholds"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"typeThresholds" : [TypeThreshold class]};
}
@end
