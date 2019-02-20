//
//  BlockGetValidatorResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetValidatorsResult.h"
#import "YYModelClass.h"

@implementation BlockGetValidatorsResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"validators" : [ValidatorInfo class]};
}
@end
