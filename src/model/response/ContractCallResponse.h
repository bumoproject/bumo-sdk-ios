//
//  ContractCallResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "ContractCallResult.h"

@interface ContractCallResponse : BaseResponse
@property (nonatomic, strong) ContractCallResult *result;

-(void)buildResponse:(int32_t)errorCode :(ContractCallResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(ContractCallResult *)result;
@end
