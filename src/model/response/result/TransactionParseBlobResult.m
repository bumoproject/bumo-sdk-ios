//
//  TransactionParseBlobResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionParseBlobResult.h"
#import "YYModelClass.h"

@implementation TransactionParseBlobResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"sourceAddress" : @"source_address",
             @"feeLimit" : @"fee_limit",
             @"gasPrice" : @"gas_price",
             @"ceilLedgerSeq" : @"ceil_ledger_seq",
             @"chainId" : @"chain_id"
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"operations" : [OperationInfo class]};
}
@end
