//
//  AccountCheckValidResponse.m
//  test-sdk-ios
//
//  Created by dxl on 2018/7/31.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountCheckValidResponse.h"
#import "YYModelClass.h"

@implementation AccountCheckValidResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : AccountCheckValidResult.class};
}
-(void)buildResponse:(int32_t)errorCode :(AccountCheckValidResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountCheckValidResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
