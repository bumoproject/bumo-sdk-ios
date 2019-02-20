//
//  Ctp10TokenApproveInput.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenApproveInput.h"
#import "YYModelClass.h"

@implementation Ctp10TokenApproveInput
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"params" : Ctp10TokenApproveParams.class};
}
@end
