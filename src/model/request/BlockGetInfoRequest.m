//
//  BlockGetInfoRequest.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BlockGetInfoRequest.h"

@implementation BlockGetInfoRequest
- (void) setBlockNumber : (int64_t) blockNumber {
    _blockNumber = blockNumber;
}
- (int64_t) getBlockNumber {
    return _blockNumber;
}
@end
