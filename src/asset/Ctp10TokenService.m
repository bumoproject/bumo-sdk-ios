//
//  Ctp10TokenService.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenService.h"

#define AbstractMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@implementation Ctp10TokenService
- (instancetype)init {
    NSAssert(![self isMemberOfClass:[Ctp10TokenService class]], @"Ctp10TokenService is an abstract class, you should not instantiate it directly.");
    return [super init];
}

- (Ctp10TokenCheckValidResponse *) checkValid : (Ctp10TokenCheckValidRequest *) ctp10TokenCheckValidRequest {
    AbstractMethodNotImplemented();
}

- (Ctp10TokenAllowanceResponse *) allowance : (Ctp10TokenAllowanceRequest *) ctp10TokenAllowanceRequest {
    AbstractMethodNotImplemented();
}

- (Ctp10TokenGetInfoResponse *) getInfo : (Ctp10TokenGetInfoRequest *) ctp10TokenGetInfoRequest {
    AbstractMethodNotImplemented();
}

- (Ctp10TokenGetNameResponse *) getName : (Ctp10TokenGetNameRequest *) ctp10TokenGetNameRequest {
    AbstractMethodNotImplemented();
}

- (Ctp10TokenGetSymbolResponse *) getSymbol : (Ctp10TokenGetSymbolRequest *) ctp10TokenGetSymbolRequest {
    AbstractMethodNotImplemented();
}

- (Ctp10TokenGetDecimalsResponse *) getDecimals : (Ctp10TokenGetDecimalsRequest *) ctp10TokenGetDecimalsRequest {
    AbstractMethodNotImplemented();
}

- (Ctp10TokenGetTotalSupplyResponse *) getTotalSupply : (Ctp10TokenGetTotalSupplyRequest *) ctp10TokenGetTotalSupplyRequest {
    AbstractMethodNotImplemented();
}

- (Ctp10TokenGetBalanceResponse *) getBalance : (Ctp10TokenGetBalanceRequest *) ctp10TokenGetBalanceRequest {
    AbstractMethodNotImplemented();
}
@end
