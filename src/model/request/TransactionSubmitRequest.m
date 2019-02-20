//
//  TransactionSubmitRequest.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "TransactionSubmitRequest.h"

@implementation TransactionSubmitRequest
- (void) setTransactionBlob : (NSString *)transactionBlob {
    _transactionBlob = transactionBlob;
}
- (NSString *) getTransactionBlob {
    return _transactionBlob;
}

- (void) setSignatures : (NSMutableArray<SignatureInfo *> *) signatures {
    _signatures = signatures;
}
- (void) setSignature : (SignatureInfo *) signature {
    if (nil == _signatures) {
        _signatures = [[NSMutableArray alloc] init];
    }
    [_signatures removeAllObjects];
    [_signatures addObject : signature];
}
- (void) addSignature : (SignatureInfo *) signature {
    if (nil == _signatures) {
        _signatures = [[NSMutableArray alloc] init];
    }
    [_signatures addObject : signature];
}
- (NSMutableArray<SignatureInfo *> *) getSignatures {
    return _signatures;
}
@end
