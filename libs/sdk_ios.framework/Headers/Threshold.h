//
//  Threshold.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeThreshold.h"

@interface Threshold : NSObject
@property (nonatomic, assign) int64_t txThreshold;
@property (nonatomic, strong) NSArray *typeThresholds;
@end
