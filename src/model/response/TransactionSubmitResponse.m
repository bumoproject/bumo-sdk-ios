//
//  TransactionSubmitResponse.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "TransactionSubmitResponse.h"
#import "YYModelClass.h"

@implementation TransactionSubmitResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : TransactionSubmitResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(TransactionSubmitResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}

-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc : (TransactionSubmitResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
