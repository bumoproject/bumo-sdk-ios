//
//  TokenErrorResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TokenErrorResult.h"
#import "YYModelClass.h"

@implementation TokenErrorResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"data" : TokenErrorInfo.class};
}
@end
