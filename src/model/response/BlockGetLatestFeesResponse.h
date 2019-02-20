//
//  BlockGetLatestFeesResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockGetLatestFeesResult.h"

@interface BlockGetLatestFeesResponse : BaseResponse
@property (nonatomic, strong) BlockGetLatestFeesResult *result;

-(void)buildResponse:(int32_t)errorCode :(BlockGetLatestFeesResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetLatestFeesResult *)result;
@end
