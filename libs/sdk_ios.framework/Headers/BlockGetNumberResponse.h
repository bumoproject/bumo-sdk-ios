//
//  BlockGetNumberResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockGetNumberResult.h"

@interface BlockGetNumberResponse : BaseResponse
@property (nonatomic, strong) BlockGetNumberResult *result;

-(void)buildResponse:(int32_t)errorCode :(BlockGetNumberResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetNumberResult *)result;
@end
