//
//  Ctp10TokenAllowanceResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "Ctp10TokenAllowanceResult.h"

@interface Ctp10TokenAllowanceResponse : BaseResponse
@property (nonatomic, strong) Ctp10TokenAllowanceResult *result;

-(void)buildResponse:(int32_t)errorCode :(Ctp10TokenAllowanceResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(Ctp10TokenAllowanceResult *)result;
@end
