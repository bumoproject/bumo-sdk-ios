//
//  TransactionGetInfoRequest.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionGetInfoRequest.h"

@implementation TransactionGetInfoRequest
- (void) setHash : (NSString *)hash {
    _hash = hash;
}
- (NSString *) getHash {
    return _hash;
}
@end
