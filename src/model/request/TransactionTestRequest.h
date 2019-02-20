//
//  TransactionTestRequest.h
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/30.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionItem.h"

@interface TransactionTestRequest : NSObject
@property (nonatomic, strong) NSMutableArray *items;

- (void) setTransactionItems : (NSMutableArray *) items;
- (void) setTransactionItem : (TransactionItem *) item;
- (void) addTransactionItem : (TransactionItem *) item;
- (NSMutableArray *) getOperations;
@end
