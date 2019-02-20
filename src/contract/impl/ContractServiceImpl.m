//
//  ContractServiceImpl.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractServiceImpl.h"
#import "TransactionGetInfoResponse.h"
#import "TransactionServiceImpl.h"
#import "ContractCallInput.h"
#import "Tools.h"
#import "General.h"
#import "Constant.h"
#import "Http.h"
#import "SDKError.h"
#import "SDKException.h"
#import "YYModelClass.h"

@implementation ContractServiceImpl
/**
 Create the operation of Creating a new contract
 
 @param contractCreateOperation
            sourceAddress(NSString *) : The account who will start this operation
            contractAddress(NSString *) : The address of a contract
            initBalance(int64_t) : The code to be sent
            type(int32_t) : The issuer of a code
            payload(NSString *) : The amount of asset to be sent
            initInput(NSString *) : The input parameter of main function in contract
 @return Operation
 */
+ (Operation *) create : (ContractCreateOperation *) contractCreateOperation {
    if([Tools isEmpty: contractCreateOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [contractCreateOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    int64_t initBalance = [contractCreateOperation getInitBalance];
    if (initBalance <= 0) {
        @throw [[SDKException alloc] initWithCode : INVALID_INITBALANCE_ERROR];
    }
    int32_t type = [contractCreateOperation getType];
    if (type < 0) {
        @throw [[SDKException alloc] initWithCode : INVALID_CONTRACT_TYPE_ERROR];
    }
    NSString *payload = [contractCreateOperation getPayload];
    if ([Tools isEmpty: payload]) {
        @throw [[SDKException alloc] initWithCode : PAYLOAD_EMPTY_ERROR];
    }
    NSString *metadata = [contractCreateOperation getMetadata];
    NSString *initInput = [contractCreateOperation getInitInput];
    // make operation
    Operation *operation = [Operation message];
    [operation setType : Operation_Type_CreateAccount];
    if (![Tools isEmpty : sourceAddress]) {
        [operation setSourceAddress : sourceAddress];
    }
    if (![Tools isEmpty : metadata]) {
        [operation setMetadata : [metadata dataUsingEncoding : NSUTF8StringEncoding]];
    }
    OperationCreateAccount *operationCreateAccount = [OperationCreateAccount message];
    [operationCreateAccount setInitBalance : initBalance];
    if (![Tools isEmpty: initInput]) {
        [operationCreateAccount setInitInput : initInput];
    }
    Contract *contract = [Contract message];
    if (!Contract_ContractType_IsValidValue(type)) {
        @throw [[SDKException alloc] initWithCode : INVALID_CONTRACT_TYPE_ERROR];
    }
    [contract setType: type];
    [contract setPayload : payload];
    [operationCreateAccount setContract : contract];
    AccountPrivilege *accountPrivilege = [AccountPrivilege message];
    [accountPrivilege setMasterWeight : 0];
    AccountThreshold *accountThreshold = [AccountThreshold message];
    [accountThreshold setTxThreshold : 1];
    [accountPrivilege setThresholds : accountThreshold];
    [operationCreateAccount setPriv : accountPrivilege];
    [operation setCreateAccount : operationCreateAccount];
    return operation;
}

/**
 Send assets and invoke a contract
 
 @param contractInvokeByAssetOperation
            sourceAddress(NSString *) : The account who will start this operation
            contractAddress(NSString *) : The address of a contract
            code(NSString *) : The code to be sent
            issuer(NSString *) : The issuer of a code
            assetAmount(int64_t) : The amount of asset to be sent
            input(NSString *) : The input parameter of main function in contract
            metadata(NSString *) : Notes
 @return Operation
 */
+ (Operation *) invokeByAsset : (ContractInvokeByAssetOperation *) contractInvokeByAssetOperation : (NSString *) transSourceAddress {
    if ([Tools isEmpty : contractInvokeByAssetOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [contractInvokeByAssetOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    NSString *contractAddress = [contractInvokeByAssetOperation getContractAddress];
    if (![Tools isAddressValid : contractAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_CONTRACTADDRESS_ERROR];
    }
    BOOL isNotValid = (![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : contractAddress]) ||
                      [transSourceAddress isEqualToString : contractAddress];
    if (isNotValid) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_CONTRACTADDRESS_ERROR];
    }
    NSString *code = [contractInvokeByAssetOperation getCode];
    if (![Tools isEmpty : code] && [code length] > ASSET_CODE_MAX) {
        @throw [[SDKException alloc] initWithCode : INVALID_ASSET_CODE_ERROR];
    }
    NSString *issuer = [contractInvokeByAssetOperation getIssuer];
    if (![Tools isEmpty : issuer] && ![Tools isAddressValid : issuer]) {
        @throw [[SDKException alloc] initWithCode : INVALID_ISSUER_ADDRESS_ERROR];
    }
    int64_t amount = [contractInvokeByAssetOperation getAmount];
    if (amount < 0) {
        @throw [[SDKException alloc] initWithCode : INVALID_ASSET_AMOUNT_ERROR];
    }
    if (![self checkContractValid: contractAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_ASSET_AMOUNT_ERROR];
    }
    NSString *metadata = [contractInvokeByAssetOperation getMetadata];
    NSString *input = [contractInvokeByAssetOperation getInput];
    // make operation
    Operation *operation = [Operation message];
    [operation setType : Operation_Type_PayAsset];
    if (![Tools isEmpty : sourceAddress]) {
        [operation setSourceAddress : sourceAddress];
    }
    if (![Tools isEmpty : metadata]) {
        [operation setMetadata : [metadata dataUsingEncoding : NSUTF8StringEncoding]];
    }
    OperationPayAsset *operationPayAsset = [OperationPayAsset message];
    [operationPayAsset setDestAddress : contractAddress];
    if (![Tools isEmpty: input]) {
        [operationPayAsset setInput: input];
    }
    if (![Tools isEmpty : code] && ![Tools isEmpty : issuer] && amount > 0) {
        AssetKey *assetKey = [AssetKey message];
        [assetKey setCode : code];
        [assetKey setIssuer : issuer];
        Asset *asset = [Asset message];
        [asset setKey : assetKey];
        [asset setAmount : amount];
        [operationPayAsset setAsset : asset];
    }
    [operation setPayAsset : operationPayAsset];
    return operation;
}

/**
 Send BU and invoke a contract
 
 @param contractInvokeByBUOperation
            sourceAddress(NSString *) : The account who will start this operation
            contractAddress(NSString *) : The address of a contract
            buAmount(int64_t)  : The amount of bu to be sent
            input(NSString *)  : The input parameter of main function in contract
            metadata(NSString *)  : Notes
 @return Operation
 */
+ (Operation *) invokeByBU : (ContractInvokeByBUOperation *) contractInvokeByBUOperation : (NSString *) transSourceAddress {
    if ([Tools isEmpty : contractInvokeByBUOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [contractInvokeByBUOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    NSString *contractAddress = [contractInvokeByBUOperation getContractAddress];
    if (![Tools isAddressValid : contractAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_CONTRACTADDRESS_ERROR];
    }
    BOOL isNotValid = (![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : contractAddress]) ||
    [transSourceAddress isEqualToString : contractAddress];
    if (isNotValid) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_CONTRACTADDRESS_ERROR];
    }
    int64_t amount = [contractInvokeByBUOperation getAmount];
    if (amount < 0) {
        @throw [[SDKException alloc] initWithCode : INVALID_BU_AMOUNT_ERROR];
    }
    if (![self checkContractValid: contractAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_ASSET_AMOUNT_ERROR];
    }
    NSString *metadata = [contractInvokeByBUOperation getMetadata];
    NSString *input = [contractInvokeByBUOperation getInput];
    // make operation
    Operation *operation = [Operation message];
    [operation setType : Operation_Type_PayCoin];
    if (![Tools isEmpty : sourceAddress]) {
        [operation setSourceAddress : sourceAddress];
    }
    if (![Tools isEmpty : metadata]) {
        [operation setMetadata : [metadata dataUsingEncoding : NSUTF8StringEncoding]];
    }
    OperationPayCoin *operationPayCoin = [OperationPayCoin message];
    [operationPayCoin setDestAddress : contractAddress];
    [operationPayCoin setAmount : amount];
    [operation setPayCoin : operationPayCoin];
    if (![Tools isEmpty: input]) {
        [operationPayCoin setInput: input];
    }
    return operation;
}

/**
 Get the information of a contract
 
 @param contractGetInfoRequest
            contractAddress(NSString *) : the address of a contract
 @return AssetGetInfoResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(ContractGetInfoResult *)
                contractInfo(ContractInfo *) : The contract information
                    type(int32_t) : The contract type
                    payload(NSString *) : The contract codes
 */
- (ContractGetInfoResponse *) getInfo : (ContractGetInfoRequest *) contractGetInfoRequest {
    ContractGetInfoResponse *contractGetInfoResponse = [ContractGetInfoResponse new];
    ContractGetInfoResult *contractGetInfoResult = [ContractGetInfoResult new];
    @try {
        if ([Tools isEmpty:contractGetInfoRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *contractAddress = [contractGetInfoRequest getContractAddress];
        contractGetInfoResponse = [ContractServiceImpl getContractInfo: contractAddress];
    }
    @catch(SDKException *sdkException) {
        [contractGetInfoResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(contractGetInfoResult)];
    }
    @catch(NSException *exception) {
        [contractGetInfoResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(contractGetInfoResult)];
    }
    return contractGetInfoResponse;
}

/**
 Check the validation of a contract
 
 @param contractCheckValidRequest
            contractAddress(NSString *) : the address of a contract
 @return ContractCheckValidResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(ContractGetInfoResult *)
                isValid(BOOL) : The contract is or is not valid
 */
- (ContractCheckValidResponse *) checkValid : (ContractCheckValidRequest *) contractCheckValidRequest {
    ContractCheckValidResponse *contractCheckValidResponse = [ContractCheckValidResponse new];
    ContractCheckValidResult *contractCheckValidResult = [ContractCheckValidResult new];
    @try {
        if ([Tools isEmpty:contractCheckValidRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *contractAddress = [contractCheckValidRequest getContractAddress];
        contractCheckValidResult.isValid = [ContractServiceImpl checkContractValid: contractAddress];
        [contractCheckValidResponse buildResponse: (SUCCESS) :(contractCheckValidResult)];
    }
    @catch(SDKException *sdkException) {
        [contractCheckValidResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(contractCheckValidResult)];
    }
    @catch(NSException *exception) {
        [contractCheckValidResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(contractCheckValidResult)];
    }
    return contractCheckValidResponse;
}

/**
 Debug the contract
 
 @param contractCallRequest
            sourceAddress(NSString *) : the address of an account that will start this operation
            contractAddress(NSString *) : the address of a contract
            code(NSString *) : the code of a contract
            input(NSString *) : the input parameter of a contract codes
            contractBalance(NSString *) : The balance of starting this operation
            optType(int32_t) : The operation type
            feeLimit(int64_t) : The highest fee of starting this operation
            gasPrice(int64_t) : The gas price of starting this operation
 @return ContractCallResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(ContractCallResult *)
                logs(NSMutableDictionary) : The logs of a contract
                queryRets(NSMutableArray<NSMutableDictionary *> *) : all results of querying operation
                stat(ContractStat *) : Contract resource occupancy
                txs(NSArray<TransactionEnvs *> *) : Transaction set
 */
- (ContractCallResponse *) call : (ContractCallRequest *) contractCallRequest {
    ContractCallResponse *contractCallResponse = [ContractCallResponse new];
    ContractCallResult *contractCallResult = [ContractCallResult new];
    @try {
        if ([Tools isEmpty: contractCallRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *sourceAddress = [contractCallRequest getSourceAddress];
        NSString *contractAddress = [contractCallRequest getContractAddress];
        NSString *code = [contractCallRequest getCode];
        int64_t feeLimit = [contractCallRequest getFeeLimit];
        int32_t optType = [contractCallRequest getOptType];
        int64_t gasPrice = [contractCallRequest getGasPrice];
        NSString *input = [contractCallRequest getInput];
        int64_t contractBalance = [contractCallRequest getContractBalance];
        contractCallResponse = [ContractServiceImpl callContract:sourceAddress :contractAddress :optType : code : input : contractBalance : gasPrice : feeLimit];
    }@catch(SDKException *sdkException) {
        [contractCallResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(contractCallResult)];
    }
    @catch(NSException *exception) {
        [contractCallResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(contractCallResult)];
    }
    return contractCallResponse;
}

/**
 Get the address of a contract
 
 @param contractGetAddressRequest
            contractAddress(NSString *) : the address of a contract
 @return ContractGetAddressResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(ContractGetAddressResult *)
                contractAddressInfos(NSArray<ContractAddressInfo *> *) : Contract address set
                    contractAddress(NSString *) : Contract address
                    operationIndex(int32_t) : The subscript of the operation
 */
- (ContractGetAddressResponse *) getAddress : (ContractGetAddressRequest *) contractGetAddressRequest {
    ContractGetAddressResponse *contractGetAddressResponse = [ContractGetAddressResponse new];
    ContractGetAddressResult *contractGetAddressResult = [ContractGetAddressResult new];
    @try {
        if ([Tools isEmpty: contractGetAddressRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *hash = [contractGetAddressRequest getHash];
        if ([Tools isEmpty: hash] || [hash length] != HASH_HEX_LENGTH) {
            @throw [[SDKException alloc] initWithCode : INVALID_HASH_ERROR];
        }
        TransactionGetInfoResponse *transactionGetInfoResponse = [TransactionServiceImpl getTransactionInfo : hash];
        int32_t errorCode = transactionGetInfoResponse.errorCode;
        if (errorCode != 0) {
            NSString *errorDesc = transactionGetInfoResponse.errorDesc;
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
        }
        TransactionHistory *transactionHistory = [transactionGetInfoResponse.result.transactions objectAtIndex: 0];
        if ([Tools isEmpty: transactionHistory]) {
            @throw [[SDKException alloc] initWithCode : INVALID_HASH_ERROR];
        }
        errorCode = transactionHistory.errorCode;
        NSString *contractAddress = transactionHistory.errorDesc;
        if (errorCode != 0) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : contractAddress] ? @"error" : contractAddress)];
        }
        NSArray<ContractAddressInfo *> *contractAddressInfos = [NSArray yy_modelArrayWithClass: ContractAddressInfo.class json:contractAddress];
        if ([Tools isEmpty: contractAddressInfos]) {
            @throw [[SDKException alloc] initWithCode : INVALID_HASH_ERROR];
        }
        contractGetAddressResult.contractAddressInfos = contractAddressInfos;
        [contractGetAddressResponse buildResponse: SUCCESS : contractGetAddressResult];
    }
    @catch(SDKException *sdkException) {
        [contractGetAddressResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(contractGetAddressResult)];
    }
    @catch(NSException *exception) {
        [contractGetAddressResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(contractGetAddressResult)];
    }
    return contractGetAddressResponse;
}

/**
 Debug contract

 @param sourceAddress The source account that will start this transaction
 @param contractAddress The contract account to be invoked
 @param optType The operation type
 @param code The contract code
 @param input The input parameter in code
 @param contractBalance The contract initBalance
 @param gasPrice The gas price
 @param feeLimit The fee limit
 @return ContractCallResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(ContractCallResult *)
                logs(NSMutableDictionary) : The logs of a contract
                queryRets(NSMutableArray<NSMutableDictionary *> *) : all results of querying operation
                stat(ContractStat *) : Contract resource occupancy
                txs(NSArray<TransactionEnvs *> *) : Transaction set
 */
+ (ContractCallResponse *) callContract : (NSString *) sourceAddress : (NSString *) contractAddress : (int32_t) optType : (NSString *)code : (NSString *) input : (int64_t)contractBalance : (int64_t) gasPrice : (int64_t) feeLimit {
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    if (![Tools isEmpty: contractAddress] && ![Tools isAddressValid : contractAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_CONTRACTADDRESS_ERROR];
    }
    BOOL isNotValid = ![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : contractAddress];
    if (isNotValid) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_CONTRACTADDRESS_ERROR];
    }
    if (optType < OPT_TYPE_MIN || optType > OPT_TYPE_MAX) {
        @throw [[SDKException alloc] initWithCode : INVALID_OPTTYPE_ERROR];
    }
    if ([Tools isEmpty: code] && [Tools isEmpty: contractAddress]) {
        @throw [[SDKException alloc] initWithCode : CONTRACTADDRESS_CODE_BOTH_NULL_ERROR];
    }
    if (feeLimit < FEE_LIMIT_MIN) {
        @throw [[SDKException alloc] initWithCode : INVALID_FEELIMIT_ERROR];
    }
    General *general = [General sharedInstance];
    if ([Tools isEmpty : [general getUrl]]) {
        @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
    }
    ContractCallInput *contractCallInput = [ContractCallInput new];
    contractCallInput.optType = optType;
    contractCallInput.contractBalance = contractBalance;
    contractCallInput.feeLimit = feeLimit;
    contractCallInput.gasPrice = gasPrice;
    if (![Tools isEmpty: sourceAddress]) {
        contractCallInput.sourceAddress = sourceAddress;
    }
    if (![Tools isEmpty: contractAddress]) {
        contractCallInput.contractAddress = contractAddress;
    }
    if (![Tools isEmpty: code]) {
        contractCallInput.code = code;
    }
    if (![Tools isEmpty: input]) {
        contractCallInput.input = input;
    }
    NSString *contractCallUrl = [[General sharedInstance] contractCallUrl];
    NSData *result = [Http post : contractCallUrl : [contractCallInput yy_modelToJSONString]];
    return [ContractCallResponse yy_modelWithJSON : result];
}


/**
 Check the validation of contract address

 @param contractAddress The contract address
 @return BOOL true or false
 */
+ (BOOL) checkContractValid : (NSString *) contractAddress {
    [self getContractInfo: contractAddress];
    return true;
}

/**
 Get the information of a contract
 
 @param contractAddress the address of a contract
 
 @return AssetGetInfoResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(ContractGetInfoResult *)
                contractInfo(ContractInfo *) : The contract information
                    type(int32_t) : The contract type
                    payload(NSString *) : The contract codes
 */
+ (ContractGetInfoResponse *) getContractInfo : (NSString *) contractAddress {
    if (![Tools isAddressValid : contractAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_CONTRACTADDRESS_ERROR];
    }
    General *general = [General sharedInstance];
    if ([Tools isEmpty : [general getUrl]]) {
        @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
    }
    NSString *url = [[General sharedInstance] accountGetInfoUrl: contractAddress];
    NSData *result = [Http get : url];
    ContractGetInfoResponse *contractGetInfoResponse = [ContractGetInfoResponse yy_modelWithJSON : result];
    int32_t errorCode = contractGetInfoResponse.errorCode;
    if (errorCode == 4) {
        @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Contract (%@) doest not exist",contractAddress]];
    }
    if (errorCode != 0) {
        NSString *errorDesc = contractGetInfoResponse.errorDesc;
        @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
    }
    ContractInfo *contractInfo = contractGetInfoResponse.result.contract;
    if ([Tools isEmpty: contractInfo]) {
        @throw [[SDKException alloc] initWithCode : CONTRACTADDRESS_NOT_CONTRACTACCOUNT_ERROR];
    }
    NSString *payload = contractInfo.payload;
    if ([Tools isEmpty : payload]) {
        @throw [[SDKException alloc] initWithCode : CONTRACTADDRESS_NOT_CONTRACTACCOUNT_ERROR];
    }
    return contractGetInfoResponse;
}
@end
