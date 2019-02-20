//
//  ContractStat.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContractStat : NSObject
@property (nonatomic, assign) int64_t applyTime;
@property (nonatomic, assign) int64_t memoryUsage;
@property (nonatomic, assign) int64_t stackUsage;
@property (nonatomic, assign) int64_t step;
@end
