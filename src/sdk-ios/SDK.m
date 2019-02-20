//
//  SDK.m
//  sdk-ios
//
//  Created by dxl on 2018/8/8.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "SDK.h"
#import "AccountServiceImpl.h"
#import "AssetServiceImpl.h"
#import "TransactionServiceImpl.h"
#import "BlockServiceImpl.h"
#import "ContractServiceImpl.h"
#import "Ctp10TokenServiceImpl.h"
#import "General.h"

@implementation SDK
static NSString *_url = nil;
static SDKConfigure *_sdkConfigure = nil;
static SDK *_sdk = nil;

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _sdk = [[super allocWithZone:NULL] init] ;
    }) ;
    return _sdk ;
}
+ (id) allocWithZone : (struct _NSZone *)zone {
    return [SDK sharedInstance] ;
}
- (id) copyWithZone : (struct _NSZone *)zone {
    return [SDK sharedInstance] ;
}
- (instancetype) setUrl : (NSString *) url {
    _url = url;
    return self;
}
+ (NSString *) getUrl {
    return _url;
}
- (instancetype) setConfigure : (SDKConfigure *) sdkConfigure {
    if ([Tools isEmpty: _sdkConfigure]) {
        _sdkConfigure = [SDKConfigure new];
    }
    int64_t chainId = [sdkConfigure getChainId];
    if (chainId > 0) {
        [_sdkConfigure setChainId: chainId];
    }
    int64_t timeOut = [sdkConfigure getTimeOut];
    if (timeOut > 0) {
        [_sdkConfigure setTimeOut: timeOut];
    }
    return self;
}
+ (SDKConfigure *) getConfigure {
    return _sdkConfigure;
}
- (AccountService *) getAccountService {
    return [AccountServiceImpl new];
}

- (AssetService *) getAssetService {
    return [AssetServiceImpl new];
}

- (TransactionService *) getTransactionService {
    return [TransactionServiceImpl new];
}

- (BlockService *) getBlockService {
    return [BlockServiceImpl new];
}
- (ContractService *) getContractService {
    return [ContractServiceImpl new];
}
- (Ctp10TokenService *) getCtp10TokenService {
    return [Ctp10TokenServiceImpl new];
}
@end
