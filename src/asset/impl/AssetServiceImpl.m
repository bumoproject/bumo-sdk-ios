//
//  AssetServiceImpl.m
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AssetServiceImpl.h"
#import "Tools.h"
#import "General.h"
#import "Constant.h"
#import "Http.h"
#import "SDKError.h"
#import "SDKException.h"
#import "YYModelClass.h"

@implementation AssetServiceImpl
/**
 Get an asset of an account through asset key
 
 @param assetGetRequest
            address(NSString *) : the address of an account
 @return AssetGetInfoResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(AssetGetAssetResult *)
                assets(NSArray<AssetInfo *> *) : asset list
                    key(AssetKeyInfo *) : asset key
                        code(NSString *) : asset code
                        issuer(NSString *) : asset issuer
                    amount(int64_t) : asset amount
 */
- (AssetGetInfoResponse *) getInfo : (AssetGetInfoRequest *) assetGetRequest {
    AssetGetInfoResponse *assetGetInfoResponse = [AssetGetInfoResponse new];
    AssetGetInfoResult *assetGetInfoResult = [AssetGetInfoResult new];
    @try {
        if ([Tools isEmpty:assetGetRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        NSString *address = [assetGetRequest getAddress];
        if (![Tools isAddressValid : address]) {
            @throw [[SDKException alloc] initWithCode : INVALID_ADDRESS_ERROR];
        }
        NSString *code = [assetGetRequest getCode];
        if ([Tools isEmpty : code] || [code length] > ASSET_CODE_MAX) {
            @throw [[SDKException alloc] initWithCode : INVALID_ASSET_CODE_ERROR];
        }
        NSString *issuer = [assetGetRequest getIssuer];
        if (![Tools isAddressValid : issuer]) {
            @throw [[SDKException alloc] initWithCode : INVALID_ISSUER_ADDRESS_ERROR];
        }
        General *general = [General sharedInstance];
        if ([Tools isEmpty : [general getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *url = [[General sharedInstance] assetGetUrl:address : code : issuer];
        NSData *result = [Http get : url];
        assetGetInfoResponse = [AssetGetInfoResponse yy_modelWithJSON : result];
        int32_t errorCode = assetGetInfoResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Account (%@) doest not exist",address]];
        }
        if (errorCode != 0) {
            NSString *errorDesc = assetGetInfoResponse.errorDesc;
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
        }
        NSArray *assetInfos = assetGetInfoResponse.result.assets;
        if([Tools isEmpty : assetInfos]) {
            @throw [[SDKException alloc] initWithCode : NO_ASSET_ERROR];
        }
    }
    @catch(SDKException *sdkException) {
        [assetGetInfoResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] :(assetGetInfoResult)];
    }
    return assetGetInfoResponse;
}

/**
 Issue asset
 
 @param assetIssueOperation
            sourceAddress(NSString *) : The account who will make this issurance operation
            code(NSString *) : The asset code
            amount(int64_t) : The asset amount
            metadata(NSString *) : Notes
 
 @return Operation *
 */
+ (Operation *) issue : (AssetIssueOperation *) assetIssueOperation {
    if ([Tools isEmpty : assetIssueOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [assetIssueOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    NSString *code = [assetIssueOperation getCode];
    if ([Tools isEmpty : code] || [code length] > ASSET_CODE_MAX) {
        @throw [[SDKException alloc] initWithCode : INVALID_ASSET_CODE_ERROR];
    }
    int64_t amount = [assetIssueOperation getAmount];
    if (amount < 1) {
        @throw [[SDKException alloc] initWithCode : INVALID_ISSUE_AMOUNT_ERROR];
    }
    NSString *metadata = [assetIssueOperation getMetadata];
    // make operation
    Operation *operation = [Operation message];
    [operation setType : Operation_Type_IssueAsset];
    if (![Tools isEmpty : sourceAddress]) {
        [operation setSourceAddress : sourceAddress];
    }
    if (![Tools isEmpty : metadata]) {
        [operation setMetadata : [metadata dataUsingEncoding : NSUTF8StringEncoding]];
    }
    OperationIssueAsset *operationIssueAsset = [OperationIssueAsset message];
    [operationIssueAsset setCode : code];
    [operationIssueAsset setAmount : amount];
    
    [operation setIssueAsset : operationIssueAsset];
    return operation;
}

/**
 Send asset to other account that is in bu chain
 
 @param assetSendOperation
            sourceAddress(NSString *) : The account who will make this sending asset operation
            destAddress(NSString *) : The account who will receive the asset
            code(NSString *) : The asset code
            issuer(NSString *) : The asset issuer
            amount(int64_t) : The asset amount
            metadata(NSString *) : Notes
 
 @param transSourceAddress : The source account who will start the transaction
 @return Operation *
 */
+ (Operation *) send : (AssetSendOperation *) assetSendOperation : (NSString *) transSourceAddress {
    if ([Tools isEmpty : assetSendOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [assetSendOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    NSString *destAddress = [assetSendOperation getDestAddress];
    if (![Tools isAddressValid : destAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_DESTADDRESS_ERROR];
    }
    BOOL isNotValid = (![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : destAddress]) || [transSourceAddress isEqualToString : destAddress];
    if (isNotValid) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_DESTADDRESS_ERROR];
    }
    NSString *code = [assetSendOperation getCode];
    if ([Tools isEmpty : code] || [code length] > ASSET_CODE_MAX) {
        @throw [[SDKException alloc] initWithCode : INVALID_ASSET_CODE_ERROR];
    }
    NSString *issuer = [assetSendOperation getIssuer];
    if (![Tools isAddressValid : issuer]) {
        @throw [[SDKException alloc] initWithCode : INVALID_ISSUER_ADDRESS_ERROR];
    }
    int64_t amount = [assetSendOperation getAmount];
    if (amount < 0) {
        @throw [[SDKException alloc] initWithCode : INVALID_ASSET_AMOUNT_ERROR];
    }
    NSString *metadata = [assetSendOperation getMetadata];
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
    [operationPayAsset setDestAddress : destAddress];
    AssetKey *assetKey = [AssetKey message];
    [assetKey setCode : code];
    [assetKey setIssuer : issuer];
    Asset *asset = [Asset message];
    [asset setKey : assetKey];
    [asset setAmount : amount];
    [operationPayAsset setAsset : asset];
    [operation setPayAsset : operationPayAsset];
    return operation;
}
@end
