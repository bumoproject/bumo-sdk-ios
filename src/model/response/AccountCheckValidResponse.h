//
//  AccountCheckValidResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/7/31.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "AccountCheckValidResult.h"

@interface AccountCheckValidResponse : BaseResponse
@property (nonatomic, strong) AccountCheckValidResult *result;

-(void)buildResponse:(int32_t)errorCode :(AccountCheckValidResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountCheckValidResult *)result;
@end
