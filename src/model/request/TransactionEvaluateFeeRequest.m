//
//  TransactionEvaluateFeeRequest.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionEvaluateFeeRequest.h"

@implementation TransactionEvaluateFeeRequest
- (void) setSourceAddress : (NSString *)sourceAddress {
    _sourceAddress = sourceAddress;
}
- (NSString *) getSourceAddress {
    return _sourceAddress;
}

- (void) setNonce : (int64_t)nonce {
    _nonce = nonce;
}
- (int64_t) getNonce {
    return _nonce;
}

- (void) setSignatureNumber : (int32_t) signatureNumber {
    _signatureNumber = signatureNumber;
}
- (int32_t) getSignatureNumber {
    return _signatureNumber;
}

- (void) setOperations : (NSMutableArray<BaseOperation *> *) operations {
    _operations = operations;
}
- (void) setOperation : (BaseOperation *) operation {
    if (nil == _operations) {
        _operations = [[NSMutableArray alloc] init];
    }
    [_operations removeAllObjects];
    [_operations addObject : operation];
}
- (void) addOperation : (BaseOperation *) operation {
    if (nil == _operations) {
        _operations = [[NSMutableArray alloc] init];
    }
    [_operations addObject : operation];
}
- (NSMutableArray<BaseOperation *> *) getOperations {
    return _operations;
}

- (void) setCeilLedgerSeq : (int64_t) ceilLedgerSeq {
    _ceilLedgerSeq = ceilLedgerSeq;
}
- (int64_t) getCeilLedgerSeq {
    return _ceilLedgerSeq;
}

- (void) setMetadata : (NSString *) metadata {
    _metadata = metadata;
}
- (NSString *) getMetadata {
    return _metadata;
}
@end
