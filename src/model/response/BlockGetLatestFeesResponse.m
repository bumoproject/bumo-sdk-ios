//
//  BlockGetLatestFeesResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetLatestFeesResponse.h"
#import "YYModelClass.h"

@implementation BlockGetLatestFeesResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : BlockGetLatestFeesResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(BlockGetLatestFeesResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetLatestFeesResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
