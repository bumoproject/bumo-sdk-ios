//
//  BlockGetLatestRewardResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockGetLatestRewardResult.h"

@interface BlockGetLatestRewardResponse : BaseResponse
@property (nonatomic, strong) BlockGetLatestRewardResult *result;

-(void)buildResponse:(int32_t)errorCode :(BlockGetLatestRewardResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetLatestRewardResult *)result;
@end
