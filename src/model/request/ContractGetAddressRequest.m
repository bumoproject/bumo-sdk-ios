//
//  ContractGetAddressRequest.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractGetAddressRequest.h"

@implementation ContractGetAddressRequest
- (void) setHash : (NSString *)hash {
    _hash = hash;
}
- (NSString *) getHash {
    return _hash;
}
@end
