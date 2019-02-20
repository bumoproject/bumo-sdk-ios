//
//  AccountService.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountService.h"

#define AbstractMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@implementation AccountService
- (instancetype)init {
    NSAssert(![self isMemberOfClass:[AccountService class]], @"AccountService is an abstract class, you should not instantiate it directly.");
    return [super init];
}

- (AccountCheckValidResponse *) checkValid : (AccountCheckValidRequest *) accountCheckValidRequest {
    AbstractMethodNotImplemented();
}

- (AccountCreateResponse *) create {
    AbstractMethodNotImplemented();
}

- (AccountGetInfoResponse *) getInfo : (AccountGetInfoRequest *) accountGetInfoRequest {
    AbstractMethodNotImplemented();
}

- (AccountGetNonceResponse *) getNonce : (AccountGetNonceRequest *) accountGetNonceRequest {
    AbstractMethodNotImplemented();
}

- (AccountGetBalanceResponse *) getBalance : (AccountGetBalanceRequest *) accountGetBalanceRequest {
    AbstractMethodNotImplemented();
}

- (AccountGetAssetsResponse *) getAssets : (AccountGetAssetsRequest *) accountGetAssetsRequest {
    AbstractMethodNotImplemented();
}

- (AccountGetMetadataResponse *) getMetadata : (AccountGetMetadataRequest *) accountGetMetadataRequest {
    AbstractMethodNotImplemented();
}


@end
