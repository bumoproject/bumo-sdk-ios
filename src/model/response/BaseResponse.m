//
//  BaseResponse.m
//  test-sdk-ios
//
//  Created by dxl on 2018/7/24.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "YYModelClass.h"

@implementation BaseResponse
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"errorCode" : @"error_code",
             @"errorDesc" : @"error_desc"};
}

-(void)buildResponse:(int32_t)errorCode {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
}
@end
