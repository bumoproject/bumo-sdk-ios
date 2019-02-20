//
//  BlockGetInfoResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetInfoResult.h"
#import "YYModelClass.h"

@implementation BlockGetInfoResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"header" : BlockHeader.class};
}
@end
