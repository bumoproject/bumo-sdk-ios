//
//  TokenErrorInfo.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TokenErrorInfo : NSObject
@property (nonatomic, copy) NSString *contract;
@property (nonatomic, copy) NSString *exception;
@property (nonatomic, assign) int64_t linenum;
@end
