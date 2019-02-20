//
//  BlockGetRewardResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetRewardResponse.h"
#import "YYModelClass.h"

@implementation BlockGetRewardResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : BlockGetRewardResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(BlockGetRewardResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetRewardResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
