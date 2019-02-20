//
//  AccountActivateOperation.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountActivateOperation.h"

@implementation AccountActivateOperation

- (instancetype)init {
    _operationType = ACCOUNT_ACTIVATE;
    return [super init];
}

- (void) setDestAddress : (NSString *) destAddress {
    _destAddress = destAddress;
}
- (NSString *) getDestAddress {
    return _destAddress;
}
- (void) setInitBalance : (int64_t) initBalance {
    _initBalance = initBalance;
}
- (int64_t) getInitBalance {
    return _initBalance;
}
@end
