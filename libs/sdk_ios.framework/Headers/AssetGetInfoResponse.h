//
//  AssetGetInfoResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "AssetGetInfoResult.h"

@interface AssetGetInfoResponse : BaseResponse
@property (nonatomic, strong) AssetGetInfoResult *result;

-(void)buildResponse:(int32_t)errorCode :(AssetGetInfoResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AssetGetInfoResult *)result;
@end
