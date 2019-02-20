//
//  lockCheckStatusLedgerSeqResult.h
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockCheckStatusLedgerSeqResult : NSObject
@property (nonatomic, assign) int64_t chainMaxLedgerSeq;
@property (nonatomic, assign) int64_t ledgerSequence;
@end
