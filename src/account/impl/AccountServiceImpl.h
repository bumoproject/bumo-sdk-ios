//
//  accountService.h
//  test-sdk-ios
//
//  Created by dxl on 2018/7/31.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountService.h"
#import "AccountActivateOperation.h"
#import "AccountSetMetadataOperation.h"
#import "AccountSetPrivilegeOperation.h"
#import "Chain.pbobjc.h"

@interface AccountServiceImpl : AccountService
/**
 Create the operation that will activate an account witch is not in bu chain
 
 @param accountActivateOperation
            sourceAddress(NSString *) : The account who will make this activation operation
            destAddress(NSString *) : The account who will be activated
            initBalance(int64_t) : The destination account init balance
            metadata(NSString *) : Notes
 
 @param transSourceAddress : The source account who will start the transaction
 @return Operation *
 */
+ (Operation *) activate : (AccountActivateOperation *) accountActivateOperation : (NSString *) transSourceAddress;

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
+ (Operation *) setMetadata : (AccountSetMetadataOperation *) accountSetMetadataOperation;

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
+ (Operation *) setPrivilege : (AccountSetPrivilegeOperation *) accountSetPrivilegeOperation;
@end
