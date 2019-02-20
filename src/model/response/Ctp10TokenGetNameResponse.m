//
//  Ctp10TokenGetNameResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenGetNameResponse.h"
#import "YYModelClass.h"

@implementation Ctp10TokenGetNameResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : Ctp10TokenGetNameResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(Ctp10TokenGetNameResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(Ctp10TokenGetNameResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
