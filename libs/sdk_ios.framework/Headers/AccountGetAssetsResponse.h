//
//  AccountGetAssetsResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "AccountGetAssetsResult.h"

@interface AccountGetAssetsResponse : BaseResponse
@property (nonatomic, strong) AccountGetAssetsResult *result;

-(void)buildResponse:(int32_t)errorCode :(AccountGetAssetsResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountGetAssetsResult *)result;
@end
