//
//  BlockGetFeesResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetFeesResult.h"
#import "YYModelClass.h"

@implementation BlockGetFeesResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"fees" : [Fees class]};
}
@end
