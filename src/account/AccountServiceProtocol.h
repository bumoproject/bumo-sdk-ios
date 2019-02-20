//
//  OperationProtocol.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountCheckValidRequest.h"
#import "AccountCheckValidResponse.h"
#import "AccountCreateResponse.h"
#import "AccountGetInfoRequest.h"
#import "AccountGetInfoResponse.h"
#import "AccountGetNonceRequest.h"
#import "AccountGetNonceResponse.h"
#import "AccountGetBalanceRequest.h"
#import "AccountGetBalanceResponse.h"
#import "AccountGetAssetsRequest.h"
#import "AccountGetAssetsResponse.h"
#import "AccountGetMetadataRequest.h"
#import "AccountGetMetadataResponse.h"

@protocol AccountServiceProtocol <NSObject>
@required

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
- (AccountCheckValidResponse *) checkValid : (AccountCheckValidRequest *) accountCheckValidRequest;


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
- (AccountCreateResponse *) create;


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
- (AccountGetInfoResponse *) getInfo : (AccountGetInfoRequest *) accountGetInfoRequest;


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
- (AccountGetNonceResponse *) getNonce : (AccountGetNonceRequest *) accountGetNonceRequest;

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
- (AccountGetBalanceResponse *) getBalance : (AccountGetBalanceRequest *) accountGetBalanceRequest;


/**
 Get all assets of an account
 
 @param accountGetAssetsRequest
            address(NSString *) : the address of an account
 @return AccountGetAssetsResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(AccountGetAssetsResult *)
                assets(NSArray<AssetInfo *> *) : asset list
                    key(AssetKeyInfo *) : asset key
                    code(NSString *) : asset code
                    issuer(NSString *) : asset issuer
                amount(int64_t) : asset amount
 */
- (AccountGetAssetsResponse *) getAssets : (AccountGetAssetsRequest *) accountGetAssetsRequest;

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
- (AccountGetMetadataResponse *) getMetadata : (AccountGetMetadataRequest *) accountGetMetadataRequest;

@end
