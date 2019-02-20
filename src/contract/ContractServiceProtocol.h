//
//  ContractServiceProtocol.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#ifndef ContractServiceProtocol_h
#define ContractServiceProtocol_h

#import "ContractGetInfoRequest.h"
#import "ContractGetInfoResponse.h"
#import "ContractCheckValidRequest.h"
#import "ContractCheckValidResponse.h"
#import "ContractCallRequest.h"
#import "ContractCallResponse.h"
#import "ContractGetAddressRequest.h"
#import "ContractGetAddressResponse.h"

@protocol ContractServiceProtocol <NSObject>
@required

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
- (ContractGetInfoResponse *) getInfo : (ContractGetInfoRequest *) contractGetInfoRequest;

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
- (ContractCheckValidResponse *) checkValid : (ContractCheckValidRequest *) contractCheckValidRequest;

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
- (ContractCallResponse *) call : (ContractCallRequest *) contractCallRequest;

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
- (ContractGetAddressResponse *) getAddress : (ContractGetAddressRequest *) contractGetAddressRequest;
@end

#endif /* ContractServiceProtocol_h */
