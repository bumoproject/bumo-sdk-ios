//
//  TransactionSubmitHttpResponse.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "TransactionSubmitHttpResponse.h"
#import "YYModelClass.h"

@implementation TransactionSubmitHttpResponse
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"successCount" : @"success_count"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"results" : [TransactionSubmitHttpResult class]};
}
@end
