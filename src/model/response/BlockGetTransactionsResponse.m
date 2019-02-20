//
//  BlockGetTransactionsResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetTransactionsResponse.h"
#import "YYModelClass.h"

@implementation BlockGetTransactionsResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : BlockGetTransactionsResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(BlockGetTransactionsResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetTransactionsResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
