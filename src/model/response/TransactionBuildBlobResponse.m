//
//  TransactionBuildBlobResponse.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionBuildBlobResponse.h"
#import "YYModelClass.h"

@implementation TransactionBuildBlobResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : TransactionBuildBlobResult.class};
}
-(void)buildResponse:(int32_t)errorCode :(TransactionBuildBlobResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionBuildBlobResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
