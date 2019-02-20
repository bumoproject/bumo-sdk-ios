//
//  TransactionHistory.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionHistory.h"
#import "YYModelClass.h"

@implementation TransactionHistory
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"actualFee" : @"actual_fee",
             @"closeTime" : @"close_time",
             @"errorCode" : @"error_code",
             @"errorDesc" : @"error_desc",
             @"transactionHash" : @"hash",
             @"ledgerSeq" : @"ledger_seq",
             @"txSize" : @"tx_size"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"signatures" : [SignatureInfo class],
             @"transaction" : TransactionInfo.class};
}
@end
