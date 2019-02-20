//
//  ContractServiceImpl.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractService.h"
#import "ContractCreateOperation.h"
#import "ContractInvokeByAssetOperation.h"
#import "ContractInvokeByBUOperation.h"
#import "Chain.pbobjc.h"

@interface ContractServiceImpl : ContractService
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
+ (Operation *) create : (ContractCreateOperation *) contractCreateOperation;

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
+ (Operation *) invokeByAsset : (ContractInvokeByAssetOperation *) contractInvokeByAssetOperation : (NSString *) transSourceAddress;

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
+ (Operation *) invokeByBU : (ContractInvokeByBUOperation *) contractInvokeByBUOperation : (NSString *) transSourceAddress;

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
            contractCallResult(ContractCallResult *)
                logs(NSMutableDictionary) : The logs of a contract
                queryRets(NSMutableArray<NSMutableDictionary *> *) : all results of querying operation
                stat(ContractStat *) : Contract resource occupancy
                txs(NSArray<TransactionEnvs *> *) : Transaction set
 */
+ (ContractCallResponse *) callContract : (NSString *) sourceAddress : (NSString *) contractAddress : (int32_t) optType : (NSString *)code : (NSString *) input : (int64_t)contractBalance : (int64_t) gasPrice : (int64_t) feeLimit;
@end
