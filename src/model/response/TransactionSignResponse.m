//
//  TransactionSignResponse.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "TransactionSignResponse.h"
#import "YYModelClass.h"

@implementation TransactionSignResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : TransactionSignResult.class};
}
-(void)buildResponse:(int32_t)errorCode :(TransactionSignResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionSignResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
