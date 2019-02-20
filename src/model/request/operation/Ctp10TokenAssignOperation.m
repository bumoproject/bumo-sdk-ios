//
//  Ctp10TokenAssignOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenAssignOperation.h"

@implementation Ctp10TokenAssignOperation
- (instancetype)init {
    _operationType = TOKEN_ASSIGN;
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
