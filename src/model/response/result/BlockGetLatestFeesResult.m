//
//  BlockGetLatestFeesResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetLatestFeesResult.h"
#import "YYModelClass.h"

@implementation BlockGetLatestFeesResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"fees" : [Fees class]};
}
@end
