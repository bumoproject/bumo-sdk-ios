//
//  BUSendOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/12.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BUSendOperation.h"

@implementation BUSendOperation
- (instancetype)init {
    _operationType = BU_SEND;
    return [super init];
}

- (void) setDestAddress : (NSString *) destAddress {
    _destAddress = destAddress;
}
- (NSString *) getDestAddress {
    return _destAddress;
}

- (void) setAmount : (int64_t) amount {
    _amount = amount;
}
- (int64_t) getAmount {
    return _amount;
}
@end
