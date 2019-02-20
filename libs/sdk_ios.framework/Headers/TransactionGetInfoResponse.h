//
//  TransactionGetInfoResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "TransactionGetInfoResult.h"

@interface TransactionGetInfoResponse : BaseResponse
@property (nonatomic, strong) TransactionGetInfoResult *result;

-(void)buildResponse:(int32_t)errorCode :(TransactionGetInfoResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionGetInfoResult *)result;
@end
