//
//  BaseResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/7/24.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "SDKError.h"

@interface BaseResponse : NSObject

@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;

-(void)buildResponse:(int32_t)errorCode;
@end
