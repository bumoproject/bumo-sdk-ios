//
//  TransactionSubmitHttpResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionSubmitHttpResult.h"

@interface TransactionSubmitHttpResponse : NSObject
@property (nonatomic, assign) int32_t successCount;
@property (nonatomic, strong) NSArray *results;
@end
