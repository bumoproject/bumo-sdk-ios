//
//  ContractCallResult.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContractStat.h"
#import "TransactionEnvs.h"

@interface ContractCallResult : NSObject
@property (nonatomic, strong) NSDictionary *logs;
@property (nonatomic, strong) NSArray *queryRets;
@property (nonatomic, strong) ContractStat *stat;
@property (nonatomic, strong) NSArray *txs;
@end
