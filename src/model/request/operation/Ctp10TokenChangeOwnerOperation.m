//
//  Ctp10TokenChangeOwnerOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenChangeOwnerOperation.h"

@implementation Ctp10TokenChangeOwnerOperation
- (instancetype)init {
    _operationType = TOKEN_CHANGE_OWNER;
    return [super init];
}
- (void) setContractAddress : (NSString *) contractAddress {
    _contractAddress = contractAddress;
}
- (NSString *) getContractAddress {
    return _contractAddress;
}

- (void) setTokenOwner : (NSString *) tokenOwner {
    _tokenOwner = tokenOwner;
}
- (NSString *) getTokenOwner {
    return _tokenOwner;
}
@end
