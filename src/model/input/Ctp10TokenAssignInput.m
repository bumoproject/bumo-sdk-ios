//
//  Ctp10TokenAssignInput.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenAssignInput.h"
#import "YYModelClass.h"

@implementation Ctp10TokenAssignInput
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"params" : Ctp10TokenAssignParams.class};
}
@end
