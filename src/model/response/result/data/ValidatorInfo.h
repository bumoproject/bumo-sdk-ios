//
//  ValidatorInfo.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidatorInfo : NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) int64_t pledgeCoinAmount;
@end
