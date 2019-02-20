//
//  AccountCreateResponse.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/1.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountCreateResponse.h"
#import "YYModelClass.h"

@implementation AccountCreateResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : AccountCreateResult.class};
}
-(void)buildResponse:(int32_t)errorCode :(AccountCreateResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountCreateResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
