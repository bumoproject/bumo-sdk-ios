//
//  accountService.m
//  test-sdk-ios
//
//  Created by dxl on 2018/7/31.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountServiceImpl.h"
#import "Tools.h"
#import "General.h"
#import "Constant.h"
#import "Http.h"
#import "SDKError.h"
#import "SDKException.h"
#import "YYModelClass.h"

@implementation AccountServiceImpl

/**
 Check the validity of the account address.
 
 @param accountCheckValidRequest
            address(NSString *):  account address
 @return AccountCheckValidResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(AccountCreateResult)
                isValid(BOOL): is or not valid
 */
-(AccountCheckValidResponse *) checkValid : (AccountCheckValidRequest *) accountCheckValidRequest {
    AccountCheckValidResponse *accountCheckValidResponse = [AccountCheckValidResponse new];
    AccountCheckValidResult *accountCheckValidResult = [AccountCheckValidResult new];
    @try {
        if ([Tools isEmpty:accountCheckValidRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *address = [accountCheckValidRequest getAddress];
        BOOL isValid = [Tools isAddressValid : address];
        accountCheckValidResult.isValid = isValid;
        [accountCheckValidResponse buildResponse:(SUCCESS) : accountCheckValidResult];
    }
    @catch(SDKException *sdkException) {
        [accountCheckValidResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc]  : accountCheckValidResult];
    }
    return accountCheckValidResponse;
}

/**
 Create a new account, but it is not in bu chain.
 
 @return AccountCreateResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(AccountCreateResult)
                privateKey(NSString *): encode private key
                publicKey(NSString *): encode public key
                address(NSString *): encode address
 */
- (AccountCreateResponse *) create {
    AccountCreateResponse *accountCreateResponse = [AccountCreateResponse new];
    AccountCreateResult *accountCreateResult = [AccountCreateResult new];
    NSDictionary *account = [Tools createAccount];
    [accountCreateResult setPrivateKey:[account objectForKey:@"privateKey"]];
    [accountCreateResult setPublicKey:[account objectForKey:@"publicKey"]];
    [accountCreateResult setAddress:[account objectForKey:@"address"]];
    [accountCreateResponse buildResponse:(SUCCESS) :(accountCreateResult)];
    return accountCreateResponse;
}

/**
 Get the info of an account that is in bu chain.
 
 @param accountGetInfoRequest
            address(NSString *):  account address
 @return AccountGetInfoResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(AccountCreateResult)
                address(NSString *): account address
                balance(int64_t): account balance
                nonce(int64_t): account tx sequence
                priv(Priv *): account privilege
                    masterWeight(int64_t): self weight
                    signers(NSArray<SignerInfo *> *): signer weight list
                        address(NSString *): signer address
                        weight(int64_t): signer weight
                    threshold(Threshold *): tx threshold
                        txThreshold(int64_t): default tx threshold
                        typeThresholds(NSArray<TypeThreshold *> *): threshold of different type
                            type(int64_t): operation type
                            threshold(int64_t): threshold of this type
 
 */
- (AccountGetInfoResponse *) getInfo : (AccountGetInfoRequest *) accountGetInfoRequest {
    AccountGetInfoResponse *accountGetInfoResponse = [AccountGetInfoResponse new];
    AccountGetInfoResult *accountGetInfoResult = [AccountGetInfoResult new];
    @try {
        if ([Tools isEmpty:accountGetInfoRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *address = [accountGetInfoRequest getAddress];
        if (![Tools isAddressValid : address]) {
            @throw [[SDKException alloc] initWithCode : INVALID_ADDRESS_ERROR];
        }
        General *general = [General sharedInstance];
        if ([Tools isEmpty : [general getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *url = [[General sharedInstance] accountGetInfoUrl: address];
        NSData *result = [Http get : url];
        accountGetInfoResponse = [AccountGetInfoResponse yy_modelWithJSON : result];
        int32_t errorCode = accountGetInfoResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Account (%@) doest not exist",address]];
        }
        if (errorCode != 0) {
            NSString *errorDesc = accountGetInfoResponse.errorDesc;
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
        }
    }
    @catch(SDKException *sdkException) {
        [accountGetInfoResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : (accountGetInfoResult)];
    }
    @catch(NSException *exception) {
        [accountGetInfoResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(accountGetInfoResult)];
    }
    return accountGetInfoResponse;
}

/**
 Get the nonce of an account
 
 @param accountGetNonceRequest
            address(NSString *) : the address of an account
 @return AccountGetNonceResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(AccountGetNonceResult *)
            nonce(int64_t) : the nonce of an account
 */
- (AccountGetNonceResponse *) getNonce : (AccountGetNonceRequest *) accountGetNonceRequest {
    AccountGetNonceResponse *accountGetNonceResponse = [AccountGetNonceResponse new];
    AccountGetNonceResult *accountGetNonceResult = [AccountGetNonceResult new];
    @try {
        if ([Tools isEmpty:accountGetNonceRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *address = [accountGetNonceRequest getAddress];
        if (![Tools isAddressValid : address]) {
            @throw [[SDKException alloc] initWithCode : INVALID_ADDRESS_ERROR];
        }
        General *general = [General sharedInstance];
        if ([Tools isEmpty : [general getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *url = [[General sharedInstance] accountGetInfoUrl: address];
        NSData *result = [Http get : url];
        accountGetNonceResponse = [AccountGetNonceResponse yy_modelWithJSON : result];
        int32_t errorCode = accountGetNonceResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Account (%@) doest not exist",address]];
        }
        if (errorCode != 0) {
            NSString *errorDesc = accountGetNonceResponse.errorDesc;
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
        }
    }
    @catch(SDKException *sdkException) {
        [accountGetNonceResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc]  :(accountGetNonceResult)];
    }
    return accountGetNonceResponse;
}

/**
 Get the balance of an account
 
 @param accountGetBalanceRequest
            address(NSString *) : the address of an account
 @return AccountGetBalanceResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(AccountGetBalanceResult *)
            balance(int64_t) : the balance of an account
 */
- (AccountGetBalanceResponse *) getBalance : (AccountGetBalanceRequest *) accountGetBalanceRequest {
    AccountGetBalanceResponse *accountGetBalanceResponse = [AccountGetBalanceResponse new];
    AccountGetBalanceResult *accountGetBalanceResult = [AccountGetBalanceResult new];
    @try {
        if ([Tools isEmpty:accountGetBalanceRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *address = [accountGetBalanceRequest getAddress];
        if (![Tools isAddressValid : address]) {
            @throw [[SDKException alloc] initWithCode : INVALID_ADDRESS_ERROR];
        }
        General *general = [General sharedInstance];
        if ([Tools isEmpty : [general getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *url = [[General sharedInstance] accountGetInfoUrl: address];
        NSData *result = [Http get : url];
        accountGetBalanceResponse = [AccountGetBalanceResponse yy_modelWithJSON : result];
        int32_t errorCode = accountGetBalanceResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Account (%@) doest not exist",address]];
        }
        if (errorCode != 0) {
            NSString *errorDesc = accountGetBalanceResponse.errorDesc;
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
        }
        if ([Tools isEmpty: accountGetBalanceResponse.result]) {
            accountGetBalanceResult.balance = 0;
            [accountGetBalanceResponse buildResponse: SUCCESS : accountGetBalanceResult];
        }
    }
    @catch(SDKException *sdkException) {
        [accountGetBalanceResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc]  :(accountGetBalanceResult)];
    }
    return accountGetBalanceResponse;
}

/**
 Get all assets of an account
 
 @param accountGetAssetsRequest
            address(NSString *) : the address of an account
 @return AccountGetAssetsResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(AccountGetAssetsResult *)
                assets(AssetInfo *) : asset list
                    key(AssetKeyInfo *) : asset key
                        code(NSString *) : asset code
                        issuer(NSString *) : asset issuer
                    amount(int64_t) : asset amount
 */
- (AccountGetAssetsResponse *) getAssets : (AccountGetAssetsRequest *) accountGetAssetsRequest {
    AccountGetAssetsResponse *accountGetAssetsResponse = [AccountGetAssetsResponse new];
    AccountGetAssetsResult *accountGetAssetsResult = [AccountGetAssetsResult new];
    @try {
        if ([Tools isEmpty:accountGetAssetsRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *address = [accountGetAssetsRequest getAddress];
        if (![Tools isAddressValid : address]) {
            @throw [[SDKException alloc] initWithCode : INVALID_ADDRESS_ERROR];
        }
        General *general = [General sharedInstance];
        if ([Tools isEmpty : [general getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *url = [[General sharedInstance] accountGetAssetsUrl: address];
        NSData *result = [Http get : url];
        accountGetAssetsResponse = [AccountGetAssetsResponse yy_modelWithJSON : result];
        int32_t errorCode = accountGetAssetsResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Account (%@) doest not exist",address]];
        }
        if (errorCode != 0) {
            NSString *errorDesc = accountGetAssetsResponse.errorDesc;
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
        }
        NSArray *assetInfos = accountGetAssetsResponse.result.assets;
        if([Tools isEmpty : assetInfos]) {
            @throw [[SDKException alloc] initWithCode : NO_ASSET_ERROR];
        }
    }
    @catch(SDKException *sdkException) {
        [accountGetAssetsResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc]  :(accountGetAssetsResult)];
    }
    return accountGetAssetsResponse;
}

/**
 Get metadata of an account
 
 @param accountGetMetadataRequest
            address(NSString *) : the address of an account
            key(NSString *) : the key of metadata, if this is null, it will return all metadatas
 @return AccountGetMetadataResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(AccountGetMetadataResult *)
                metadatas(NSArray<AssetInfo *> *) : metadata list
                key(NSString *) key
                value(NSString *) value
                version(int64_t) version
 */
- (AccountGetMetadataResponse *) getMetadata : (AccountGetMetadataRequest *) accountGetMetadataRequest {
    AccountGetMetadataResponse *accountGetMetadataResponse = [AccountGetMetadataResponse new];
    AccountGetMetadataResult *accountGetMetadataResult = [AccountGetMetadataResult new];
    @try {
        if ([Tools isEmpty:accountGetMetadataRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *address = [accountGetMetadataRequest getAddress];
        if (![Tools isAddressValid : address]) {
            @throw [[SDKException alloc] initWithCode : INVALID_ADDRESS_ERROR];
        }
        NSString *key = [accountGetMetadataRequest getKey];
        if (![Tools isEmpty:key] && [key length] > METADATA_KEY_MAX) {
            @throw [[SDKException alloc] initWithCode : INVALID_DATAKEY_ERROR];
        }
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *url = [[General sharedInstance] accountGetMetadataUrl: address : key];
        NSData *result = [Http get : url];
        accountGetMetadataResponse = [AccountGetMetadataResponse yy_modelWithJSON : result];
        int32_t errorCode = accountGetMetadataResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Account (%@) doest not exist",address]];
        }
        if ([Tools isEmpty: accountGetMetadataResponse.result.metadatas]) {
            @throw [[SDKException alloc] initWithCode : NO_METADATA_ERROR];
        }
    }
    @catch(SDKException *sdkException) {
        [accountGetMetadataResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(accountGetMetadataResult)];
    }
    return accountGetMetadataResponse;
}

/**
 Create the operation that will activate an account that is not in bu chain

 @param accountActivateOperation
            sourceAddress(NSString *) : The account who will make this activation operation
            destAddress(NSString *) : The account who will be activated
            initBalance(int64_t) : The destination account init balance
            metadata(NSString *) : Notes
 
 @param transSourceAddress : The source account who will start the transaction
 @return Operation * ： The operation of protocol buffer
 */
+ (Operation *) activate : (AccountActivateOperation *) accountActivateOperation : (NSString *) transSourceAddress {
    if ([Tools isEmpty : accountActivateOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [accountActivateOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    NSString *destAddress = [accountActivateOperation getDestAddress];
    if (![Tools isAddressValid : destAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_DESTADDRESS_ERROR];
    }
    if ((![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : destAddress]) || [transSourceAddress isEqualToString : destAddress]) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_DESTADDRESS_ERROR];
    }
    int64_t initBalance = [accountActivateOperation getInitBalance];
    if (initBalance <= 0) {
        @throw [[SDKException alloc] initWithCode : INVALID_INITBALANCE_ERROR];
    }
    NSString *metadata = [accountActivateOperation getMetadata];
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
    [operationCreateAccount setDestAddress : destAddress];
    [operationCreateAccount setInitBalance : initBalance];
    AccountPrivilege *accountPrivilege = [AccountPrivilege message];
    [accountPrivilege setMasterWeight : 1];
    AccountThreshold *accountThreshold = [AccountThreshold message];
    [accountThreshold setTxThreshold : 1];
    [accountPrivilege setThresholds : accountThreshold];
    [operationCreateAccount setPriv : accountPrivilege];
    [operation setCreateAccount : operationCreateAccount];
    return operation;
}

/**
 Set the metadata of an account
 
 @param accountSetMetadataOperation
            sourceAddress(NSString *) : The account who will make this activation operation
            key(NSString *) : The metadata key
            value(NSString *) : The metadata value
            version(int64_t) : The metadata version
            deleteFlag(BOOL) : The flag that the metadata will be deleted
            metadata(NSString *) : Notes
 @return Operation *
 */
+ (Operation *) setMetadata : (AccountSetMetadataOperation *) accountSetMetadataOperation {
    if ([Tools isEmpty : accountSetMetadataOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [accountSetMetadataOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    NSString *key = [accountSetMetadataOperation getKey];
    if ([Tools isEmpty : key] || [key length] > METADATA_KEY_MAX) {
        @throw [[SDKException alloc] initWithCode : INVALID_DATAKEY_ERROR];
    }
    NSString *value = [accountSetMetadataOperation getValue];
    if ([Tools isEmpty:value] || [value length] > METADATA_VALUE_MAX) {
        @throw [[SDKException alloc] initWithCode : INVALID_DATAVALUE_ERROR];
    }
    int64_t version = [accountSetMetadataOperation getVersion];
    if (version < 0) {
        @throw [[SDKException alloc] initWithCode : INVALID_DATAVERSION_ERROR ];
    }
    BOOL deleteFlag = [accountSetMetadataOperation getDeleteFlag];
    NSString *metadata = [accountSetMetadataOperation getMetadata];
    // make operation
    Operation *operation = [Operation message];
    [operation setType : Operation_Type_SetMetadata];
    if (![Tools isEmpty : sourceAddress]) {
        [operation setSourceAddress : sourceAddress];
    }
    if (![Tools isEmpty : metadata]) {
        [operation setMetadata : [metadata dataUsingEncoding : NSUTF8StringEncoding]];
    }
    OperationSetMetadata *operationSetMetadata = [OperationSetMetadata message];
    [operationSetMetadata setKey : key];
    [operationSetMetadata setValue : value];
    if (version > 0) {
        [operationSetMetadata setVersion : version];
    }
    if (deleteFlag != false) {
        [operationSetMetadata setDeleteFlag : deleteFlag];
    }
    [operation setSetMetadata : operationSetMetadata];
    return operation;
}

/**
 Set the privilege of an account
 
 @param accountSetPrivilegeOperation
            sourceAddress(NSString *) : The account who will make this activation operation
            masterWeight(NSString *) : The account's self-weight
            signers(NSMutableArray<SignerInfo *> *) : The signer weight list
            txThreshold(NSString *) : The tx threshold
            typeThresholds(NSMutableArray<TypeThreshold *> *) : A transaction threshold that specifies a type of operation
            metadata(NSString *) : Notes
 @return Operation *
 */
+ (Operation *) setPrivilege : (AccountSetPrivilegeOperation *) accountSetPrivilegeOperation {
    if ([Tools isEmpty : accountSetPrivilegeOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [accountSetPrivilegeOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    NSString *masterWeight = [accountSetPrivilegeOperation getMasterWeight];
    if (![Tools isEmpty : masterWeight]) {
        NSString *pattern = @"^[-\\+]?[\\d]*$";
        NSError *error = nil;
        BOOL isNumber = [Tools regexMatch : pattern : masterWeight : &error];
        if (![Tools isEmpty : error]) {
            @throw [[SDKException alloc] initWithCode : SYSTEM_ERROR];
        }
        int64_t weight = [masterWeight longLongValue];
        if (!isNumber || weight < 0 || weight > UINT32_MAX) {
            @throw [[SDKException alloc] initWithCode : INVALID_MASTERWEIGHT_ERROR];
        }
    }
    NSString *txThreshold = [accountSetPrivilegeOperation getTxThreshold];
    if (![Tools isEmpty : txThreshold]) {
        NSString *pattern = @"^[-\\+]?[\\d]*$";
        NSError *error = nil;
        BOOL isNumber = [Tools regexMatch : pattern : txThreshold : &error];
        if (![Tools isEmpty : error]) {
            @throw [[SDKException alloc] initWithCode : SYSTEM_ERROR];
        }
        UInt64 thrshold = strtoull([txThreshold UTF8String], NULL, 0);
        if (!isNumber || thrshold > INT64_MAX || thrshold < 0) {
            @throw [[SDKException alloc] initWithCode : INVALID_TX_THRESHOLD_ERROR];
        }
    }
    NSString *metadata = [accountSetPrivilegeOperation getMetadata];
    // make operation
    Operation *operation = [Operation message];
    [operation setType: Operation_Type_SetPrivilege];
    if (![Tools isAddressValid : sourceAddress]) {
        [operation setSourceAddress : sourceAddress];
    }
    if ([Tools isEmpty : metadata]) {
        [operation setMetadata : [metadata dataUsingEncoding : NSUTF8StringEncoding]];
    }
    OperationSetPrivilege *operationSetPrivilege = [OperationSetPrivilege message];
    if (![Tools isEmpty : masterWeight]) {
        [operationSetPrivilege setMasterWeight : masterWeight];
    }
    if (![Tools isEmpty : txThreshold]) {
        [operationSetPrivilege setTxThreshold : txThreshold];
    }
    NSMutableArray<Signer *> *signers = [[NSMutableArray alloc] init];
    NSMutableArray<SignerInfo *> *signerInfos = [accountSetPrivilegeOperation getSigners];
    if (![Tools isEmpty : signerInfos]) {
        for (SignerInfo *signerInfo in signerInfos) {
            NSString *signerAddress = signerInfo.address;
            if (![Tools isAddressValid : signerAddress]) {
                @throw [[SDKException alloc] initWithCode : INVALID_SIGNER_ADDRESS_ERROR];
            }
            int64_t signerWeight = signerInfo.weight;
            if (signerWeight < 0 || signerWeight > UINT32_MAX) {
                @throw [[SDKException alloc] initWithCode : INVALID_SIGNER_WEIGHT_ERROR];
            }
            Signer *signer = [Signer message];
            [signer setAddress : signerAddress];
            [signer setWeight : signerWeight];
            [signers addObject : signer];
        }
    }
    [operationSetPrivilege setSignersArray : signers];
    NSMutableArray<OperationTypeThreshold *> *operationTypeThresholds = [[NSMutableArray alloc] init];
    NSMutableArray<TypeThreshold *> *typeThresholds = [accountSetPrivilegeOperation getTypeThresholds];
    if (![Tools isEmpty : typeThresholds]) {
        for (TypeThreshold *typeThreshold in typeThresholds) {
            int32_t type = typeThreshold.type;
            if (type < 1 || !Operation_Type_IsValidValue(type)) {
                @throw [[SDKException alloc] initWithCode : INVALID_TYPETHRESHOLD_TYPE_ERROR];
            }
            int64_t threshold = typeThreshold.threshold;
            if (threshold < 0) {
                @throw [[SDKException alloc] initWithCode : INVALID_TYPE_THRESHOLD_ERROR];
            }
            OperationTypeThreshold *operationTypeThreshold = [OperationTypeThreshold message];
            [operationTypeThreshold setType : type];
            [operationTypeThreshold setThreshold : threshold];
            [operationTypeThresholds addObject : operationTypeThreshold];
        }
    }
    [operationSetPrivilege setTypeThresholdsArray : operationTypeThresholds];
    [operation setSetPrivilege : operationSetPrivilege];
    return operation;
}

@end
