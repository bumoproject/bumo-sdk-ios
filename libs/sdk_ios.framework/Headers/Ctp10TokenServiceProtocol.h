//
//  Ctp10TokenServiceProtocol.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ctp10TokenCheckValidResponse.h"
#import "Ctp10TokenCheckValidRequest.h"
#import "Ctp10TokenAllowanceResponse.h"
#import "Ctp10TokenAllowanceRequest.h"
#import "Ctp10TokenGetInfoResponse.h"
#import "Ctp10TokenGetInfoRequest.h"
#import "Ctp10TokenGetNameResponse.h"
#import "Ctp10TokenGetNameRequest.h"
#import "Ctp10TokenGetSymbolResponse.h"
#import "Ctp10TokenGetSymbolRequest.h"
#import "Ctp10TokenGetDecimalsResponse.h"
#import "Ctp10TokenGetDecimalsRequest.h"
#import "Ctp10TokenGetTotalSupplyResponse.h"
#import "Ctp10TokenGetTotalSupplyRequest.h"
#import "Ctp10TokenGetBalanceResponse.h"
#import "Ctp10TokenGetBalanceRequest.h"

@protocol Ctp10TokenServiceProtocol <NSObject>
@required

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
- (Ctp10TokenCheckValidResponse *) checkValid : (Ctp10TokenCheckValidRequest *) ctp10TokenCheckValidRequest;

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
- (Ctp10TokenAllowanceResponse *) allowance : (Ctp10TokenAllowanceRequest *) ctp10TokenAllowanceRequest;

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
- (Ctp10TokenGetInfoResponse *) getInfo : (Ctp10TokenGetInfoRequest *) ctp10TokenGetInfoRequest;

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
- (Ctp10TokenGetNameResponse *) getName : (Ctp10TokenGetNameRequest *) ctp10TokenGetNameRequest;

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
- (Ctp10TokenGetSymbolResponse *) getSymbol : (Ctp10TokenGetSymbolRequest *) ctp10TokenGetSymbolRequest;

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
- (Ctp10TokenGetDecimalsResponse *) getDecimals : (Ctp10TokenGetDecimalsRequest *) ctp10TokenGetDecimalsRequest;

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
- (Ctp10TokenGetTotalSupplyResponse *) getTotalSupply : (Ctp10TokenGetTotalSupplyRequest *) ctp10TokenGetTotalSupplyRequest;

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
- (Ctp10TokenGetBalanceResponse *) getBalance : (Ctp10TokenGetBalanceRequest *) ctp10TokenGetBalanceRequest;
@end
