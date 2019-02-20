//
//  TransactionGetInfoResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionGetInfoResponse.h"
#import "YYModelClass.h"

@implementation TransactionGetInfoResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : TransactionGetInfoResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(TransactionGetInfoResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}

-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionGetInfoResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
