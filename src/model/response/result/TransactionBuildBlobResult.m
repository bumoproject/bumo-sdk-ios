//
//  TransactionBuildBlobResult.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionBuildBlobResult.h"
#import "YYModelClass.h"

@implementation TransactionBuildBlobResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"transactionBlob" : @"blob",
             @"transactionHash" : @"hash"};
}
@end
