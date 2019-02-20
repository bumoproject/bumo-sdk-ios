//
//  General.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "General.h"
#import "Tools.h"
#import "SDK.h"

static NSString *_url = nil;
@implementation General

static General *_general = nil;

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _general = [[super allocWithZone:NULL] init] ;
    }) ;
    _url = [SDK getUrl];
    return _general;
}

+ (id) allocWithZone : (struct _NSZone *)zone {
    return [General sharedInstance] ;
}

- (id) copyWithZone : (struct _NSZone *)zone {
    return [General sharedInstance] ;
}

- (NSString *) getUrl {
    return _url;
}

- (NSString *) accountGetInfoUrl : (NSString *) address {
    return [NSString stringWithFormat : @"%@/getAccountBase?address=%@", _url, address];
}

- (NSString *) accountGetAssetsUrl : (NSString *) address {
    return [NSString stringWithFormat : @"%@/getAccount?address=%@", _url, address];
}

- (NSString *) accountGetMetadataUrl : (NSString *) address : (NSString *) key {
    if ([Tools isEmpty : key]) {
        return [NSString stringWithFormat : @"%@/getAccount?address=%@", _url, address];
    } else {
        return [NSString stringWithFormat : @"%@/getAccount?address=%@&key=%@", _url, address, key];
    }
    
}
- (NSString *) assetGetUrl : (NSString *) address : (NSString *)code : (NSString *) issuer {
    return [NSString stringWithFormat : @"%@/getAccount?address=%@&code=%@&issuer=%@", _url, address, code, issuer];
}
- (NSString *) contractCallUrl {
    return [NSString stringWithFormat : @"%@/callContract", _url];
}
- (NSString *) transactionEvaluationFeeUrl {
    return [NSString stringWithFormat : @"%@/testTransaction", _url];
}
- (NSString *) transactionSubmitUrl {
    return [NSString stringWithFormat : @"%@/submitTransaction", _url];
}
- (NSString *) transactionGetInfoUrl : (NSString *) hash {
    return [NSString stringWithFormat : @"%@/getTransactionHistory?hash=%@", _url, hash];
}
- (NSString *) blockGetNumber {
    return [NSString stringWithFormat : @"%@/getLedger", _url];
}
- (NSString *) blockCheckStatusUrl {
    return [NSString stringWithFormat : @"%@/getModulesStatus", _url];
}
- (NSString *) blockGetTransactionsUrl : (int64_t) blockNumber {
    return [NSString stringWithFormat : @"%@/getTransactionHistory?ledger_seq=%lld", _url, blockNumber];
}
- (NSString *) blockGetInfoUrl : (int64_t) blockNumber {
    return [NSString stringWithFormat : @"%@/getLedger?seq=%lld", _url, blockNumber];
}
- (NSString *) blockGetLatestInfoUrl {
    return [NSString stringWithFormat : @"%@/getLedger", _url];
}
- (NSString *) blockGetValidatorsUrl : (int64_t) blockNumber {
    return [NSString stringWithFormat : @"%@/getLedger?seq=%lld&with_validator=true", _url, blockNumber];
}
- (NSString *) blockGetLatestValidatorsUrl {
    return [NSString stringWithFormat : @"%@/getLedger?with_validator=true", _url];
}
- (NSString *) blockGetRewardUrl : (int64_t) blockNumber {
    return [NSString stringWithFormat : @"%@/getLedger?seq=%lld&with_block_reward=true", _url, blockNumber];
}
- (NSString *) blockGetLatestRewardUrl {
    return [NSString stringWithFormat : @"%@/getLedger?with_block_reward=true", _url];
}
- (NSString *) blockGetFeesUrl : (int64_t) blockNumber {
    return [NSString stringWithFormat : @"%@/getLedger?seq=%lld&with_fee=true", _url, blockNumber];
}
- (NSString *) blockGetLatestFeesUrl {
    return [NSString stringWithFormat : @"%@/getLedger?with_fee=true", _url];
}

@end
