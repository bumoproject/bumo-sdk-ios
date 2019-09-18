//
//  BlockGetLatestRewardResult.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rewards.h"

@interface BlockGetLatestRewardResult : NSObject
@property (nonatomic, strong) NSMutableArray *validators;
@property (nonatomic, strong) NSMutableArray *kols;
@end
