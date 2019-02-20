//
//  AssetGetInfoResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AssetGetInfoResponse.h"
#import "YYModelClass.h"

@implementation AssetGetInfoResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : AssetGetInfoResult.class};
}
-(void)buildResponse:(int32_t)errorCode :(AssetGetInfoResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}

-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AssetGetInfoResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
