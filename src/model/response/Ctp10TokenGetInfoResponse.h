//
//  Ctp10TokenGetInfoResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "Ctp10TokenGetInfoResult.h"

@interface Ctp10TokenGetInfoResponse : BaseResponse
@property (nonatomic, strong) Ctp10TokenGetInfoResult *result;

-(void)buildResponse:(int32_t)errorCode :(Ctp10TokenGetInfoResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(Ctp10TokenGetInfoResult *)result;
@end
