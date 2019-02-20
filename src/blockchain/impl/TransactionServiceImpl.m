//
//  TransactionServiceImpl.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "SDK.h"
#import "General.h"
#import "Constant.h"
#import "http/Http.h"
#import "SDKError.h"
#import "SDKException.h"
#import "Chain.pbobjc.h"
#import "AccountServiceImpl.h"
#import "AssetServiceImpl.h"
#import "BuServiceImpl.h"
#import "ContractServiceImpl.h"
#import "Ctp10TokenServiceImpl.h"
#import "TransactionServiceImpl.h"
#import "LogServiceImpl.h"
#import "TransactionSubmitHttpResponse.h"
#import "TransactionTestRequest.h"
#import "BlockGetNumberResponse.h"
#import "Hash.h"

@implementation TransactionServiceImpl

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
- (TransactionBuildBlobResponse *) buildBlob : (TransactionBuildBlobRequest *) transactionBuildBlobRequest {
    TransactionBuildBlobResponse *transactionBuildBlobResponse = [TransactionBuildBlobResponse new];
    TransactionBuildBlobResult *transactionBuildBlobResult = [TransactionBuildBlobResult new];
    @try {
        if ([Tools isEmpty:transactionBuildBlobRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *sourceAddress = [transactionBuildBlobRequest getSourceAddress];
        if (![Tools isAddressValid : sourceAddress]) {
            @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
        }
        int64_t nonce = [transactionBuildBlobRequest getNonce];
        if (nonce < 1) {
            @throw [[SDKException alloc] initWithCode : INVALID_NONCE_ERROR];
        }
        int64_t gasPrice = [transactionBuildBlobRequest getGasPrice];
        if (gasPrice < GAS_PRICE_MIN) {
            @throw [[SDKException alloc] initWithCode : INVALID_GASPRICE_ERROR];
        }
        int64_t feeLimit = [transactionBuildBlobRequest getFeeLimit];
        if (feeLimit < FEE_LIMIT_MIN) {
            @throw [[SDKException alloc] initWithCode : INVALID_FEELIMIT_ERROR];
        }
        int64_t ceilLedgerSeq = [transactionBuildBlobRequest getCeilLedgerSeq];
        if (ceilLedgerSeq < 0) {
            @throw [[SDKException alloc] initWithCode : INVALID_CEILLEDGERSEQ_ERROR];
        }
        NSString *metadata = [transactionBuildBlobRequest getMetadata];
        NSMutableArray<BaseOperation *> *operations = [transactionBuildBlobRequest getOperations];
        if ([Tools isEmpty : operations]) {
            @throw [[SDKException alloc] initWithCode : OPERATIONS_EMPTY_ERROR];
        }
        Transaction *transaction = [Transaction message];
        [self buildOperation : operations : sourceAddress : &transaction];
        [transaction setSourceAddress : sourceAddress];
        [transaction setNonce : nonce];
        [transaction setFeeLimit : feeLimit];
        [transaction setGasPrice : gasPrice];
        if (![Tools isEmpty : metadata]) {
            [transaction setMetadata : [metadata dataUsingEncoding : NSUTF8StringEncoding]];
        }
        SDKConfigure *sdkConfigure = [SDK getConfigure];
        int64_t chainId = [sdkConfigure getChainId];
        if (chainId > 0) {
            [transaction setChainId: chainId];
        }
        if (ceilLedgerSeq > 0) {
            NSString *getNumberUrl = [[General sharedInstance] blockGetNumber];
            NSData *result = [Http get: getNumberUrl];
            BlockGetNumberResponse *blockGetNumberResponse = [BlockGetNumberResponse yy_modelWithJSON: result];
            int32_t errorCode = blockGetNumberResponse.errorCode;
            if (errorCode != 0) {
                @throw [[SDKException alloc] initWithCode : INVALID_CEILLEDGERSEQ_ERROR];
            }
            int64_t blockNumber = blockGetNumberResponse.result.header.blockNumber;
            int64_t realCeilLedgerSeq = blockNumber + ceilLedgerSeq;
            if (realCeilLedgerSeq < 1) {
                @throw [[SDKException alloc] initWithCode : INVALID_CEILLEDGERSEQ_ERROR];
            }
            [transaction setCeilLedgerSeq: realCeilLedgerSeq];
        }
        // Serialization
        NSData *serialData = [transaction data];
        NSString *transactionBlob = [Tools dataToHexStr : serialData];
        transactionBuildBlobResult.transactionBlob = transactionBlob;
        transactionBuildBlobResult.transactionHash = [Tools dataToHexStr: [Hash sha256: serialData]];
        [transactionBuildBlobResponse buildResponse:(SUCCESS) : transactionBuildBlobResult];
    }
    @catch(SDKException *sdkException) {
        [transactionBuildBlobResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc]  : transactionBuildBlobResult];
    }
    @catch(NSException *exception) {
        [transactionBuildBlobResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(transactionBuildBlobResult)];
    }
    return transactionBuildBlobResponse;
}

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
- (TransactionParseBlobResponse *) parseBlob : (TransactionParseBlobRequest *) transactionParseBlobRequest {
    TransactionParseBlobResponse *transactionParseBlobResponse = [TransactionParseBlobResponse new];
    TransactionParseBlobResult *transactionParseBlobResult = [TransactionParseBlobResult new];
    @try {
        if ([Tools isEmpty:transactionParseBlobRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *blob = [transactionParseBlobRequest getBlob];
        if ([Tools isEmpty : blob]) {
            @throw [[SDKException alloc] initWithCode : INVALID_BLOB_ERROR];
        }
        NSData *blobData = [Tools hexStrToData : blob];
        NSError *error = nil;
        Transaction *transaction = [Transaction parseFromData : blobData error : &error];
        if ([Tools isEmpty : transaction] || ![Tools isEmpty : error]) {
            @throw [[SDKException alloc] initWithCode : INVALID_BLOB_ERROR];
        }
        transactionParseBlobResult = (TransactionParseBlobResult *)[self transactionToInfo: transaction];
        [transactionParseBlobResponse buildResponse:SUCCESS :transactionParseBlobResult];
    }
    @catch(SDKException *sdkException) {
        [transactionParseBlobResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc]  : (transactionParseBlobResult)];
    }
    @catch(NSException *exception) {
        [transactionParseBlobResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(transactionParseBlobResult)];
    }
    return transactionParseBlobResponse;
}

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
- (TransactionEvaluateFeeResponse *) evaluateFee : (TransactionEvaluateFeeRequest *) transactionEvaluateFeeRequest {
    TransactionEvaluateFeeResponse *transactionEvaluateFeeResponse = [TransactionEvaluateFeeResponse new];
    TransactionEvaluateFeeResult *transactionEvaluateFeeResult = [TransactionEvaluateFeeResult new];
    @try {
        if ([Tools isEmpty:transactionEvaluateFeeRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *sourceAddress = [transactionEvaluateFeeRequest getSourceAddress];
        if (![Tools isAddressValid : sourceAddress]) {
            @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
        }
        int64_t nonce = [transactionEvaluateFeeRequest getNonce];
        if (nonce < 1) {
            @throw [[SDKException alloc] initWithCode : INVALID_NONCE_ERROR];
        }
        int32_t signatureNum = [transactionEvaluateFeeRequest getSignatureNumber];
        if (signatureNum < 1) {
            @throw [[SDKException alloc] initWithCode : INVALID_SIGNATURENUMBER_ERROR];
        }
        int64_t ceilLedgerSeq = [transactionEvaluateFeeRequest getCeilLedgerSeq];
        if (ceilLedgerSeq < 0) {
            @throw [[SDKException alloc] initWithCode : INVALID_CEILLEDGERSEQ_ERROR];
        }
        NSString *metadata = [transactionEvaluateFeeRequest getMetadata];
        NSMutableArray *operations = [transactionEvaluateFeeRequest getOperations];
        if ([Tools isEmpty : operations]) {
            @throw [[SDKException alloc] initWithCode : OPERATIONS_EMPTY_ERROR];
        }
        Transaction *transaction = [Transaction message];
        [self buildOperation : operations : sourceAddress : &transaction];
        transaction.sourceAddress = sourceAddress;
        transaction.nonce = nonce;
        if (![Tools isEmpty: metadata]) {
            transaction.metadata = [metadata dataUsingEncoding: NSUTF8StringEncoding];
        }
        if (ceilLedgerSeq > 0) {
            NSString *getNumberUrl = [[General sharedInstance] blockGetNumber];
            NSData *result = [Http get: getNumberUrl];
            BlockGetNumberResponse *blockGetNumberResponse = [BlockGetNumberResponse yy_modelWithJSON: result];
            int32_t errorCode = blockGetNumberResponse.errorCode;
            if (errorCode != 0) {
                @throw [[SDKException alloc] initWithCode : INVALID_CEILLEDGERSEQ_ERROR];
            }
            int64_t blockNumber = blockGetNumberResponse.result.header.blockNumber;
            int64_t realCeilLedgerSeq = blockNumber + ceilLedgerSeq;
            if (realCeilLedgerSeq < 1) {
                @throw [[SDKException alloc] initWithCode : INVALID_CEILLEDGERSEQ_ERROR];
            }
            [transaction setCeilLedgerSeq: realCeilLedgerSeq];
        }
        TransactionInfo *transactionInfo = [self transactionToInfo: transaction];
        TransactionItem *transactionItem = [TransactionItem new];
        transactionItem.transactionJson = transactionInfo;
        TransactionTestRequest *transactionTestRequest = [TransactionTestRequest new];
        [transactionTestRequest addTransactionItem:transactionItem];
        
        NSString *evaluationFeeUrl = [[General sharedInstance] transactionEvaluationFeeUrl];
        NSData *result = [Http post : evaluationFeeUrl : [transactionTestRequest yy_modelToJSONString]];
        transactionEvaluateFeeResponse = [TransactionEvaluateFeeResponse yy_modelWithJSON : result];
    }
    @catch(SDKException *sdkException) {
        [transactionEvaluateFeeResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(transactionEvaluateFeeResult)];
    }
    @catch(NSException *exception) {
        [transactionEvaluateFeeResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(transactionEvaluateFeeResult)];
    }
    return transactionEvaluateFeeResponse;
}

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
- (TransactionSignResponse *) sign : (TransactionSignRequest *) transactionSignRequest {
    TransactionSignResponse *transactionSignResponse = [TransactionSignResponse new];
    TransactionSignResult *transactionSignResult = [TransactionSignResult new];
    @try {
        if ([Tools isEmpty : transactionSignRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *blob = [transactionSignRequest getBlob];
        if ([Tools isEmpty : blob]) {
            @throw [[SDKException alloc] initWithCode : INVALID_BLOB_ERROR];
        }
        NSData *blobData = [Tools hexStrToData : blob];
        NSError *error = nil;
        Transaction *tran = [Transaction parseFromData : blobData error : &error];
        if ([Tools isEmpty : tran] || ![Tools isEmpty : error]) {
            @throw [[SDKException alloc] initWithCode : INVALID_BLOB_ERROR];
        }
        NSMutableArray<NSString *> *privateKeys = [transactionSignRequest getPrivateKeys];
        if ([Tools isEmpty : privateKeys]) {
            @throw [[SDKException alloc] initWithCode : PRIVATEKEY_NULL_ERROR];
        }
        NSMutableArray<SignatureInfo *> *signatures = [[NSMutableArray alloc] init];
        for (NSString *privateKey in privateKeys) {
            if (![Tools isPrivateKeyValid : privateKey]) {
                @throw [[SDKException alloc] initWithCode : PRIVATEKEY_ONE_ERROR];
            }
            SignatureInfo *signatureInfo = [SignatureInfo new];
            signatureInfo.signData = [Tools sign : privateKey : blobData];
            signatureInfo.publicKey = [Tools getPublicKey : privateKey];
            [signatures addObject : signatureInfo];
        }
        transactionSignResult.signatures = [signatures copy];
        [transactionSignResponse buildResponse:(SUCCESS) : transactionSignResult];
    }
    @catch(SDKException *sdkException) {
        [transactionSignResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : transactionSignResult];
    }
    return transactionSignResponse;
}

/**
 Submit a transaction
 
 @param transactionSubmitRequest
            transactionBlob(NSString *) : The transaction blob
 @return TransactionSubmitResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(TransactionSubmitResult *)
                nonce(int64_t) : the nonce of an account
 */
- (TransactionSubmitResponse *) submit : (TransactionSubmitRequest *) transactionSubmitRequest {
    TransactionSubmitResponse *transactionSubmitResponse = [TransactionSubmitResponse new];
    TransactionSubmitResult *transactionSubmitResult = [TransactionSubmitResult new];
    @try {
        if ([Tools isEmpty : transactionSubmitRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *blob = [transactionSubmitRequest getTransactionBlob];
        if ([Tools isEmpty : blob]) {
            @throw [[SDKException alloc] initWithCode : INVALID_BLOB_ERROR];
        }
        NSData *blobData = [Tools hexStrToData : blob];
        NSError *error = nil;
        Transaction *tran = [Transaction parseFromData : blobData error : &error];
        if ([Tools isEmpty : tran] || ![Tools isEmpty : error]) {
            @throw [[SDKException alloc] initWithCode : INVALID_BLOB_ERROR];
        }
        NSMutableArray<SignatureInfo *> *signatures = [transactionSubmitRequest getSignatures];
        if ([Tools isEmpty : signatures]) {
            @throw [[SDKException alloc] initWithCode : SIGNATURE_EMPTY_ERROR];
        }
        NSMutableDictionary *submitTransaction = [NSMutableDictionary dictionary];
        NSMutableArray<NSMutableDictionary *> *transactionItems = [[NSMutableArray<NSMutableDictionary *> alloc] init];
        NSMutableDictionary *transactionItem = [NSMutableDictionary dictionary];
        [transactionItem setObject : blob forKey : @"transaction_blob"];
        
        NSMutableArray<NSMutableDictionary *> *signatureItems = [[NSMutableArray<NSMutableDictionary *> alloc] init];
        for (SignatureInfo *signature in signatures) {
            NSMutableDictionary *signatureItem = [NSMutableDictionary dictionary];
            NSString *signData = signature.signData;
            if ([Tools isEmpty : signData]) {
                @throw [[SDKException alloc] initWithCode : SIGNDATA_NULL_ERROR];
            }
            NSString *publicKey = signature.publicKey;
            if ([Tools isEmpty : publicKey]) {
                @throw [[SDKException alloc] initWithCode : PUBLICKEY_NULL_ERROR];
            }
            [signatureItem setObject : signData forKey : @"sign_data"];
            [signatureItem setObject : publicKey forKey : @"public_key"];
            [signatureItems addObject : signatureItem];
        }
        [transactionItem setObject : signatureItems forKey : @"signatures"];
        [transactionItems addObject : transactionItem];
        [submitTransaction setObject : transactionItems forKey : @"items"];
        error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject : submitTransaction options : NSJSONWritingPrettyPrinted error : &error];
        if ([Tools isEmpty : jsonData] || ![Tools isEmpty : error]) {
            @throw [[SDKException alloc] initWithCode : SYSTEM_ERROR];
        }
        NSString *jsonString = [[NSString alloc] initWithData : jsonData encoding : NSUTF8StringEncoding];
        NSString *submitUrl = [[General sharedInstance] transactionSubmitUrl];
        NSData *result = [Http post : submitUrl : jsonString];
        TransactionSubmitHttpResponse *transactionSubmitHttpResponse = [TransactionSubmitHttpResponse yy_modelWithJSON : result];
        int32_t successCount = transactionSubmitHttpResponse.successCount;
        NSArray<TransactionSubmitHttpResult *> *results = transactionSubmitHttpResponse.results;
        if (![Tools isEmpty : results]) {
            transactionSubmitResult.transactionHash = [results objectAtIndex : 0].transactionHash;
            if (0 == successCount) {
                int32_t errorCode = [results objectAtIndex : 0].errorCode;
                NSString *errorDesc = [results objectAtIndex : 0].errorDesc;
                @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : errorDesc];
            }
        } else {
            @throw [[SDKException alloc] initWithCode : SYSTEM_ERROR];
        }
        [transactionSubmitResponse buildResponse : SUCCESS : transactionSubmitResult];
    }
    @catch(SDKException *sdkException) {
        [transactionSubmitResponse buildResponse:[sdkException getErrorCode] :[sdkException getErrorDesc] :transactionSubmitResult];
    }
    return transactionSubmitResponse;
}

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
- (TransactionGetInfoResponse *) getInfo : (TransactionGetInfoRequest *) transactionGetInfoRequest {
    TransactionGetInfoResponse *transactionGetInfoResponse = [TransactionGetInfoResponse new];
    TransactionGetInfoResult *transactionGetInfoResult = [TransactionGetInfoResult new];
    @try {
        if ([Tools isEmpty:transactionGetInfoRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *hash = [transactionGetInfoRequest getHash];
        if ([Tools isEmpty: hash] || [hash length] != HASH_HEX_LENGTH) {
            @throw [[SDKException alloc] initWithCode : INVALID_HASH_ERROR];
        }
        transactionGetInfoResponse = [TransactionServiceImpl getTransactionInfo : hash];
        int32_t errorCode = transactionGetInfoResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Transaction (%@) doest not exist", hash]];
        }
    }
    @catch(SDKException *sdkException) {
        [transactionGetInfoResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(transactionGetInfoResult)];
    }
    @catch(NSException *exception) {
        [transactionGetInfoResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(transactionGetInfoResult)];
    }
    return transactionGetInfoResponse;
}


/**
 Build operations

 @param operations The operation to be built
 @param sourceAddress The source account to start a transaction
 @param transaction The  transaction to be sent
 */
- (void) buildOperation : (NSMutableArray<BaseOperation *> *)operations : (NSString *) sourceAddress : (Transaction **)transaction {
    for (BaseOperation *baseOperation in operations) {
        Operation *operation = nil;
        OperationType operationType = [baseOperation getOperationType];
        switch (operationType) {
            case ACCOUNT_ACTIVATE:
                operation = [AccountServiceImpl activate : (AccountActivateOperation *)baseOperation : sourceAddress];
                break;
            case ACCOUNT_SET_METADATA:
                operation = [AccountServiceImpl setMetadata : (AccountSetMetadataOperation *)baseOperation];
                break;
            case ACCOUNT_SET_PRIVILEGE:
                operation = [AccountServiceImpl setPrivilege : (AccountSetPrivilegeOperation *)baseOperation];
                break;
            case ASSET_ISSUE:
                operation = [AssetServiceImpl issue : (AssetIssueOperation *)baseOperation];
                break;
            case ASSET_SEND:
                operation = [AssetServiceImpl send : (AssetSendOperation *) baseOperation : sourceAddress];
                break;
            case BU_SEND:
                operation = [BuServiceImpl send : (BUSendOperation *)baseOperation : sourceAddress];
                break;
            case TOKEN_ISSUE:
                operation = [Ctp10TokenServiceImpl issue : (Ctp10TokenIssueOperation *)baseOperation];
                break;
            case TOKEN_TRANSFER:
                operation = [Ctp10TokenServiceImpl transfer : (Ctp10TokenTransferOperation *)baseOperation : sourceAddress];
                break;
            case TOKEN_TRANSFER_FROM:
                operation = [Ctp10TokenServiceImpl transferFrom : (Ctp10TokenTransferFromOperation *)baseOperation : sourceAddress];
                break;
            case TOKEN_APPROVE:
                operation = [Ctp10TokenServiceImpl approve : (Ctp10TokenApproveOperation *)baseOperation : sourceAddress];
                break;
            case TOKEN_ASSIGN:
                operation = [Ctp10TokenServiceImpl assign : (Ctp10TokenAssignOperation *)baseOperation : sourceAddress];
                break;
            case TOKEN_CHANGE_OWNER:
                operation = [Ctp10TokenServiceImpl changeOwner : (Ctp10TokenChangeOwnerOperation *)baseOperation : sourceAddress];
                break;
            case CONTRACT_CREATE:
                operation = [ContractServiceImpl create : (ContractCreateOperation *)baseOperation];
                break;
            case CONTRACT_INVOKE_BY_ASSET:
                operation = [ContractServiceImpl invokeByAsset : (ContractInvokeByAssetOperation *)baseOperation : sourceAddress];
                break;
            case CONTRACT_INVOKE_BY_BU:
                operation = [ContractServiceImpl invokeByBU : (ContractInvokeByBUOperation *)baseOperation : sourceAddress];
                break;
            case LOG_CREATE:
                operation = [LogServiceImpl create : (LogCreateOperation *)baseOperation];
                break;
            default:
                @throw [[SDKException alloc] initWithCode : OPERATIONS_ONE_ERROR];
                break;
        }
        if ([Tools isEmpty : operation]) {
            @throw [[SDKException alloc] initWithCode : OPERATIONS_ONE_ERROR];
        }
        [(*transaction).operationsArray addObject: operation];
    }
}

- (TransactionInfo *) transactionToInfo: (Transaction *)transaction {
    if ([Tools isEmpty: transaction] || transaction.operationsArray_Count == 0) {
        return nil;
    }
    TransactionInfo *transactionInfo = [TransactionInfo new];
    
    transactionInfo.sourceAddress = transaction.sourceAddress;
    transactionInfo.nonce = transaction.nonce;
    if (![Tools isEmpty: transaction.metadata]) {
        transactionInfo.metadata = [[NSString alloc] initWithData:transaction.metadata encoding:transaction.metadata.length];
    }
    transactionInfo.ceilLedgerSeq = transaction.ceilLedgerSeq;
    transactionInfo.feeLimit = transaction.feeLimit;
    transactionInfo.gasPrice = transaction.gasPrice;
    transactionInfo.chainId = transaction.chainId;
    
    NSMutableArray *operations = [NSMutableArray new];
    for (Operation *operation in transaction.operationsArray) {
        OperationInfo *operationInfo = [OperationInfo new];
        Operation_Type type = operation.type;
        operationInfo.type = type;
        operationInfo.sourceAddress = operation.sourceAddress;
        operationInfo.metadata = [[NSString alloc] initWithData:operation.metadata encoding:operation.metadata.length];
        switch (type) {
            case Operation_Type_CreateAccount: {
                AccountActiviateInfo *accountActivateInfo = [AccountActiviateInfo new];
                accountActivateInfo.destAddress = operation.createAccount.destAddress;
                accountActivateInfo.initBalance = operation.createAccount.initBalance;
                if ([Tools isEmpty: operation.createAccount.contract]) {
                    ContractInfo *contractInfo = [ContractInfo new];
                    contractInfo.payload = operation.createAccount.contract.payload;
                    accountActivateInfo.contract = contractInfo;
                }
                accountActivateInfo.input = operation.createAccount.initInput;
                operationInfo.createAccount = accountActivateInfo;
            }
                break;
            case Operation_Type_IssueAsset: {
                AssetIssueInfo *assetIssueInfo = [AssetIssueInfo new];
                assetIssueInfo.code = operation.issueAsset.code;
                assetIssueInfo.amount = operation.issueAsset.amount;
                operationInfo.issueAsset = assetIssueInfo;
            }
                break;
            case Operation_Type_PayAsset: {
                AssetSendInfo *assetSendInfo = [AssetSendInfo new];
                assetSendInfo.destAddress = operation.payAsset.destAddress;
                assetSendInfo.input = operation.payAsset.input;
                AssetInfo *assetInfo = [AssetInfo new];
                AssetKeyInfo *assetKeyInfo = [AssetKeyInfo new];
                assetKeyInfo.issuer = operation.payAsset.asset.key.issuer;
                assetKeyInfo.code = operation.payAsset.asset.key.code;
                assetInfo.key = assetKeyInfo;
                assetInfo.amount = operation.payAsset.asset.amount;
                assetSendInfo.asset = assetInfo;
                operationInfo.sendAsset = assetSendInfo;
            }
                break;
            case Operation_Type_SetMetadata: {
                AccountSetMetadataInfo *accountSetMetadataInfo = [AccountSetMetadataInfo new];
                accountSetMetadataInfo.key = operation.setMetadata.key;
                accountSetMetadataInfo.value = operation.setMetadata.value;
                accountSetMetadataInfo.version = operation.setMetadata.version;
                accountSetMetadataInfo.deleteFlag = operation.setMetadata.deleteFlag;
                operationInfo.setMetadata = accountSetMetadataInfo;
            }
                break;
            case Operation_Type_PayCoin: {
                BUSendInfo *buSendInfo = [BUSendInfo new];
                buSendInfo.destAddress = operation.payCoin.destAddress;
                buSendInfo.amount = operation.payCoin.amount;
                buSendInfo.input = operation.payCoin.input;
                operationInfo.sendBU = buSendInfo;
            }
                break;
            case Operation_Type_Log: {
                LogInfo *logInfo = [LogInfo new];
                logInfo.topic = operation.log.topic;
                logInfo.datas = [operation.log.datasArray copy];
                operationInfo.log = logInfo;
            }
                break;
            case Operation_Type_SetPrivilege: {
                AccountSetPrivilegeInfo *accountSetPrivilegeInfo = [AccountSetPrivilegeInfo new];
                accountSetPrivilegeInfo.masterWeight = operation.setPrivilege.masterWeight;
                accountSetPrivilegeInfo.txThreshold = operation.setPrivilege.txThreshold;
                if (operation.setPrivilege.signersArray_Count > 0) {
                    NSMutableArray *signers = [NSMutableArray new];
                    for (Signer *signer in operation.setPrivilege.signersArray) {
                        SignerInfo *signerInfo = [SignerInfo new];
                        signerInfo.address = signer.address;
                        signerInfo.weight = signer.weight;
                        [signers addObject: signerInfo];
                    }
                    accountSetPrivilegeInfo.signers = [signers copy];
                }
                if (operation.setPrivilege.typeThresholdsArray_Count > 0) {
                    NSMutableArray *typeThresholds = [NSMutableArray new];
                    for (OperationTypeThreshold *operationTypeThreshold in operation.setPrivilege.typeThresholdsArray) {
                        TypeThreshold *typeThreshold = [TypeThreshold new];
                        typeThreshold.type = operationTypeThreshold.type;
                        typeThreshold.threshold = operationTypeThreshold.threshold;
                        [typeThresholds addObject: typeThreshold];
                    }
                    accountSetPrivilegeInfo.typeThresholds = typeThresholds;
                }
                operationInfo.setPrivilege = accountSetPrivilegeInfo;
            }
                break;
            default:
                @throw [[SDKException alloc] initWithCode : OPERATIONS_ONE_ERROR];
        }
        [operations addObject: operationInfo];
    }
    transactionInfo.operations = operations;
    return transactionInfo;
}

- (OperationInfo *) setOperation: (OperationType)operationType : (Operation *)operation {
    if ([Tools isEmpty: operation]) {
        return nil;
    }
    
    OperationInfo *operationInfo = [OperationInfo new];
    operationInfo.type = operation.type;
    operationInfo.sourceAddress = operation.sourceAddress;
    if (![Tools isEmpty: operation.metadata]) {
        operationInfo.metadata = [[NSString alloc] initWithData:operation.metadata encoding:NSUTF8StringEncoding];
    }
    
    switch (operationType) {
        case ACCOUNT_ACTIVATE: {
            AccountActiviateInfo *accountActivateInfo = [AccountActiviateInfo new];
            accountActivateInfo.destAddress = operation.createAccount.destAddress;
            accountActivateInfo.initBalance = operation.createAccount.initBalance;
            operationInfo.createAccount = accountActivateInfo;
        }
            break;
        case ACCOUNT_SET_METADATA: {
            AccountSetMetadataInfo *accountSetMetadataInfo = [AccountSetMetadataInfo new];
            accountSetMetadataInfo.key = operation.setMetadata.key;
            accountSetMetadataInfo.value = operation.setMetadata.value;
            accountSetMetadataInfo.version = operation.setMetadata.version;
            accountSetMetadataInfo.deleteFlag = operation.setMetadata.deleteFlag;
            operationInfo.setMetadata = accountSetMetadataInfo;
        }
            break;
        case ACCOUNT_SET_PRIVILEGE: {
            AccountSetPrivilegeInfo *accountSetPrivilegeInfo = [AccountSetPrivilegeInfo new];
            accountSetPrivilegeInfo.masterWeight = operation.setPrivilege.masterWeight;
            accountSetPrivilegeInfo.txThreshold = operation.setPrivilege.txThreshold;
            if (operation.setPrivilege.signersArray_Count > 0) {
                NSMutableArray *signers = [NSMutableArray new];
                for (Signer *signer in operation.setPrivilege.signersArray) {
                    SignerInfo *signerInfo = [SignerInfo new];
                    signerInfo.address = signer.address;
                    signerInfo.weight = signer.weight;
                    [signers addObject: signerInfo];
                }
                accountSetPrivilegeInfo.signers = [signers copy];
            }
            if (operation.setPrivilege.typeThresholdsArray_Count > 0) {
                NSMutableArray *typeThresholds = [NSMutableArray new];
                for (OperationTypeThreshold *operationTypeThreshold in operation.setPrivilege.typeThresholdsArray) {
                    TypeThreshold *typeThreshold = [TypeThreshold new];
                    typeThreshold.type = operationTypeThreshold.type;
                    typeThreshold.threshold = operationTypeThreshold.threshold;
                    [typeThresholds addObject: typeThreshold];
                }
                accountSetPrivilegeInfo.typeThresholds = typeThresholds;
            }
            operationInfo.setPrivilege = accountSetPrivilegeInfo;
        }
            break;
        case ASSET_ISSUE: {
            AssetIssueInfo *assetIssueInfo = [AssetIssueInfo new];
            assetIssueInfo.code = operation.issueAsset.code;
            assetIssueInfo.amount = operation.issueAsset.amount;
            operationInfo.issueAsset = assetIssueInfo;
        }
            break;
        case CONTRACT_INVOKE_BY_ASSET:
        case ASSET_SEND: {
            AssetSendInfo *assetSendInfo = [AssetSendInfo new];
            assetSendInfo.destAddress = operation.payAsset.destAddress;
            assetSendInfo.input = operation.payAsset.input;
            AssetInfo *assetInfo = [AssetInfo new];
            AssetKeyInfo *assetKeyInfo = [AssetKeyInfo new];
            assetKeyInfo.issuer = operation.payAsset.asset.key.issuer;
            assetKeyInfo.code = operation.payAsset.asset.key.code;
            assetInfo.key = assetKeyInfo;
            assetInfo.amount = operation.payAsset.asset.amount;
            assetSendInfo.asset = assetInfo;
            operationInfo.sendAsset = assetSendInfo;
        }
            break;
        case BU_SEND: {
            BUSendInfo *buSendInfo = [BUSendInfo new];
            buSendInfo.destAddress = operation.payCoin.destAddress;
            buSendInfo.amount = operation.payCoin.amount;
            operationInfo.sendBU = buSendInfo;
        }
            break;
        case CONTRACT_CREATE:
        case TOKEN_ISSUE: {
            AccountActiviateInfo *accountActivateInfo = [AccountActiviateInfo new];
            accountActivateInfo.destAddress = operation.createAccount.destAddress;
            accountActivateInfo.initBalance = operation.createAccount.initBalance;
            ContractInfo *contractInfo = [ContractInfo new];
            contractInfo.payload = operation.createAccount.contract.payload;
            accountActivateInfo.contract = contractInfo;
            accountActivateInfo.input = operation.createAccount.initInput;
            operationInfo.createAccount = accountActivateInfo;
        }
            break;
        case TOKEN_TRANSFER:
        case TOKEN_TRANSFER_FROM:
        case TOKEN_APPROVE:
        case TOKEN_ASSIGN:
        case TOKEN_CHANGE_OWNER:
        case CONTRACT_INVOKE_BY_BU: {
            BUSendInfo *buSendInfo = [BUSendInfo new];
            buSendInfo.destAddress = operation.payCoin.destAddress;
            buSendInfo.amount = operation.payCoin.amount;
            buSendInfo.input = operation.payCoin.input;
            operationInfo.sendBU = buSendInfo;
        }
            break;
        case LOG_CREATE: {
            LogInfo *logInfo = [LogInfo new];
            logInfo.topic = operation.log.topic;
            logInfo.datas = [operation.log.datasArray copy];
        }
            break;
        default:
            @throw [[SDKException alloc] initWithCode : OPERATIONS_ONE_ERROR];
            break;
    }
    return operationInfo;
}

+ (TransactionGetInfoResponse *) getTransactionInfo : (NSString *) hash {
    if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
        @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
    }
    NSString *getInfoUrl = [[General sharedInstance] transactionGetInfoUrl: hash];
    NSData *result = [Http get: getInfoUrl];
    return [TransactionGetInfoResponse yy_modelWithJSON: result];
}

@end
