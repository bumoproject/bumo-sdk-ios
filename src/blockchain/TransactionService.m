//
//  TransactionService.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionService.h"

#define AbstractMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@implementation TransactionService
- (instancetype)init {
    NSAssert(![self isMemberOfClass:[TransactionService class]], @"TransactionService is an abstract class, you should not instantiate it directly.");
    return [super init];
}

- (TransactionBuildBlobResponse *) buildBlob : (TransactionBuildBlobRequest *) transactionBuildBlobRequest {
    AbstractMethodNotImplemented();
}

- (TransactionParseBlobResponse *) parseBlob : (TransactionParseBlobRequest *) transactionParseBlobRequest {
    AbstractMethodNotImplemented();
}

- (TransactionEvaluateFeeResponse *) evaluateFee : (TransactionEvaluateFeeRequest *) transactionEvaluateFeeRequest {
    AbstractMethodNotImplemented();
}

- (TransactionSignResponse *) sign : (TransactionSignRequest *) transactionSignRequest {
    AbstractMethodNotImplemented();
}

- (TransactionSubmitResponse *) submit : (TransactionSubmitRequest *) transactionSubmitRequest {
    AbstractMethodNotImplemented();
}

- (TransactionGetInfoResponse *) getInfo : (TransactionGetInfoRequest *) transactionGetInfoRequest {
    AbstractMethodNotImplemented();
}
@end
