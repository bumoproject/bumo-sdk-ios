//
//  BlockCheckStatusLedgerSeqResponse.m
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockCheckStatusLedgerSeqResponse.h"
#import "YYModelClass.h"

@implementation BlockCheckStatusLedgerSeqResponse
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"result" : @"ledger_manager"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"result" : BlockCheckStatusLedgerSeqResult.class};
}
@end
