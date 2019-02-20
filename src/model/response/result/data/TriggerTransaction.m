//
//  TriggerTransaction.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TriggerTransaction.h"
#import "YYModelClass.h"

@implementation TriggerTransaction
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"triggerHash" : @"hash"};
}
@end
