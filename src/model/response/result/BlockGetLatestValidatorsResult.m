//
//  BlockGetLatestValidatorsResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetLatestValidatorsResult.h"
#import "YYModelClass.h"

@implementation BlockGetLatestValidatorsResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"validators" : [ValidatorInfo class]};
}
@end
