//
//  Ctp10TokenGetDecimalsResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "Ctp10TokenGetDecimalsResult.h"

@interface Ctp10TokenGetDecimalsResponse : BaseResponse
@property (nonatomic, strong) Ctp10TokenGetDecimalsResult *result;

-(void)buildResponse:(int32_t)errorCode :(Ctp10TokenGetDecimalsResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(Ctp10TokenGetDecimalsResult *)result;
@end
