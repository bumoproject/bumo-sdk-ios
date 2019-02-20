//
//  Ctp10TokenTransferFromOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenTransferFromOperation.h"

@implementation Ctp10TokenTransferFromOperation
- (instancetype)init {
    _operationType = TOKEN_TRANSFER_FROM;
    return [super init];
}
- (void) setContractAddress : (NSString *) contractAddress {
    _contractAddress = contractAddress;
}
- (NSString *) getContractAddress {
    return _contractAddress;
}

- (void) setFromAddress : (NSString *) fromAddress {
    _fromAddress = fromAddress;
}
- (NSString *) getFromAddress {
    return _fromAddress;
}

- (void) setDestAddress : (NSString *) destAddress {
    _destAddress = destAddress;
}
- (NSString *) getDestAddress {
    return _destAddress;
}

- (void) setTokenAmount : (NSString *) tokenAmount {
    _tokenAmount = tokenAmount;
}
- (NSString *) getTokenAmount {
    return _tokenAmount;
}
@end
