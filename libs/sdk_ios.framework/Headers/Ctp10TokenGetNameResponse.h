//
//  Ctp10TokenGetNameResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "Ctp10TokenGetNameResult.h"

@interface Ctp10TokenGetNameResponse : BaseResponse
@property (nonatomic, strong) Ctp10TokenGetNameResult *result;

-(void)buildResponse:(int32_t)errorCode :(Ctp10TokenGetNameResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(Ctp10TokenGetNameResult *)result;
@end
