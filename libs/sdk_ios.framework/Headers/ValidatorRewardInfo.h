//
//  ValidatorRewardInfo.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidatorRewardInfo : NSObject
@property (nonatomic, copy) NSString *validator;
@property (nonatomic, assign) int64_t reward;
@end
