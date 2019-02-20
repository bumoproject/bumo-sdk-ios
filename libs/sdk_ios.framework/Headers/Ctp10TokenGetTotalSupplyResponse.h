//
//  Ctp10TokenGetTotalSupplyResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "Ctp10TokenGetTotalSupplyResult.h"

@interface Ctp10TokenGetTotalSupplyResponse : BaseResponse
@property (nonatomic, strong) Ctp10TokenGetTotalSupplyResult *result;

-(void)buildResponse:(int32_t)errorCode :(Ctp10TokenGetTotalSupplyResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(Ctp10TokenGetTotalSupplyResult *)result;
@end
