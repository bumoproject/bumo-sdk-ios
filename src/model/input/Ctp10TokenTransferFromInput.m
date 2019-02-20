//
//  Ctp10TokenTransferFromInput.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenTransferFromInput.h"
#import "YYModelClass.h"

@implementation Ctp10TokenTransferFromInput
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"params" : Ctp10TokenTransferFromParams.class};
}
@end
