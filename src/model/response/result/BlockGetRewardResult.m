//
//  BlockGetRewardResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetRewardResult.h"
#import "YYModelClass.h"

@implementation BlockGetRewardResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"blockReward" : @"block_reward",
             @"rewardResults" : @"validators_reward"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"rewardResults" : [ValidatorRewardInfo class]};
}
@end
