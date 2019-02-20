//
//  BUSendInfo.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUSendInfo : NSObject
@property (nonatomic, copy) NSString *destAddress;
@property (nonatomic, assign) int64_t amount;
@property (nonatomic, copy) NSString *input;
@end
