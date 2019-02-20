//
//  Priv.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Priv.h"
#import "YYModelClass.h"

@implementation Priv
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"masterWeight" : @"master_weight"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"signers" : [SignerInfo class],
             @"thresholds" : Threshold.class};
}
@end
