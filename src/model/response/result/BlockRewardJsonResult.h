//
//  BlockRewardJsonResult.h
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockRewardJsonResult : NSObject
@property (nonatomic, assign) int64_t blockReward;
@property (nonatomic, strong) NSDictionary *validatorsReward;
@end
