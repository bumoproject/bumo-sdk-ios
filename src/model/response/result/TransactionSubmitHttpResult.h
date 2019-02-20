//
//  TransactionSubmitHttpResult.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionSubmitHttpResult : NSObject
@property (nonatomic, copy) NSString *transactionHash;
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@end
