//
//  BlockGetInfoResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockGetInfoResult.h"

@interface BlockGetInfoResponse : BaseResponse
@property (nonatomic, strong) BlockGetInfoResult *result;

-(void)buildResponse:(int32_t)errorCode :(BlockGetInfoResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetInfoResult *)result;
@end
