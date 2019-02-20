//
//  Ctp10TokenApproveOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenApproveOperation.h"

@implementation Ctp10TokenApproveOperation
- (instancetype)init {
    _operationType = TOKEN_APPROVE;
    return [super init];
}
- (void) setContractAddress : (NSString *) contractAddress {
    _contractAddress = contractAddress;
}
- (NSString *) getContractAddress {
    return _contractAddress;
}

- (void) setSpender : (NSString *) spender {
    _spender = spender;
}
- (NSString *) getSpender {
    return _spender;
}

- (void) setTokenAmount : (NSString *) tokenAmount {
    _tokenAmount = tokenAmount;
}
- (NSString *) getTokenAmount {
    return _tokenAmount;
}
@end
