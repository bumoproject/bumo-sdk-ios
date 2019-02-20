//
//  BlockCheckStatusResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockCheckStatusResponse.h"
#import "YYModelClass.h"

@implementation BlockCheckStatusResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : BlockCheckStatusResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(BlockCheckStatusResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockCheckStatusResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
