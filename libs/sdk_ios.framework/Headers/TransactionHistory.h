//
//  TransactionHistory.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignatureInfo.h"
#import "TransactionInfo.h"

@interface TransactionHistory : NSObject
@property (nonatomic, copy) NSString *actualFee;
@property (nonatomic, assign) int64_t closeTime;
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, copy) NSString *transactionHash;
@property (nonatomic, assign) int64_t ledgerSeq;
@property (nonatomic, strong) NSArray *signatures;
@property (nonatomic, strong) TransactionInfo *transaction;
@property (nonatomic, assign) int64_t txSize;
@end
