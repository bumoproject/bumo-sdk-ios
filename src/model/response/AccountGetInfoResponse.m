//
//  AccountGetInfoResponse.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountGetInfoResponse.h"
#import "YYModelClass.h"

@implementation AccountGetInfoResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : AccountGetInfoResult.class};
}
-(void)buildResponse:(int32_t)errorCode :(AccountGetInfoResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountGetInfoResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
