//
//  Ctp10TokenTransferOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenTransferOperation.h"

@implementation Ctp10TokenTransferOperation
- (instancetype)init {
    _operationType = TOKEN_TRANSFER;
    return [super init];
}
- (void) setContractAddress : (NSString *) contractAddress {
    _contractAddress = contractAddress;
}
- (NSString *) getContractAddress {
    return _contractAddress;
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
