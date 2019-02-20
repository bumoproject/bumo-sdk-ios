//
//  BlockCheckStatusResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockCheckStatusResult.h"
#import "YYModelClass.h"

@implementation BlockCheckStatusResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"isSynchronous" : @"is_synchronous"};
}
@end
