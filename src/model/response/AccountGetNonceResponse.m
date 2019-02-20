//
//  AccountGetNonceResponse.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountGetNonceResponse.h"
#import "YYModelClass.h"


@implementation AccountGetNonceResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : AccountGetNonceResult.class};
}
-(void)buildResponse:(int32_t)errorCode :(AccountGetNonceResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountGetNonceResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
