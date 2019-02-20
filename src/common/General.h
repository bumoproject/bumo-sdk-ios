//
//  General.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface General : NSObject
+ (instancetype) sharedInstance;
+ (id) allocWithZone : (struct _NSZone *)zone;
- (id) copyWithZone : (struct _NSZone *)zone;
- (NSString *) getUrl;
- (NSString *) accountGetInfoUrl : (NSString *) address;
- (NSString *) accountGetAssetsUrl : (NSString *) address;
- (NSString *) accountGetMetadataUrl : (NSString *) address : (NSString *) key;
- (NSString *) assetGetUrl : (NSString *) address : (NSString *)code : (NSString *) issuer;
- (NSString *) contractCallUrl;
- (NSString *) transactionEvaluationFeeUrl;
- (NSString *) transactionSubmitUrl;
- (NSString *) transactionGetInfoUrl : (NSString *) hash;
- (NSString *) blockGetNumber;
- (NSString *) blockCheckStatusUrl;
- (NSString *) blockGetTransactionsUrl : (int64_t) blockNumber;
- (NSString *) blockGetInfoUrl : (int64_t) blockNumber;
- (NSString *) blockGetLatestInfoUrl;
- (NSString *) blockGetValidatorsUrl : (int64_t) blockNumber;
- (NSString *) blockGetLatestValidatorsUrl;
- (NSString *) blockGetRewardUrl : (int64_t) blockNumber;
- (NSString *) blockGetLatestRewardUrl;
- (NSString *) blockGetFeesUrl : (int64_t) blockNumber;
- (NSString *) blockGetLatestFeesUrl;
@end
