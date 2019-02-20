//
//  BlockServiceImpl.m
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockServiceImpl.h"
#import "BlockCheckStatusLedgerSeqResponse.h"
#import "BlockRewardJsonResponse.h"
#import "Tools.h"
#import "General.h"
#import "Constant.h"
#import "http/Http.h"
#import "SDKError.h"
#import "SDKException.h"
#import "YYModelClass.h"

@implementation BlockServiceImpl
/**
 Get the block number
 
 @return BlockGetNumberResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockGetNumberResult)
                header(BlockNumber *): The block header
                    blockNumber(int64_t): The block number
 */
- (BlockGetNumberResponse *) getNumber {
    BlockGetNumberResponse *blockGetNumberResponse = [BlockGetNumberResponse new];
    BlockGetNumberResult *blockGetNumberResult = [BlockGetNumberResult new];
    @try {
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *getNumberUrl = [[General sharedInstance] blockGetNumber];
        NSData *result = [Http get: getNumberUrl];
        blockGetNumberResponse = [BlockGetNumberResponse yy_modelWithJSON: result];
    }
    @catch(SDKException *sdkException) {
        [blockGetNumberResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : blockGetNumberResult];
    }
    @catch(NSException *exception) {
        [blockGetNumberResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(blockGetNumberResult)];
    }
    return blockGetNumberResponse;
}


/**
 Check the status of bu chain consensus
 
 @return BlockCheckStatusResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(BlockCheckStatusResult *)
                isSynchronous(BOOL): The consensus is or not synchronous
 */
- (BlockCheckStatusResponse *) checkStatus {
    BlockCheckStatusResponse *blockCheckStatusResponse = [BlockCheckStatusResponse new];
    BlockCheckStatusResult *blockCheckStatusResult = [BlockCheckStatusResult new];
    @try {
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *checkStatusUrl = [[General sharedInstance] blockCheckStatusUrl];
        NSData *result = [Http get: checkStatusUrl];
        BlockCheckStatusLedgerSeqResponse *blockCheckStatusLedgerSeqResponse = [BlockCheckStatusLedgerSeqResponse yy_modelWithJSON: result];
        if ([Tools isEmpty: blockCheckStatusLedgerSeqResponse]) {
            @throw [[SDKException alloc] initWithCode : CONNECTNETWORK_ERROR];
        }
        BlockCheckStatusLedgerSeqResult *blockCheckStatusLedgerResult = blockCheckStatusLedgerSeqResponse.result;
        if (blockCheckStatusLedgerResult.ledgerSequence < blockCheckStatusLedgerResult.chainMaxLedgerSeq) {
            blockCheckStatusResult.isSynchronous = false;
        } else {
            blockCheckStatusResult.isSynchronous = true;
        }
        [blockCheckStatusResponse buildResponse: (SUCCESS) :(blockCheckStatusResult)];
    }
    @catch(SDKException *sdkException) {
        [blockCheckStatusResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : blockCheckStatusResult];
    }
    @catch(NSException *exception) {
        [blockCheckStatusResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(blockCheckStatusResult)];
    }
    return blockCheckStatusResponse;
}


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
- (BlockGetTransactionsResponse *) getTransactions : (BlockGetTransactionsRequest *) blockGetTransactionsRequest {
    BlockGetTransactionsResponse *blockGetTransactionsResponse = [BlockGetTransactionsResponse new];
    BlockGetTransactionsResult *blockGetTransactionsResult = [BlockGetTransactionsResult new];
    @try {
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        if ([Tools isEmpty : blockGetTransactionsRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        int64_t blockNumber = [blockGetTransactionsRequest getBlockNumber];
        if (blockNumber < 1) {
            @throw [[SDKException alloc] initWithCode : INVALID_BLOCKNUMBER_ERROR];
        }
        NSString *getTransactionsUrl = [[General sharedInstance] blockGetTransactionsUrl : blockNumber];
        NSData *result = [Http get: getTransactionsUrl];
        blockGetTransactionsResponse = [BlockGetTransactionsResponse yy_modelWithJSON: result];
        int32_t errorCode = blockGetTransactionsResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"There are no transactions in %lld block", blockNumber]];
        }
    }
    @catch(SDKException *sdkException) {
        [blockGetTransactionsResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : blockGetTransactionsResult];
    }
    @catch(NSException *exception) {
        [blockGetTransactionsResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(blockGetTransactionsResult)];
    }
    return blockGetTransactionsResponse;
}


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
- (BlockGetInfoResponse *) getInfo : (BlockGetInfoRequest *) blockGetInfoRequest {
    BlockGetInfoResponse *blockGetInfoResponse = [BlockGetInfoResponse new];
    BlockGetInfoResult *blockGetInfoResult = [BlockGetInfoResult new];
    @try {
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        if ([Tools isEmpty : blockGetInfoRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        int64_t blockNumber = [blockGetInfoRequest getBlockNumber];
        if (blockNumber < 1) {
            @throw [[SDKException alloc] initWithCode : INVALID_BLOCKNUMBER_ERROR];
        }
        NSString *getInfoUrl = [[General sharedInstance] blockGetInfoUrl : blockNumber];
        NSData *result = [Http get: getInfoUrl];
        blockGetInfoResponse = [BlockGetInfoResponse yy_modelWithJSON: result];
        int32_t errorCode = blockGetInfoResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Block (%lld) doest not exist", blockNumber]];
        }
    }
    @catch(SDKException *sdkException) {
        [blockGetInfoResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : blockGetInfoResult];
    }
    @catch(NSException *exception) {
        [blockGetInfoResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(blockGetInfoResult)];
    }
    return blockGetInfoResponse;
}


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
- (BlockGetLatestInfoResponse *) getLatestInfo {
    BlockGetLatestInfoResponse *blockGetLatestInfoResponse = [BlockGetLatestInfoResponse new];
    BlockGetLatestInfoResult *blockGetLatestInfoResult = [BlockGetLatestInfoResult new];
    @try {
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *getInfoUrl = [[General sharedInstance] blockGetLatestInfoUrl];
        NSData *result = [Http get: getInfoUrl];
        blockGetLatestInfoResponse = [BlockGetLatestInfoResponse yy_modelWithJSON: result];
    }
    @catch(SDKException *sdkException) {
        [blockGetLatestInfoResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : blockGetLatestInfoResult];
    }
    @catch(NSException *exception) {
        [blockGetLatestInfoResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(blockGetLatestInfoResult)];
    }
    return blockGetLatestInfoResponse;
}


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
- (BlockGetValidatorsResponse *) getValidators : (BlockGetValidatorsRequest *) blockGetValidatorsRequest {
    BlockGetValidatorsResponse *blockGetValidatorsResponse = [BlockGetValidatorsResponse new];
    BlockGetValidatorsResult *blockGetValidatorsResult = [BlockGetValidatorsResult new];
    @try {
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        if ([Tools isEmpty : blockGetValidatorsRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        int64_t blockNumber = [blockGetValidatorsRequest getBlockNumber];
        if (blockNumber < 1) {
            @throw [[SDKException alloc] initWithCode : INVALID_BLOCKNUMBER_ERROR];
        }
        NSString *getInfoUrl = [[General sharedInstance] blockGetValidatorsUrl : blockNumber];
        NSData *result = [Http get: getInfoUrl];
        blockGetValidatorsResponse = [BlockGetValidatorsResponse yy_modelWithJSON: result];
        int32_t errorCode = blockGetValidatorsResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Block (%lld) doest not exist", blockNumber]];
        }
    }
    @catch(SDKException *sdkException) {
        [blockGetValidatorsResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : blockGetValidatorsResult];
    }
    @catch(NSException *exception) {
        [blockGetValidatorsResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(blockGetValidatorsResult)];
    }
    return blockGetValidatorsResponse;
}


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
- (BlockGetLatestValidatorsResponse *) getLatestValidators {
    BlockGetLatestValidatorsResponse *blockGetLatestValidatorsResponse = [BlockGetLatestValidatorsResponse new];
    BlockGetLatestValidatorsResult *blockGetLatestValidatorsResult = [BlockGetLatestValidatorsResult new];
    @try {
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *getInfoUrl = [[General sharedInstance] blockGetLatestValidatorsUrl];
        NSData *result = [Http get: getInfoUrl];
        blockGetLatestValidatorsResponse = [BlockGetLatestValidatorsResponse yy_modelWithJSON: result];
    }
    @catch(SDKException *sdkException) {
        [blockGetLatestValidatorsResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : blockGetLatestValidatorsResult];
    }
    @catch(NSException *exception) {
        [blockGetLatestValidatorsResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(blockGetLatestValidatorsResult)];
    }
    return blockGetLatestValidatorsResponse;
}


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
- (BlockGetRewardResponse *) getReward : (BlockGetRewardRequest *) blockGetRewardRequest {
    BlockGetRewardResponse *blockGetRewardResponse = [BlockGetRewardResponse new];
    BlockGetRewardResult *blockGetRewardResult = [BlockGetRewardResult new];
    @try {
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        if ([Tools isEmpty : blockGetRewardRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        int64_t blockNumber = [blockGetRewardRequest getBlockNumber];
        if (blockNumber < 1) {
            @throw [[SDKException alloc] initWithCode : INVALID_BLOCKNUMBER_ERROR];
        }
        NSString *getInfoUrl = [[General sharedInstance] blockGetRewardUrl : blockNumber];
        NSData *result = [Http get: getInfoUrl];
        BlockRewardJsonResponse *blockRewardJsonResponse = [BlockRewardJsonResponse yy_modelWithJSON: result];
        int32_t errorCode = blockRewardJsonResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Block (%lld) doest not exist", blockNumber]];
        }
        if (errorCode != 0) {
            NSString *errorDesc = blockRewardJsonResponse.errorDesc;
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
        }
        NSDictionary *validatorsReward = blockRewardJsonResponse.result.validatorsReward;
        NSMutableArray<ValidatorRewardInfo *> *rewardResults = [[NSMutableArray alloc] init];
        for (NSString *validator in validatorsReward) {
            ValidatorRewardInfo *validatorRewardInfo = [ValidatorRewardInfo new];
            validatorRewardInfo.validator = validator;
            validatorRewardInfo.reward = [[validatorsReward objectForKey: validator] longLongValue];
            [rewardResults addObject: validatorRewardInfo];
        }
        blockGetRewardResult.rewardResults = [rewardResults copy];
        blockGetRewardResult.blockReward = blockRewardJsonResponse.result.blockReward;
        [blockGetRewardResponse buildResponse: (SUCCESS) :(blockGetRewardResult)];
    }
    @catch(SDKException *sdkException) {
        [blockGetRewardResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : blockGetRewardResult];
    }
    @catch(NSException *exception) {
        [blockGetRewardResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(blockGetRewardResult)];
    }
    return blockGetRewardResponse;
}


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
- (BlockGetLatestRewardResponse *) getLatestReward {
    BlockGetLatestRewardResponse *blockGetLatestRewardResponse = [BlockGetLatestRewardResponse new];
    BlockGetLatestRewardResult *blockGetLatestRewardResult = [BlockGetLatestRewardResult new];
    @try {
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *getInfoUrl = [[General sharedInstance] blockGetLatestRewardUrl];
        NSData *result = [Http get: getInfoUrl];
        BlockRewardJsonResponse *blockRewardJsonResponse = [BlockRewardJsonResponse yy_modelWithJSON: result];
        int32_t errorCode = blockRewardJsonResponse.errorCode;
        if (errorCode != 0) {
            NSString *errorDesc = blockRewardJsonResponse.errorDesc;
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
        }
        NSDictionary *validatorsReward = blockRewardJsonResponse.result.validatorsReward;
        NSMutableArray<ValidatorRewardInfo *> *rewardResults = [[NSMutableArray alloc] init];
        for (NSString *validator in validatorsReward) {
            ValidatorRewardInfo *validatorRewardInfo = [ValidatorRewardInfo new];
            validatorRewardInfo.validator = validator;
            validatorRewardInfo.reward = [[validatorsReward objectForKey: validator] longLongValue];
            [rewardResults addObject: validatorRewardInfo];
        }
        blockGetLatestRewardResult.rewardResults = [rewardResults copy];
        blockGetLatestRewardResult.blockReward = blockRewardJsonResponse.result.blockReward;
        [blockGetLatestRewardResponse buildResponse: (SUCCESS) :(blockGetLatestRewardResult)];
    }
    @catch(SDKException *sdkException) {
        [blockGetLatestRewardResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : blockGetLatestRewardResult];
    }
    @catch(NSException *exception) {
        [blockGetLatestRewardResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(blockGetLatestRewardResult)];
    }
    return blockGetLatestRewardResponse;
}


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
- (BlockGetFeesResponse *) getFees : (BlockGetFeesRequest *) blockGetFeesRequest {
    BlockGetFeesResponse *blockGetFeesResponse = [BlockGetFeesResponse new];
    BlockGetFeesResult *blockGetFeesResult = [BlockGetFeesResult new];
    @try {
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        if ([Tools isEmpty : blockGetFeesRequest]) {
            @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
        }
        int64_t blockNumber = [blockGetFeesRequest getBlockNumber];
        if (blockNumber < 1) {
            @throw [[SDKException alloc] initWithCode : INVALID_BLOCKNUMBER_ERROR];
        }
        NSString *getInfoUrl = [[General sharedInstance] blockGetFeesUrl : blockNumber];
        NSData *result = [Http get: getInfoUrl];
        blockGetFeesResponse = [BlockGetFeesResponse yy_modelWithJSON: result];
        int32_t errorCode = blockGetFeesResponse.errorCode;
        if (errorCode == 4) {
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : [NSString stringWithFormat : @"Block (%lld) doest not exist", blockNumber]];
        }
        if (errorCode != 0) {
            NSString *errorDesc = blockGetFeesResponse.errorDesc;
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
        }
    }
    @catch(SDKException *sdkException) {
        [blockGetFeesResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : blockGetFeesResult];
    }
    @catch(NSException *exception) {
        [blockGetFeesResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(blockGetFeesResult)];
    }
    return blockGetFeesResponse;
}


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
- (BlockGetLatestFeesResponse *) getLatestFees {
    BlockGetLatestFeesResponse *blockGetLatestFeesResponse = [BlockGetLatestFeesResponse new];
    BlockGetLatestFeesResult *blockGetLatestFeesResult = [BlockGetLatestFeesResult new];
    @try {
        if ([Tools isEmpty : [[General sharedInstance] getUrl]]) {
            @throw [[SDKException alloc] initWithCode : URL_EMPTY_ERROR];
        }
        NSString *getInfoUrl = [[General sharedInstance] blockGetLatestFeesUrl];
        NSData *result = [Http get: getInfoUrl];
        blockGetLatestFeesResponse = [BlockGetLatestFeesResponse yy_modelWithJSON: result];
        int32_t errorCode = blockGetLatestFeesResponse.errorCode;
        if (errorCode != 0) {
            NSString *errorDesc = blockGetLatestFeesResponse.errorDesc;
            @throw [[SDKException alloc] initWithCodeAndDesc : errorCode : ([Tools isEmpty : errorDesc] ? @"error" : errorDesc)];
        }
    }
    @catch(SDKException *sdkException) {
        [blockGetLatestFeesResponse buildResponse: ([sdkException getErrorCode]) : [sdkException getErrorDesc] : blockGetLatestFeesResult];
    }
    @catch(NSException *exception) {
        [blockGetLatestFeesResponse buildResponse: (SYSTEM_ERROR) : [exception reason] :(blockGetLatestFeesResult)];
    }
    return blockGetLatestFeesResponse;
}
@end
