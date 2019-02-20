//
//  Ctp10TokenTransferInput.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenTransferInput.h"
#import "YYModelClass.h"

@implementation Ctp10TokenTransferInput
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"params" : Ctp10TokenTransferParams.class};
}
@end
