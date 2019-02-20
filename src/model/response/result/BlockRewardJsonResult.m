//
//  BlockRewardJsonResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockRewardJsonResult.h"
#import "YYModelClass.h"

@implementation BlockRewardJsonResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"blockReward" : @"block_reward",
             @"validatorsReward" : @"validators_reward"};
}
@end
