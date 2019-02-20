//
//  BlockGetValidatorsRequest.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockGetValidatorsRequest : NSObject {
@private
    int64_t _blockNumber;
}

- (void) setBlockNumber : (int64_t) blockNumber;
- (int64_t) getBlockNumber;

@end
