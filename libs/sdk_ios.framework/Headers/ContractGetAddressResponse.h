//
//  ContractGetAddressResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "ContractGetAddressResult.h"

@interface ContractGetAddressResponse : BaseResponse
@property (nonatomic, strong) ContractGetAddressResult *result;

-(void)buildResponse:(int32_t)errorCode :(ContractGetAddressResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(ContractGetAddressResult *)result;
@end
