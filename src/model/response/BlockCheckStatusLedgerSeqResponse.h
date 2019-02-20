//
//  BlockCheckStatusLedgerSeqResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockCheckStatusLedgerSeqResult.h"

@interface BlockCheckStatusLedgerSeqResponse : NSObject
@property (nonatomic, strong) BlockCheckStatusLedgerSeqResult *result;
@end
