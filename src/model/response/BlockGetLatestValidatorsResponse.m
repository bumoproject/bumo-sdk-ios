//
//  BlockGetLatestValidatorsResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetLatestValidatorsResponse.h"
#import "YYModelClass.h"

@implementation BlockGetLatestValidatorsResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : BlockGetLatestValidatorsResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(BlockGetLatestValidatorsResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetLatestValidatorsResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
