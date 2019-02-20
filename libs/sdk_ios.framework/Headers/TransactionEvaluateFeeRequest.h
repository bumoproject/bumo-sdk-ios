//
//  TransactionEvaluateFeeRequest.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOperation.h"

@interface TransactionEvaluateFeeRequest : NSObject {
@private
    NSString *_sourceAddress;
    int64_t _nonce;
    NSMutableArray<BaseOperation *> *_operations;
    int32_t _signatureNumber;
    int64_t _ceilLedgerSeq;
    NSString *_metadata;
}
- (void) setSourceAddress : (NSString *)sourceAddress;
- (NSString *) getSourceAddress;

- (void) setNonce : (int64_t)nonce;
- (int64_t) getNonce;

- (void) setSignatureNumber : (int32_t) signatureNumber;
- (int32_t) getSignatureNumber;

- (void) setOperations : (NSMutableArray<BaseOperation *> *) operations;
- (void) setOperation : (BaseOperation *) operation;
- (void) addOperation : (BaseOperation *) operation;
- (NSMutableArray<BaseOperation *> *) getOperations;

- (void) setCeilLedgerSeq : (int64_t) ceilLedgerSeq;
- (int64_t) getCeilLedgerSeq;

- (void) setMetadata : (NSString *) metadata;
- (NSString *) getMetadata;

@end
