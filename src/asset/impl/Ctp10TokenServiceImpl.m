//
//  Ctp10TokenServiceImpl.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenServiceImpl.h"
#import "Ctp10TokenIssueInitInput.h"
#import "Ctp10TokenTransferInput.h"
#import "Ctp10TokenTransferFromInput.h"
#import "Ctp10TokenMessageResponse.h"
#import "ContractInvokeByBUOperation.h"
#import "Ctp10TokenApproveInput.h"
#import "Ctp10TokenAssignInput.h"
#import "Ctp10TokenChangeOwnerInput.h"
#import "Ctp10TokenAllowanceInput.h"
#import "Ctp10TokenGetInfoInput.h"
#import "Ctp10TokenGetBalanceInput.h"
#import "TokenQueryResponse.h"
#import "ContractServiceImpl.h"
#import "Tools.h"
#import "General.h"
#import "Constant.h"
#import "Http.h"
#import "SDKError.h"
#import "SDKException.h"
#import "YYModelClass.h"

@implementation Ctp10TokenServiceImpl
/**
 Issue ctp1.0 token
 
 @param ctp10TokenIssueOperation
            initBalance(int64_t) : Initial assets for the contract account, unit MO, 1 BU = 10^8 MO
            name(NSString *) : The ctp10Token name,
            symbol(NSString *) : The ctp10Token symbol
            decimals(int32_t) : The precision of the number of ctp10Token
            supply(NSString *) : The total supply issued by ctp10Token (without precision)
            metadata(NSString) : Notes
 
 @return Operation *
 */
+ (Operation *) issue : (Ctp10TokenIssueOperation *) ctp10TokenIssueOperation {
    if ([Tools isEmpty : ctp10TokenIssueOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [ctp10TokenIssueOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    int64_t initBalance = [ctp10TokenIssueOperation getInitBalance];
    if (initBalance <= 0) {
        @throw [[SDKException alloc] initWithCode : INVALID_INITBALANCE_ERROR];
    }
    NSString *name = [ctp10TokenIssueOperation getName];
    if ([Tools isEmpty : name] || [name length] > TOKEN_NAME_MAX) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_NAME_ERROR];
    }
    NSString *symbol = [ctp10TokenIssueOperation getSymbol];
    if ([Tools isEmpty : symbol] || [symbol length] > TOKEN_SYMBOL_MAX) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_SYMBOL_ERROR];
    }
    int32_t decimals = [ctp10TokenIssueOperation getDecimals];
    if (decimals < TOKEN_DECIMALS_MIN || decimals > TOKEN_DECIMALS_MAX) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_DECIMALS_ERROR];
    }
    NSString *supply = [ctp10TokenIssueOperation getSupply];
    if ([Tools isEmpty : supply]) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_SUPPLY_ERROR];
    }
    NSString *pattern = @"^[-\\+]?[\\d]*$";
    NSError *error = nil;
    BOOL isNumber = [Tools regexMatch : pattern : supply : &error];
    if (![Tools isEmpty : error]|| !isNumber || supply.longLongValue < 1 || supply.longLongValue * powl(10, decimals) < 1) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_SUPPLY_ERROR];
    }
    NSString *metadata = [ctp10TokenIssueOperation getMetadata];
    NSString *payload = TOKEN_PAYLOAD;
    Ctp10TokenIssueInitInput *initInput = [Ctp10TokenIssueInitInput new];
    Ctp10TokenIssueParams *params = [Ctp10TokenIssueParams new];
    params.name = name;
    params.symbol = symbol;
    params.decimals = decimals;
    params.supply = supply;
    initInput.params = params;
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
        [operationCreateAccount setInitInput : [initInput yy_modelToJSONString]];
    }
    Contract *contract = [Contract message];
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
 Send ctp1.0 token to another account
 
 @param ctp10TokenTransferOperation
            sourceAddress(NSString *) : The account who will make this sending asset operation
            contractAddress(NSString *) : The contract account address
            destAddress(NSString *) : The target account address to which token is transferred
            tokenAmount(NSSring *) : Tne amount of tokens to be transferred
            metadata(NSString *) : Notes
 
 @param transSourceAddress : The source account who will start the transaction
 @return Operation *
 */
+ (Operation *) transfer : (Ctp10TokenTransferOperation *) ctp10TokenTransferOperation : (NSString *) transSourceAddress {
    if ([Tools isEmpty : ctp10TokenTransferOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *destAddress = [ctp10TokenTransferOperation getDestAddress];
    if (![Tools isAddressValid : destAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_DESTADDRESS_ERROR];
    }
    NSString *tokenAmount = [ctp10TokenTransferOperation getTokenAmount];
    if ([Tools isEmpty : tokenAmount]) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_AMOUNT_ERROR];
    }
    NSString *pattern = @"^[-\\+]?[\\d]*$";
    NSError *error = nil;
    BOOL isNumber = [Tools regexMatch : pattern : tokenAmount : &error];
    if (![Tools isEmpty : error] || !isNumber || tokenAmount.longLongValue < 1) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_AMOUNT_ERROR];
    }
    NSString *sourceAddress = [ctp10TokenTransferOperation getSourceAddress];
    NSString *contractAddress = [ctp10TokenTransferOperation getContractAddress];
    BOOL isNotValid = (![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : destAddress]) || ([Tools isEmpty: sourceAddress] && [transSourceAddress isEqualToString : destAddress]);
    if (isNotValid) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_DESTADDRESS_ERROR];
    }
    NSString *metadata = [ctp10TokenTransferOperation getMetadata];
    [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
    // Build input
    Ctp10TokenTransferInput *input = [Ctp10TokenTransferInput new];
    Ctp10TokenTransferParams *params = [Ctp10TokenTransferParams new];
    params.to = destAddress;
    params.value = tokenAmount;
    input.params = params;
    
    return [Ctp10TokenServiceImpl invokeContract: sourceAddress : contractAddress : [input yy_modelToJSONString] : metadata];
}

/**
 Send ctp1.0 token from one acount to another account
 
 @param ctp10TokenTransferFromOperation
            sourceAddress(NSString *) : The account who will make this sending asset operation
            contractAddress(NSString *) : The contract account address
            fromAddress(NSString *) : The source account address from which token is transferred
            destAddress(NSString *) : The target account address to which token is transferred
            tokenAmount(NSSring *) : Tne amount of tokens to be transferred
            metadata(NSString *) : Notes
 
 @param transSourceAddress : The source account who will start the transaction
 @return Operation *
 */
+ (Operation *) transferFrom : (Ctp10TokenTransferFromOperation *) ctp10TokenTransferFromOperation : (NSString *) transSourceAddress {
    if ([Tools isEmpty : ctp10TokenTransferFromOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *fromAddress = [ctp10TokenTransferFromOperation getFromAddress];
    if (![Tools isAddressValid: fromAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_FROMADDRESS_ERROR];
    }
    NSString *destAddress = [ctp10TokenTransferFromOperation getDestAddress];
    if (![Tools isAddressValid : destAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_DESTADDRESS_ERROR];
    }
    NSString *tokenAmount = [ctp10TokenTransferFromOperation getTokenAmount];
    if ([Tools isEmpty : tokenAmount]) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_AMOUNT_ERROR];
    }
    NSString *pattern = @"^[-\\+]?[\\d]*$";
    NSError *error = nil;
    BOOL isNumber = [Tools regexMatch : pattern : tokenAmount : &error];
    if (![Tools isEmpty : error] || !isNumber || tokenAmount.longLongValue < 1) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_AMOUNT_ERROR];
    }
    NSString *sourceAddress = [ctp10TokenTransferFromOperation getSourceAddress];
    NSString *contractAddress = [ctp10TokenTransferFromOperation getContractAddress];
    BOOL isNotValid = (![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : contractAddress]) || ([Tools isEmpty: sourceAddress] && [transSourceAddress isEqualToString : contractAddress]);
    if (isNotValid) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_CONTRACTADDRESS_ERROR];
    }
    NSString *metadata = [ctp10TokenTransferFromOperation getMetadata];
    [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
    // Build input
    Ctp10TokenTransferFromInput *input = [Ctp10TokenTransferFromInput new];
    input.method = @"transferFrom";
    Ctp10TokenTransferFromParams *params = [Ctp10TokenTransferFromParams new];
    params.from = fromAddress;
    params.to = destAddress;
    params.value = tokenAmount;
    input.params = params;
    
    return [Ctp10TokenServiceImpl invokeContract: sourceAddress : contractAddress : [input yy_modelToJSONString] : metadata];
}

/**
 Approve some ctp1.0 token to another account
 
 @param ctp10TokenApproveOperation
            sourceAddress(NSString *) : The account who will make this sending asset operation
            contractAddress(NSString *) : The contract account address
            spender(NSString *) : The authorized account address
            tokenAmount(NSString *) : The number of authorized ctp10Tokens to be transferred
            metadata(NSString *) : Notes
 
 @param transSourceAddress : The source account who will start the transaction
 @return Operation *
 */
+ (Operation *) approve : (Ctp10TokenApproveOperation *) ctp10TokenApproveOperation : (NSString *) transSourceAddress {
    if ([Tools isEmpty : ctp10TokenApproveOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *spender = [ctp10TokenApproveOperation getSpender];
    if (![Tools isAddressValid: spender]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SPENDER_ERROR];
    }
    NSString *tokenAmount = [ctp10TokenApproveOperation getTokenAmount];
    if ([Tools isEmpty : tokenAmount]) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_AMOUNT_ERROR];
    }
    NSString *pattern = @"^[-\\+]?[\\d]*$";
    NSError *error = nil;
    BOOL isNumber = [Tools regexMatch : pattern : tokenAmount : &error];
    if (![Tools isEmpty : error] || !isNumber || tokenAmount.longLongValue < 1) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_AMOUNT_ERROR];
    }
    NSString *sourceAddress = [ctp10TokenApproveOperation getSourceAddress];
    NSString *contractAddress = [ctp10TokenApproveOperation getContractAddress];
    BOOL isNotValid = (![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : contractAddress]) || [transSourceAddress isEqualToString : contractAddress];
    if (isNotValid) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_CONTRACTADDRESS_ERROR];
    }
    NSString *metadata = [ctp10TokenApproveOperation getMetadata];
    [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
    // Build input
    Ctp10TokenApproveInput *input = [Ctp10TokenApproveInput new];
    input.method = @"approve";
    Ctp10TokenApproveParams *params = [Ctp10TokenApproveParams new];
    params.spender = spender;
    params.value = tokenAmount;
    input.params = params;
    
    return [Ctp10TokenServiceImpl invokeContract: sourceAddress : contractAddress : [input yy_modelToJSONString] : metadata];
}

/**
 Assign some ctp1.0 token to another account
 
 @param ctp10TokenAssignOperation
            sourceAddress(NSString *) : The account who will make this sending asset operation
            contractAddress(NSString *) : The contract account address
            destAddress(NSString *) : The target account address to be assigned
            tokenAmount(NSString *) : The number of authorized ctp10Tokens to be transferred
            metadata(NSString *) : Notes
 
 @param transSourceAddress : The source account who will start the transaction
 @return Operation *
 */
+ (Operation *) assign : (Ctp10TokenAssignOperation *) ctp10TokenAssignOperation : (NSString *) transSourceAddress {
    if ([Tools isEmpty : ctp10TokenAssignOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *destAddress = [ctp10TokenAssignOperation getDestAddress];
    if (![Tools isAddressValid : destAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_DESTADDRESS_ERROR];
    }
    NSString *tokenAmount = [ctp10TokenAssignOperation getTokenAmount];
    if ([Tools isEmpty : tokenAmount]) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_AMOUNT_ERROR];
    }
    NSString *pattern = @"^[-\\+]?[\\d]*$";
    NSError *error = nil;
    BOOL isNumber = [Tools regexMatch : pattern : tokenAmount : &error];
    if (![Tools isEmpty : error] || !isNumber || tokenAmount.longLongValue < 1) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKEN_AMOUNT_ERROR];
    }
    NSString *sourceAddress = [ctp10TokenAssignOperation getSourceAddress];
    NSString *contractAddress = [ctp10TokenAssignOperation getContractAddress];
    BOOL isNotValid = (![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : contractAddress]) || ([Tools isEmpty: sourceAddress] && [transSourceAddress isEqualToString : contractAddress]);
    if (isNotValid) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_CONTRACTADDRESS_ERROR];
    }
    NSString *metadata = [ctp10TokenAssignOperation getMetadata];
    [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
    // Build input
    Ctp10TokenAssignInput *input = [Ctp10TokenAssignInput new];
    input.method = @"assign";
    Ctp10TokenAssignParams *params = [Ctp10TokenAssignParams new];
    params.to = destAddress;
    params.value = tokenAmount;
    input.params = params;
    
    return [Ctp10TokenServiceImpl invokeContract: sourceAddress : contractAddress : [input yy_modelToJSONString] : metadata];
}

/**
 Change the owner of the ctp1.0 token
 
 @param ctp10TokenChangeOwnerOperation
            sourceAddress(NSString *) : The account who will make this sending asset operation
            contractAddress(NSString *) : The contract account address
            tokenOwner(NSString *) : The target account address to which token is transferred
            metadata(NSString *) : Notes
 
 @param transSourceAddress : The source account who will start the transaction
 @return Operation *
 */
+ (Operation *) changeOwner : (Ctp10TokenChangeOwnerOperation *) ctp10TokenChangeOwnerOperation : (NSString *) transSourceAddress {
    if ([Tools isEmpty : ctp10TokenChangeOwnerOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *tokenOwner = [ctp10TokenChangeOwnerOperation getTokenOwner];
    if (![Tools isAddressValid: tokenOwner]) {
        @throw [[SDKException alloc] initWithCode : INVALID_TOKENOWNER_ERROR];
    }
    NSString *sourceAddress = [ctp10TokenChangeOwnerOperation getSourceAddress];
    NSString *contractAddress = [ctp10TokenChangeOwnerOperation getContractAddress];
    BOOL isNotValid = (![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : contractAddress]) || ([Tools isEmpty: sourceAddress] && [transSourceAddress isEqualToString : contractAddress]);
    if (isNotValid) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_CONTRACTADDRESS_ERROR];
    }
    NSString *metadata = [ctp10TokenChangeOwnerOperation getMetadata];
    [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
    // Build input
    Ctp10TokenChangeOwnerInput *input = [Ctp10TokenChangeOwnerInput new];
    input.method = @"changeOwner";
    Ctp10TokenChangeOwnerParams *params = [Ctp10TokenChangeOwnerParams new];
    params.address = tokenOwner;
    input.params = params;
    
    return [Ctp10TokenServiceImpl invokeContract: sourceAddress : contractAddress : [input yy_modelToJSONString] : metadata];
}

/**
 Check the validation of ctp 1.0 token
 
 @param ctp10TokenCheckValidRequest
            contractAddress(NSString *) : the address of the contract
@return Ctp10TokenCheckValidResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(Ctp10TokenCheckValidResult *)
                isValid(BOOL) : the validation of ctp 1.0 token
 */
- (Ctp10TokenCheckValidResponse *) checkValid : (Ctp10TokenCheckValidRequest *) ctp10TokenCheckValidRequest {
    Ctp10TokenCheckValidResponse *ctp10TokenCheckValidResponse = [Ctp10TokenCheckValidResponse new];
    Ctp10TokenCheckValidResult *ctp10TokenCheckValidResult = [Ctp10TokenCheckValidResult new];
    @try {
        if ([Tools isEmpty : ctp10TokenCheckValidRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *contractAddress = [ctp10TokenCheckValidRequest getContractAddress];
        [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
        ctp10TokenCheckValidResult.isValid = true;
        [ctp10TokenCheckValidResponse buildResponse: SUCCESS : ctp10TokenCheckValidResult];
    }
    @catch(SDKException *sdkException) {
        [ctp10TokenCheckValidResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc]  :(ctp10TokenCheckValidResult)];
    }
    @catch(NSException *exception) {
        [ctp10TokenCheckValidResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(ctp10TokenCheckValidResult)];
    }
    return ctp10TokenCheckValidResponse;
}

/**
 Obtain the amount that the spender allows to extract from the owner
 
 @param ctp10TokenAllowanceRequest
            contractAddress(NSString *) : the address of the contract
            tokenOwner(NSString *) : The account address holding the contract Token
            spender(NSString *) : Authorized account address
 @return Ctp10TokenAllowanceResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(Ctp10TokenAllowanceResult *)
                allowance(NSString *) : Allowed amount to be withdrawn
 */
- (Ctp10TokenAllowanceResponse *) allowance : (Ctp10TokenAllowanceRequest *) ctp10TokenAllowanceRequest {
    Ctp10TokenAllowanceResponse *ctp10TokenAllowanceResponse = [Ctp10TokenAllowanceResponse new];
    Ctp10TokenAllowanceResult *ctp10TokenAllowanceResult = [Ctp10TokenAllowanceResult new];
    @try {
        if ([Tools isEmpty : ctp10TokenAllowanceRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *tokenOwner = [ctp10TokenAllowanceRequest getTokenOwner];
        if (![Tools isAddressValid: tokenOwner]) {
            @throw [[SDKException alloc] initWithCode : INVALID_TOKENOWNER_ERROR];
        }
        NSString *spender = [ctp10TokenAllowanceRequest getSpender];
        if (![Tools isAddressValid: spender]) {
            @throw [[SDKException alloc] initWithCode : INVALID_SPENDER_ERROR];
        }
        NSString *contractAddress = [ctp10TokenAllowanceRequest getContractAddress];
        [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
        // Build input
        Ctp10TokenAllowanceInput *input = [Ctp10TokenAllowanceInput new];
        input.method = @"allowance";
        Ctp10TokenAllowanceParams *params = [Ctp10TokenAllowanceParams new];
        params.owner = tokenOwner;
        params.spender = spender;
        input.params = params;
        NSDictionary *queryResult = [Ctp10TokenServiceImpl queryContract: contractAddress : [input yy_modelToJSONString]];
        TokenQueryResponse *tokenQueryResponse = [TokenQueryResponse yy_modelWithDictionary : queryResult];
        TokenQueryResult *tokenQueryResult = tokenQueryResponse.result;
        TokenErrorResult *tokenErrorResult = tokenQueryResponse.error;
        if ([Tools isEmpty : tokenQueryResult] || ![Tools isEmpty: tokenErrorResult]) {
            NSString *errorDesc = tokenErrorResult.data.exception;
            @throw [[SDKException alloc] initWithCodeAndDesc: GET_ALLOWANCE_ERROR : errorDesc];
        }
        ctp10TokenAllowanceResult = [Ctp10TokenAllowanceResult yy_modelWithJSON: [tokenQueryResult value]];
        [ctp10TokenAllowanceResponse buildResponse: SUCCESS : ctp10TokenAllowanceResult];
    }
    @catch(SDKException *sdkException) {
        [ctp10TokenAllowanceResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : (ctp10TokenAllowanceResult)];
    }
    @catch(NSException *exception) {
        [ctp10TokenAllowanceResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(ctp10TokenAllowanceResult)];
    }
    return ctp10TokenAllowanceResponse;
}

/**
 Obtain information about the contract token
 
 @param ctp10TokenGetInfoRequest
            contractAddress(NSString *) : the address of the contract
 @return Ctp10TokenGetInfoResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(Ctp10TokenGetInfoResult *)
                ctp(NSString *) : Contract Token version number
                symbol(NSString *) : Contract Token symbol
                decimals(int32_t) : Accuracy of the number of contracts
                totalSupply(NSString *) : Total supply of tokens
                name(NSString *) : The name of the contract token
                contractOwner(NSString *) : Owner of the contract token
 */
- (Ctp10TokenGetInfoResponse *) getInfo : (Ctp10TokenGetInfoRequest *) ctp10TokenGetInfoRequest {
    Ctp10TokenGetInfoResponse *ctp10TokenGetInfoResponse = [Ctp10TokenGetInfoResponse new];
    Ctp10TokenGetInfoResult *ctp10TokenGetInfoResult = [Ctp10TokenGetInfoResult new];
    @try {
        if ([Tools isEmpty : ctp10TokenGetInfoRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *contractAddress = [ctp10TokenGetInfoRequest getContractAddress];
        [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
        // Build input
        Ctp10TokenGetInfoInput *input = [Ctp10TokenGetInfoInput new];
        input.method = @"contractInfo";
        NSDictionary *queryResult = [Ctp10TokenServiceImpl queryContract: contractAddress : [input yy_modelToJSONString]];
        TokenQueryResponse *tokenQueryResponse = [TokenQueryResponse yy_modelWithDictionary : queryResult];
        TokenQueryResult *tokenQueryResult = tokenQueryResponse.result;
        TokenErrorResult *tokenErrorResult = tokenQueryResponse.error;
        if ([Tools isEmpty : tokenQueryResult] || ![Tools isEmpty: tokenErrorResult]) {
            NSString *errorDesc = tokenErrorResult.data.exception;
            @throw [[SDKException alloc] initWithCodeAndDesc: GET_TOKEN_INFO_ERROR : errorDesc];
        }
        ctp10TokenGetInfoResult = [Ctp10TokenGetInfoResult yy_modelWithJSON: [tokenQueryResult value]];
        [ctp10TokenGetInfoResponse buildResponse: SUCCESS : ctp10TokenGetInfoResult];
    }
    @catch(SDKException *sdkException) {
        [ctp10TokenGetInfoResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : (ctp10TokenGetInfoResult)];
    }
    @catch(NSException *exception) {
        [ctp10TokenGetInfoResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(ctp10TokenGetInfoResult)];
    }
    return ctp10TokenGetInfoResponse;
}

/**
 Obtain information about the contract token
 
 @param ctp10TokenGetNameRequest
            contractAddress(NSString *) : the address of the contract
 @return Ctp10TokenGetNameResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(Ctp10TokenGetNameResult *)
                name(NSString *) : The name of the contract token
 */
- (Ctp10TokenGetNameResponse *) getName : (Ctp10TokenGetNameRequest *) ctp10TokenGetNameRequest {
    Ctp10TokenGetNameResponse *ctp10TokenGetNameResponse = [Ctp10TokenGetNameResponse new];
    Ctp10TokenGetNameResult *ctp10TokenGetNameResult = [Ctp10TokenGetNameResult new];
    @try {
        if ([Tools isEmpty : ctp10TokenGetNameRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *contractAddress = [ctp10TokenGetNameRequest getContractAddress];
        [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
        // Build input
        Ctp10TokenGetInfoInput *input = [Ctp10TokenGetInfoInput new];
        input.method = @"name";
        NSDictionary *queryResult = [Ctp10TokenServiceImpl queryContract: contractAddress : [input yy_modelToJSONString]];
        TokenQueryResponse *tokenQueryResponse = [TokenQueryResponse yy_modelWithDictionary : queryResult];
        TokenQueryResult *tokenQueryResult = tokenQueryResponse.result;
        TokenErrorResult *tokenErrorResult = tokenQueryResponse.error;
        if ([Tools isEmpty : tokenQueryResult] || ![Tools isEmpty: tokenErrorResult]) {
            NSString *errorDesc = tokenErrorResult.data.exception;
            @throw [[SDKException alloc] initWithCodeAndDesc: GET_TOKEN_INFO_ERROR : errorDesc];
        }
        ctp10TokenGetNameResult = [Ctp10TokenGetNameResult yy_modelWithJSON: [tokenQueryResult value]];
        [ctp10TokenGetNameResponse buildResponse: SUCCESS : ctp10TokenGetNameResult];
    }
    @catch(SDKException *sdkException) {
        [ctp10TokenGetNameResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(ctp10TokenGetNameResult)];
    }
    @catch(NSException *exception) {
        [ctp10TokenGetNameResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(ctp10TokenGetNameResult)];
    }
    return ctp10TokenGetNameResponse;
}

/**
 Obtain symbol about the contract token
 
 @param ctp10TokenGetSymbolRequest
            contractAddress(NSString *) : the address of the contract
 @return Ctp10TokenGetSymbolResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(Ctp10TokenGetSymbolResult *)
                symbol(NSString *) : Contract Token symbol
 */
- (Ctp10TokenGetSymbolResponse *) getSymbol : (Ctp10TokenGetSymbolRequest *) ctp10TokenGetSymbolRequest {
    Ctp10TokenGetSymbolResponse *ctp10TokenGetSymbolResponse = [Ctp10TokenGetSymbolResponse new];
    Ctp10TokenGetSymbolResult *ctp10TokenGetSymbolResult = [Ctp10TokenGetSymbolResult new];
    @try {
        if ([Tools isEmpty : ctp10TokenGetSymbolRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *contractAddress = [ctp10TokenGetSymbolRequest getContractAddress];
        [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
        // Build input
        Ctp10TokenGetInfoInput *input = [Ctp10TokenGetInfoInput new];
        input.method = @"symbol";
        NSDictionary *queryResult = [Ctp10TokenServiceImpl queryContract: contractAddress : [input yy_modelToJSONString]];
        TokenQueryResponse *tokenQueryResponse = [TokenQueryResponse yy_modelWithDictionary : queryResult];
        TokenQueryResult *tokenQueryResult = tokenQueryResponse.result;
        TokenErrorResult *tokenErrorResult = tokenQueryResponse.error;
        if ([Tools isEmpty : tokenQueryResult] || ![Tools isEmpty: tokenErrorResult]) {
            NSString *errorDesc = tokenErrorResult.data.exception;
            @throw [[SDKException alloc] initWithCodeAndDesc: GET_TOKEN_INFO_ERROR : errorDesc];
        }
        ctp10TokenGetSymbolResult = [Ctp10TokenGetSymbolResult yy_modelWithJSON: [tokenQueryResult value]];
        [ctp10TokenGetSymbolResponse buildResponse: SUCCESS : ctp10TokenGetSymbolResult];
    }
    @catch(SDKException *sdkException) {
        [ctp10TokenGetSymbolResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(ctp10TokenGetSymbolResult)];
    }
    @catch(NSException *exception) {
        [ctp10TokenGetSymbolResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(ctp10TokenGetSymbolResult)];
    }
    return ctp10TokenGetSymbolResponse;
}

/**
 Obtain decimals about the contract token
 
 @param ctp10TokenGetDecimalsRequest
            contractAddress(NSString *) : the address of the contract
 @return Ctp10TokenGetDecimalsResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(Ctp10TokenGetDecimalsResult *)
                decimals(int32_t) : Accuracy of the number of contracts
 */
- (Ctp10TokenGetDecimalsResponse *) getDecimals : (Ctp10TokenGetDecimalsRequest *) ctp10TokenGetDecimalsRequest {
    Ctp10TokenGetDecimalsResponse *ctp10TokenGetDecimalsResponse = [Ctp10TokenGetDecimalsResponse new];
    Ctp10TokenGetDecimalsResult *ctp10TokenGetDecimalsResult = [Ctp10TokenGetDecimalsResult new];
    @try {
        if ([Tools isEmpty : ctp10TokenGetDecimalsRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *contractAddress = [ctp10TokenGetDecimalsRequest getContractAddress];
        [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
        // Build input
        Ctp10TokenGetInfoInput *input = [Ctp10TokenGetInfoInput new];
        input.method = @"decimals";
        NSDictionary *queryResult = [Ctp10TokenServiceImpl queryContract: contractAddress : [input yy_modelToJSONString]];
        TokenQueryResponse *tokenQueryResponse = [TokenQueryResponse yy_modelWithDictionary : queryResult];
        TokenQueryResult *tokenQueryResult = tokenQueryResponse.result;
        TokenErrorResult *tokenErrorResult = tokenQueryResponse.error;
        if ([Tools isEmpty : tokenQueryResult] || ![Tools isEmpty: tokenErrorResult]) {
            NSString *errorDesc = tokenErrorResult.data.exception;
            @throw [[SDKException alloc] initWithCodeAndDesc: GET_TOKEN_INFO_ERROR : errorDesc];
        }
        ctp10TokenGetDecimalsResult = [Ctp10TokenGetDecimalsResult yy_modelWithJSON: [tokenQueryResult value]];
        [ctp10TokenGetDecimalsResponse buildResponse: SUCCESS : ctp10TokenGetDecimalsResult];
    }
    @catch(SDKException *sdkException) {
        [ctp10TokenGetDecimalsResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(ctp10TokenGetDecimalsResult)];
    }
    @catch(NSException *exception) {
        [ctp10TokenGetDecimalsResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(ctp10TokenGetDecimalsResult)];
    }
    return ctp10TokenGetDecimalsResponse;
}

/**
 Obtain total supply number about the contract token
 
 @param ctp10TokenGetTotalSupplyRequest
            contractAddress(NSString *) : the address of the contract
 @return Ctp10TokenGetTotalSupplyResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(Ctp10TokenGetTotalSupplyResult *)
                totalSupply(NSString *) : Total supply of tokens
 */
- (Ctp10TokenGetTotalSupplyResponse *) getTotalSupply : (Ctp10TokenGetTotalSupplyRequest *) ctp10TokenGetTotalSupplyRequest {
    Ctp10TokenGetTotalSupplyResponse *ctp10TokenGetTotalSupplyResponse = [Ctp10TokenGetTotalSupplyResponse new];
    Ctp10TokenGetTotalSupplyResult *ctp10TokenGetTotalSupplyResult = [Ctp10TokenGetTotalSupplyResult new];
    @try {
        if ([Tools isEmpty : ctp10TokenGetTotalSupplyRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *contractAddress = [ctp10TokenGetTotalSupplyRequest getContractAddress];
        [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
        // Build input
        Ctp10TokenGetInfoInput *input = [Ctp10TokenGetInfoInput new];
        input.method = @"totalSupply";
        NSDictionary *queryResult = [Ctp10TokenServiceImpl queryContract: contractAddress : [input yy_modelToJSONString]];
        TokenQueryResponse *tokenQueryResponse = [TokenQueryResponse yy_modelWithDictionary : queryResult];
        TokenQueryResult *tokenQueryResult = tokenQueryResponse.result;
        TokenErrorResult *tokenErrorResult = tokenQueryResponse.error;
        if ([Tools isEmpty : tokenQueryResult] || ![Tools isEmpty: tokenErrorResult]) {
            NSString *errorDesc = tokenErrorResult.data.exception;
            @throw [[SDKException alloc] initWithCodeAndDesc: GET_TOKEN_INFO_ERROR : errorDesc];
        }
        ctp10TokenGetTotalSupplyResult = [Ctp10TokenGetTotalSupplyResult yy_modelWithJSON: [tokenQueryResult value]];
        [ctp10TokenGetTotalSupplyResponse buildResponse: SUCCESS : ctp10TokenGetTotalSupplyResult];
    }
    @catch(SDKException *sdkException) {
        [ctp10TokenGetTotalSupplyResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(ctp10TokenGetTotalSupplyResult)];
    }
    @catch(NSException *exception) {
        [ctp10TokenGetTotalSupplyResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(ctp10TokenGetTotalSupplyResult)];
    }
    
    return ctp10TokenGetTotalSupplyResponse;
}

/**
 Obtain information about the contract token
 
 @param ctp10TokenGetBalanceRequest
            contractAddress(NSString *) : the address of the contract
 @return Ctp10TokenGetBalanceResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(Ctp10TokenGetBalanceResult *)
                balance(int64_t) : Token balance
 */
- (Ctp10TokenGetBalanceResponse *) getBalance : (Ctp10TokenGetBalanceRequest *) ctp10TokenGetBalanceRequest {
    Ctp10TokenGetBalanceResponse *ctp10TokenGetBalanceResponse = [Ctp10TokenGetBalanceResponse new];
    Ctp10TokenGetBalanceResult *ctp10TokenGetBalanceResult = [Ctp10TokenGetBalanceResult new];
    @try {
        if ([Tools isEmpty : ctp10TokenGetBalanceRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *tokenOwner = [ctp10TokenGetBalanceRequest getTokenOwner];
        if (![Tools isAddressValid: tokenOwner]) {
            @throw [[SDKException alloc] initWithCode : INVALID_TOKENOWNER_ERROR];
        }
        NSString *contractAddress = [ctp10TokenGetBalanceRequest getContractAddress];
        [Ctp10TokenServiceImpl checkTokenValid: contractAddress];
        // Build input
        Ctp10TokenGetBalanceInput *input = [Ctp10TokenGetBalanceInput new];
        input.method = @"balanceOf";
        Ctp10TokenGetBalanceParams *params = [Ctp10TokenGetBalanceParams new];
        params.address = tokenOwner;
        input.params = params;
        NSDictionary *queryResult = [Ctp10TokenServiceImpl queryContract: contractAddress : [input yy_modelToJSONString]];
        TokenQueryResponse *tokenQueryResponse = [TokenQueryResponse yy_modelWithDictionary : queryResult];
        TokenQueryResult *tokenQueryResult = tokenQueryResponse.result;
        TokenErrorResult *tokenErrorResult = tokenQueryResponse.error;
        if ([Tools isEmpty : tokenQueryResult] || ![Tools isEmpty: tokenErrorResult]) {
            NSString *errorDesc = tokenErrorResult.data.exception;
            @throw [[SDKException alloc] initWithCodeAndDesc: GET_TOKEN_INFO_ERROR : errorDesc];
        }
        ctp10TokenGetBalanceResult = [Ctp10TokenGetBalanceResult yy_modelWithJSON: [tokenQueryResult value]];
        [ctp10TokenGetBalanceResponse buildResponse: SUCCESS : ctp10TokenGetBalanceResult];
    }
    @catch(SDKException *sdkException) {
        [ctp10TokenGetBalanceResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc]  :(ctp10TokenGetBalanceResult)];
    }
    @catch(NSException *exception) {
        [ctp10TokenGetBalanceResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(ctp10TokenGetBalanceResult)];
    }
    return ctp10TokenGetBalanceResponse;
}

+ (Operation *) invokeContract : (NSString *) sourceAddress : (NSString *) contractAddress : (NSString *)input : (NSString *) metadata {
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    if (![Tools isAddressValid : contractAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_CONTRACTADDRESS_ERROR];
    }
    ContractInvokeByBUOperation * contractInvokeByBUOperation = [ContractInvokeByBUOperation new];
    if (![Tools isEmpty: sourceAddress]) {
        [contractInvokeByBUOperation setSourceAddress: sourceAddress];
    }
    if (![Tools isEmpty: metadata]) {
        [contractInvokeByBUOperation setMetadata: metadata];
    }
    [contractInvokeByBUOperation setContractAddress: contractAddress];
    [contractInvokeByBUOperation setAmount: 0];
    [contractInvokeByBUOperation setInput: input];
    return [ContractServiceImpl invokeByBU: contractInvokeByBUOperation : sourceAddress];
}

+ (NSDictionary *) queryContract : (NSString *) contractAddress : (NSString *) input {
    // Call contract
    ContractCallResponse *response = [ContractServiceImpl callContract: nil: contractAddress: 2: nil :input : 0: 0: 1000000000];
    ContractCallResult *result = response.result;
    return [result.queryRets objectAtIndex: 0];
}

/**
 Check the validation of the ctp 1.0 token
 
 @param contractAddress The contract account address
 */
+ (void) checkTokenValid : (NSString *) contractAddress {
    if ([Tools isEmpty:[[General sharedInstance] getUrl]]) {
        @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
    }
    if (![Tools isAddressValid: contractAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_CONTRACTADDRESS_ERROR];
    }
    NSString *key = @"global_attribute";
    NSString *url = [[General sharedInstance] accountGetMetadataUrl: contractAddress : key];
    NSData *result = [Http get : url];
    Ctp10TokenMessageResponse *ctp10TokenMessageResponse = [Ctp10TokenMessageResponse yy_modelWithJSON : result];
    int32_t errorCode = ctp10TokenMessageResponse.errorCode;
    if (errorCode == 4) {
        @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Account (%@) doest not exist", contractAddress]];
    }
    if (errorCode != 0) {
        NSString *errorDesc = ctp10TokenMessageResponse.errorDesc;
        @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
    }
    Ctp10TokenMessageResult *ctp10TokenMessageResult = [ctp10TokenMessageResponse result];
    ContractInfo *contractInfo = [ctp10TokenMessageResult contract];
    NSArray<MetadataInfo *> *metadataInfos = [ctp10TokenMessageResult metadatas];
    if([Tools isEmpty: contractInfo] || [Tools isEmpty: [contractInfo payload]] || [Tools isEmpty: metadataInfos]) {
        @throw [[SDKException alloc] initWithCode : NO_SUCH_TOKEN_ERROR];
    }
    NSString *tokenInfoJson = metadataInfos[0].value;
    if ([Tools isEmpty : tokenInfoJson]) {
        @throw [[SDKException alloc] initWithCode : NO_SUCH_TOKEN_ERROR];
    }
    TokenInfo *tokenInfo = [TokenInfo yy_modelWithJSON : tokenInfoJson];
    if ([Tools isEmpty : tokenInfo]) {
        @throw [[SDKException alloc] initWithCode : NO_SUCH_TOKEN_ERROR];
    }
    NSError *error = nil;
    NSString *ctp = [tokenInfo ctp];
    if ([Tools isEmpty: ctp] || ![Tools regexMatch: @"^([1-9]*)+(.[0-9]{1,2})?$" : ctp : &error]) {
        @throw [[SDKException alloc] initWithCodeAndDesc : NO_SUCH_TOKEN_ERROR : @"The ctp is invalid"];
    }
    NSString *name = [tokenInfo name];
    if ([Tools isEmpty : name] || [name length] > TOKEN_NAME_MAX) {
        @throw [[SDKException alloc] initWithCodeAndDesc : NO_SUCH_TOKEN_ERROR : @"The length of name must be between 1 and 1024"];
    }
    NSString *symbol = [tokenInfo symbol];
    if ([Tools isEmpty: symbol] || [symbol length] > TOKEN_SYMBOL_MAX) {
        @throw [[SDKException alloc] initWithCodeAndDesc : NO_SUCH_TOKEN_ERROR : @"The length of symbol must be between 1 and 1024"];
    }
    int32_t decimals = [tokenInfo decimals];
    if (decimals < TOKEN_DECIMALS_MIN || decimals > TOKEN_DECIMALS_MAX) {
        @throw [[SDKException alloc] initWithCodeAndDesc : NO_SUCH_TOKEN_ERROR : @"The decimals must be between 0 and 8"];
    }
    NSString *totalSupply = [tokenInfo totalSupply];
    if ([Tools isEmpty: totalSupply] || ![Tools regexMatch: @"^[-\\+]?[\\d]*$" : totalSupply : &error]) {
        @throw [[SDKException alloc] initWithCodeAndDesc : NO_SUCH_TOKEN_ERROR : @"The decimals must be between 1 and max(int64)"];
    }
    NSString *tokenOwner = [tokenInfo contractOwner];
    if (![Tools isAddressValid: tokenOwner]) {
        @throw [[SDKException alloc] initWithCodeAndDesc : NO_SUCH_TOKEN_ERROR : @"Invalid tokenOwner"];
    }
}
@end
