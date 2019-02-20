//
//  BlockGetLatestInfoResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockGetLatestInfoResult.h"

@interface BlockGetLatestInfoResponse : BaseResponse
@property (nonatomic, strong) BlockGetLatestInfoResult *result;

-(void)buildResponse:(int32_t)errorCode :(BlockGetLatestInfoResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetLatestInfoResult *)result;
@end
