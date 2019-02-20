//
//  Ctp10TokenServiceImpl.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenService.h"
#import "Ctp10TokenIssueOperation.h"
#import "Ctp10TokenTransferOperation.h"
#import "Ctp10TokenTransferFromOperation.h"
#import "Ctp10TokenApproveOperation.h"
#import "Ctp10TokenAssignOperation.h"
#import "Ctp10TokenChangeOwnerOperation.h"
#import "Chain.pbobjc.h"

@interface Ctp10TokenServiceImpl : Ctp10TokenService
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
+ (Operation *) issue : (Ctp10TokenIssueOperation *) ctp10TokenIssueOperation;

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
+ (Operation *) transfer : (Ctp10TokenTransferOperation *) ctp10TokenTransferOperation : (NSString *) transSourceAddress;

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
+ (Operation *) transferFrom : (Ctp10TokenTransferFromOperation *) ctp10TokenTransferFromOperation : (NSString *) transSourceAddress;

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
+ (Operation *) approve : (Ctp10TokenApproveOperation *) ctp10TokenApproveOperation : (NSString *) transSourceAddress;

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
+ (Operation *) assign : (Ctp10TokenAssignOperation *) ctp10TokenAssignOperation : (NSString *) transSourceAddress;

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
+ (Operation *) changeOwner : (Ctp10TokenChangeOwnerOperation *) ctp10TokenChangeOwnerOperation : (NSString *) transSourceAddress;

/**
 Check the validation of the ctp 1.0 token
 
 @param contractAddress The contract account address
 */
+ (void) checkTokenValid : (NSString *) contractAddress;
@end
