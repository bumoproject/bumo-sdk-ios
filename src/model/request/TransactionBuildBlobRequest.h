//
//  TransactionBuildBlobRequest.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOperation.h"

@interface TransactionBuildBlobRequest : NSObject {
@private
    NSString *_sourceAddress;
    int64_t _nonce;
    int64_t _gasPrice;
    int64_t _feeLimit;
    NSMutableArray<BaseOperation *> *_operations;
    int64_t _ceilLedgerSeq;
    NSString *_metadata;
}
- (void) setSourceAddress : (NSString *)sourceAddress;
- (NSString *) getSourceAddress;

- (void) setNonce : (int64_t)nonce;
- (int64_t) getNonce;

- (void) setGasPrice : (int64_t) gasPrice;
- (int64_t) getGasPrice;

- (void) setFeeLimit : (int64_t) feeLimit;
- (int64_t) getFeeLimit;

- (void) setOperations : (NSMutableArray<BaseOperation *> *) operations;
- (void) setOperation : (BaseOperation *) operation;
- (void) addOperation : (BaseOperation *) operation;
- (NSMutableArray<BaseOperation *> *) getOperations;

- (void) setCeilLedgerSeq : (int64_t) ceilLedgerSeq;
- (int64_t) getCeilLedgerSeq;

- (void) setMetadata : (NSString *) metadata;
- (NSString *) getMetadata;
@end
