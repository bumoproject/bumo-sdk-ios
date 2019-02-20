//
//  BlockGetFeesResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetFeesResponse.h"
#import "YYModelClass.h"

@implementation BlockGetFeesResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : BlockGetFeesResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(BlockGetFeesResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetFeesResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
