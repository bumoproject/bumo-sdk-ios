//
//  BlockGetTransactionsResult.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionHistory.h"

@interface BlockGetTransactionsResult : NSObject
@property (nonatomic, assign) int64_t totalCount;
@property (nonatomic, strong) NSArray *transactions;
@end
