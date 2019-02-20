//
//  Ctp10TokenGetBalanceInput.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenGetBalanceInput.h"
#import "YYModelClass.h"

@implementation Ctp10TokenGetBalanceInput
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"params" : Ctp10TokenGetBalanceParams.class};
}
@end
