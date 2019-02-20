//
//  TransactionParseBlobResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionParseBlobResponse.h"
#import "YYModelClass.h"

@implementation TransactionParseBlobResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : TransactionParseBlobResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(TransactionParseBlobResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionParseBlobResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
