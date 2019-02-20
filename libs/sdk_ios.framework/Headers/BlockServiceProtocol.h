//
//  BlockServiceProtocol.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetNumberResponse.h"
#import "BlockCheckStatusResponse.h"
#import "BlockGetTransactionsRequest.h"
#import "BlockGetTransactionsResponse.h"
#import "BlockGetInfoRequest.h"
#import "BlockGetInfoResponse.h"
#import "BlockGetLatestInfoResponse.h"
#import "BlockGetValidatorsRequest.h"
#import "BlockGetValidatorsResponse.h"
#import "BlockGetLatestValidatorsResponse.h"
#import "BlockGetRewardRequest.h"
#import "BlockGetRewardResponse.h"
#import "BlockGetLatestRewardResponse.h"
#import "BlockGetFeesRequest.h"
#import "BlockGetFeesResponse.h"
#import "BlockGetLatestFeesResponse.h"

@protocol BlockServiceProtocol <NSObject>
@required

/**
 Get the block number

 @return BlockGetNumberResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockGetNumberResult)
                header(BlockNumber *): The block header
                    blockNumber(int64_t): The block number
 */
- (BlockGetNumberResponse *) getNumber;


/**
 Check the status of bu chain consensus

 @return BlockCheckStatusResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockCheckStatusResult *)
                isSynchronous(BOOL): The consensus is or not synchronous
 */
- (BlockCheckStatusResponse *) checkStatus;


/**
 Get the transactions in a block

 @param blockGetTransactionsRequest
            blockNumber(int64_t): The block number
 
 @return BlockGetTransactionsResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockGetTransactionsResult *)
                totalCount(int64_t): The tatal count of transactions
                transactions(NSArray<TransactionHistory *> *): The transaction set
 */
- (BlockGetTransactionsResponse *) getTransactions : (BlockGetTransactionsRequest *) blockGetTransactionsRequest;


/**
 Get the block info

 @param blockGetInfoRequest
            blockNumber(int64_t): The block number
 @return BlockGetInfoResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockGetInfoResult *)
                header(BlockNumber *): The block header
                    closeTime(int64_t): The block close time
                    number(int64_t): The block number
                    txCount(int64_t): The count of block transactions
                    version(NSString *): The block version
 */
- (BlockGetInfoResponse *) getInfo : (BlockGetInfoRequest *) blockGetInfoRequest;


/**
 Get the latest block info

 @return BlockGetLatestInfoResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockGetLatestInfoResult *)
                header(BlockNumber *): The block header
                    closeTime(int64_t): The block close time
                    number(int64_t): The block number
                    txCount(int64_t): The count of block transactions
                    version(NSString *): The block version
 */
- (BlockGetLatestInfoResponse *) getLatestInfo;


/**
 Get the validators

 @param blockGetValidatorsRequest
            blockNumber(int64_t): The block number
 @return BlockGetValidatorsResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockGetValidatorsResult *)
                validators(NSArray<ValidatorInfo *> *): The validator list
                    address(NSString *): The validator address
                    pledgeCoinAmount(int64_t): The pledge coin amount of validator
 */
- (BlockGetValidatorsResponse *) getValidators : (BlockGetValidatorsRequest *) blockGetValidatorsRequest;


/**
 Get the latest validators

 @return BlockGetLatestValidatorsResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockGetLatestValidatorsResult *)
                validators(NSArray<ValidatorInfo *> *): The validator list
                    address(NSString *): The validator address
                    pledgeCoinAmount(int64_t): The pledge coin amount of validator
 */
- (BlockGetLatestValidatorsResponse *) getLatestValidators;


/**
 Get the block reward and validators reward

 @param blockGetRewardRequest
            blockNumber(int64_t): The block number
 @return BlockGetRewardResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockGetRewardResult *)
                blockReward(int64_t): The block reward
                rewardResults(NSArray<ValidatorRewardInfo *> *): The validator reward list
                    validator(NSString *): The validator address
                    reward(int64_t): The validator reward
 */
- (BlockGetRewardResponse *) getReward : (BlockGetRewardRequest *) blockGetRewardRequest;


/**
 Get the latest block reward and validators reward

 @return BlockGetLatestRewardResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockGetLatestRewardResult *)
                blockReward(int64_t): The block reward
                rewardResults(NSArray<ValidatorRewardInfo *> *): The validator reward list
                    validator(NSString *): The validator address
                    reward(int64_t): The validator reward
 */
- (BlockGetLatestRewardResponse *) getLatestReward;


/**
 Get the fees

 @param blockGetFeesRequest
            blockNumber(int64_t): The block number
 @return BlockGetFeesResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockGetFeesResult *)
                fees(Fees *): The fees
                    baseReserve(int64_t): The base reserve
                    gasPrice(int64_t): The gas price
 */
- (BlockGetFeesResponse *) getFees : (BlockGetFeesRequest *) blockGetFeesRequest;


/**
 Get the latest fees

 @return BlockGetLatestFeesResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockGetLatestFeesResult *)
                fees(Fees *): The fees
                    baseReserve(int64_t): The base reserve
                    gasPrice(int64_t): The gas price
 */
- (BlockGetLatestFeesResponse *) getLatestFees;
@end
