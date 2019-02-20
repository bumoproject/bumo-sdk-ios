//
//  TransactionSubmitResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "BaseResponse.h"
#import "TransactionSubmitResult.h"

@interface TransactionSubmitResponse : BaseResponse
@property (nonatomic, strong) TransactionSubmitResult *result;

-(void)buildResponse:(int32_t)errorCode : (TransactionSubmitResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc : (TransactionSubmitResult *)result;
@end
