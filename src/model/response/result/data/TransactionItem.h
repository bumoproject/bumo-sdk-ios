//
//  TransactionItem.h
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/30.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionInfo.h"

@interface TransactionItem : NSObject
@property (nonatomic, strong) TransactionInfo *transactionJson;
@end
