//
//  TransactionServiceProtocol.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionBuildBlobRequest.h"
#import "TransactionBuildBlobResponse.h"
#import "TransactionParseBlobRequest.h"
#import "TransactionParseBlobResponse.h"
#import "TransactionEvaluateFeeRequest.h"
#import "TransactionEvaluateFeeResponse.h"
#import "TransactionSignResponse.h"
#import "TransactionSignRequest.h"
#import "TransactionSubmitResponse.h"
#import "TransactionSubmitRequest.h"
#import "TransactionGetInfoResponse.h"
#import "TransactionGetInfoRequest.h"

@protocol TransactionServiceProtocol <NSObject>
@required

/**
 Build a blob for submitting transaction.
 
 @param transactionBuildBlobRequest
            sourceAddress(NSString *) :  An account to submit transaction
            nonce(int64_t) : The nonce of source account
            gasPrice(int64_t) : Gas price
            feeLimit(int64_t) : The lowest fee for submitting transaction
            operation(NSMutableArray<BaseOperation *> *): operation list
            ceilLedgerSeq(int64_t) : set a value which will be combined with the current block height to restrict transactions. If transactions do not complete within the set value plus the current block height, the transactions fail. The value you set must be greater than 0
 @return TransactionBuildBlobResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(TransactionBuildBlobResult)
                transactionBlob(NSString *): transaction blob
                transactionHash(NSStirng *): transaction hash
 */
- (TransactionBuildBlobResponse *) buildBlob : (TransactionBuildBlobRequest *) transactionBuildBlobRequest;

/**
 Parse a blob
 
 @param transactionParseBlobRequest
            blob(NSString *): The transaction blob to be sent
 @return TransactionParseBlobResponse
             errorCode(int64_t)
             errorDesc(NSString *)
             result(TransactionBuildBlobResult)
                sourceAddress(NSString *): The source account address to send a transaction
                feeLimit(NSStirng *): The fee limit
                gasPrice(NSString *): The gas price
                nonce(NSStirng *): The account nonce
                operations(NSArray<OperationFormat *> *): The operation list
 */
- (TransactionParseBlobResponse *) parseBlob : (TransactionParseBlobRequest *) transactionParseBlobRequest;

/**
 Evaluate the fee
 @param transactionEvaluateFeeRequest
            sourceAddress(NSString *) :  An account to submit transaction
            nonce(int64_t) : The nonce of source account
            signatureNumber(int64_t) : The number of signature
            operation(NSMutableArray<BaseOperation *> *): operation list
            ceilLedgerSeq(int64_t) : set a value which will be combined with the current block height to restrict transactions. If transactions do not complete within the set value plus the current block height, the transactions fail. The value you set must be greater than 0
 @return TransactionEvaluateFeeResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(TransactionEvaluateFeeResult)
                txs(NSArray<TestTx *> *): The transaction set
                    transactionEnv(TestTransactionFees *): The transaction env
                        transactionFees(TransactionFees *): The transaction fees
                            feeLimit(int64_t): The fee limit
                            gasPrice(int64_t): The gas price
 */
- (TransactionEvaluateFeeResponse *) evaluateFee : (TransactionEvaluateFeeRequest *) transactionEvaluateFeeRequest;

/**
 Sign the transaction blob for submitting transaction.
 
 @param transactionSignRequest
            blob(NSString *):  The transaction blob
            privateKeys(NSMutableArray<NSString *> *): private key list
 @return TransactionSignResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(TransactionSignResult)
                signatures(NSArray<SignatureInfo *> *): signature list
                    signData(NSString *): sign data
                    publicKey(NSString *): public key
 */
- (TransactionSignResponse *) sign : (TransactionSignRequest *) transactionSignRequest;


/**
 Submit a transaction
 
 @param transactionSubmitRequest
            transactionBlob(NSString *) : The transaction blob
 @return TransactionSubmitResponse
            result(TransactionSubmitResult *)
            nonce(int64_t) : the nonce of an account
 */
- (TransactionSubmitResponse *) submit : (TransactionSubmitRequest *) transactionSubmitRequest;

/**
 Get the info of a transaction
 @param transactionGetInfoRequest
            hash(NSString *) : The transaction hash
 @return TransactionGetInfoResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(TransactionSubmitResult *)
                totalCount(int64_t) : The total count of transaction
                transactions(NSArray<TransactionHistory *> *) : The transactions
 */
- (TransactionGetInfoResponse *) getInfo : (TransactionGetInfoRequest *) transactionGetInfoRequest;
@end
