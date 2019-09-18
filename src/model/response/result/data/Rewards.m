//
//  Rewards.m
//  sdk-ios
//
//  Created by 冯瑞明 on 2019/9/18.
//  Copyright © 2019 dlx. All rights reserved.
//

#import "Rewards.h"

@implementation Rewards
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"reward" : [NSDictionary class]};
}
@end
