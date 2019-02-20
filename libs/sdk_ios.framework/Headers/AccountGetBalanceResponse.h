//
//  AccountGetBalanceResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "AccountGetBalanceResult.h"

@interface AccountGetBalanceResponse : BaseResponse
@property (nonatomic, strong) AccountGetBalanceResult *result;

-(void)buildResponse:(int32_t)errorCode :(AccountGetBalanceResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountGetBalanceResult *)result;
@end
