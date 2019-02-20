//
//  BlockGetLatestInfoResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetLatestInfoResponse.h"
#import "YYModelClass.h"

@implementation BlockGetLatestInfoResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : BlockGetLatestInfoResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(BlockGetLatestInfoResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetLatestInfoResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
