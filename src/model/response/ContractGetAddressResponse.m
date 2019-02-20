//
//  ContractGetAddressResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractGetAddressResponse.h"
#import "YYModelClass.h"

@implementation ContractGetAddressResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : ContractGetAddressResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(ContractGetAddressResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(ContractGetAddressResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
