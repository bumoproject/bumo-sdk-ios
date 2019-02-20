//
//  AccountGetBalanceResponse.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountGetBalanceResponse.h"
#import "YYModelClass.h"

@implementation AccountGetBalanceResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : AccountGetBalanceResult.class};
}
-(void)buildResponse:(int32_t)errorCode :(AccountGetBalanceResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountGetBalanceResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
