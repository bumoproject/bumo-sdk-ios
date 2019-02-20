//
//  ContractCheckValidResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractCheckValidResponse.h"
#import "YYModelClass.h"

@implementation ContractCheckValidResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : ContractCheckValidResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(ContractCheckValidResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(ContractCheckValidResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
