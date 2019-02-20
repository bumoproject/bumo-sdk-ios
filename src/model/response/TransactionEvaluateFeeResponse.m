//
//  TransactionEvaluateFeeResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionEvaluateFeeResponse.h"
#import "YYModelClass.h"

@implementation TransactionEvaluateFeeResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : TransactionEvaluateFeeResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(TransactionEvaluateFeeResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionEvaluateFeeResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
