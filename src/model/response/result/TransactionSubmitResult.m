//
//  TransactionSubmitResult.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "TransactionSubmitResult.h"

@implementation TransactionSubmitResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"transactionHash" : @"hash"};
}
@end
