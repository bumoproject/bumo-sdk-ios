//
//  Ctp10TokenGetSymbolResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "Ctp10TokenGetSymbolResult.h"

@interface Ctp10TokenGetSymbolResponse : BaseResponse
@property (nonatomic, strong) Ctp10TokenGetSymbolResult *result;

-(void)buildResponse:(int32_t)errorCode :(Ctp10TokenGetSymbolResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(Ctp10TokenGetSymbolResult *)result;
@end
