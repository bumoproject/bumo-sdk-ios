//
//  AccountGetAssetsResponse.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountGetAssetsResponse.h"
#import "YYModelClass.h"

@implementation AccountGetAssetsResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : AccountGetAssetsResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(AccountGetAssetsResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountGetAssetsResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
