//
//  ContractCallResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractCallResponse.h"
#import "YYModelClass.h"

@implementation ContractCallResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : ContractCallResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(ContractCallResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(ContractCallResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
