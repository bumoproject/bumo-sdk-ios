//
//  ContractGetInfoResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractGetInfoResponse.h"
#import "YYModelClass.h"

@implementation ContractGetInfoResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : ContractGetInfoResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(ContractGetInfoResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(ContractGetInfoResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
