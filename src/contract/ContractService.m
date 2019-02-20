//
//  ContractService.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractService.h"

#define AbstractMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@implementation ContractService
- (instancetype)init {
    NSAssert(![self isMemberOfClass:[ContractService class]], @"ContractService is an abstract class, you should not instantiate it directly.");
    return [super init];
}

- (ContractGetInfoResponse *) getInfo : (ContractGetInfoRequest *) contractGetInfoRequest {
    AbstractMethodNotImplemented();
}

- (ContractCheckValidResponse *) checkValid : (ContractCheckValidRequest *) contractCheckValidRequest {
    AbstractMethodNotImplemented();
}

- (ContractCallResponse *) call : (ContractCallRequest *) contractCallRequest {
    AbstractMethodNotImplemented();
}

- (ContractGetAddressResponse *) getAddress : (ContractGetAddressRequest *) contractGetAddressRequest {
    AbstractMethodNotImplemented();
}

@end
