//
//  Ctp10TokenGetBalanceResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "Ctp10TokenGetBalanceResult.h"

@interface Ctp10TokenGetBalanceResponse : BaseResponse
@property (nonatomic, strong) Ctp10TokenGetBalanceResult *result;

-(void)buildResponse:(int32_t)errorCode :(Ctp10TokenGetBalanceResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(Ctp10TokenGetBalanceResult *)result;
@end
