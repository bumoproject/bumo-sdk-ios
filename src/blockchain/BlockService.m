//
//  BlockService.m
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockService.h"

#define AbstractMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@implementation BlockService
- (instancetype)init {
    NSAssert(![self isMemberOfClass:[BlockService class]], @"BlockService is an abstract class, you should not instantiate it directly.");
    return [super init];
}

- (BlockGetNumberResponse *) getNumber {
    AbstractMethodNotImplemented();
}

- (BlockCheckStatusResponse *) checkStatus {
    AbstractMethodNotImplemented();
}

- (BlockGetTransactionsResponse *) getTransactions : (BlockGetTransactionsRequest *) blockGetTransactionsRequest {
    AbstractMethodNotImplemented();
}

- (BlockGetInfoResponse *) getInfo : (BlockGetInfoRequest *) blockGetInfoRequest {
    AbstractMethodNotImplemented();
}

- (BlockGetLatestInfoResponse *) getLatestInfo {
    AbstractMethodNotImplemented();
}

- (BlockGetValidatorsResponse *) getValidators : (BlockGetValidatorsRequest *) blockGetValidatorsRequest {
    AbstractMethodNotImplemented();
}

- (BlockGetLatestValidatorsResponse *) getLatestValidators {
    AbstractMethodNotImplemented();
}

- (BlockGetRewardResponse *) getReward : (BlockGetRewardRequest *) blockGetRewardRequest {
    AbstractMethodNotImplemented();
}

- (BlockGetLatestRewardResponse *) getLatestReward {
    AbstractMethodNotImplemented();
}

- (BlockGetFeesResponse *) getFees : (BlockGetFeesRequest *) blockGetFeesRequest {
    AbstractMethodNotImplemented();
}

- (BlockGetLatestFeesResponse *) getLatestFees {
    AbstractMethodNotImplemented();
}
@end
