//
//  TransactionSubmitHttpResult.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "TransactionSubmitHttpResult.h"
#import "YYModelClass.h"

@implementation TransactionSubmitHttpResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"transactionHash" : @"hash",
             @"errorCode" : @"error_code",
             @"errorDesc" : @"error_desc"};
}
@end
