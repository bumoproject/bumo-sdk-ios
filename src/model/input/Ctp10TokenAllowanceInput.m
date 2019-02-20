//
//  Ctp10TokenAllowanceInput.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenAllowanceInput.h"
#import "YYModelClass.h"

@implementation Ctp10TokenAllowanceInput
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"params" : Ctp10TokenAllowanceParams.class};
}
@end
