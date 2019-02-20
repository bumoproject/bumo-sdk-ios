//
//  BlockGetValidatorsResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetValidatorsResponse.h"
#import "YYModelClass.h"

@implementation BlockGetValidatorsResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : BlockGetValidatorsResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(BlockGetValidatorsResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetValidatorsResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
