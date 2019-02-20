//
//  lockCheckStatusLedgerSeqResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockCheckStatusLedgerSeqResult.h"
#import "YYModelClass.h"

@implementation BlockCheckStatusLedgerSeqResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"chainMaxLedgerSeq" : @"chain_max_ledger_seq",
             @"ledgerSequence" : @"ledger_sequence"};
}
@end
