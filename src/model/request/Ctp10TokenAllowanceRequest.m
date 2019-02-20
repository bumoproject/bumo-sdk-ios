//
//  Ctp10TokenAllowanceRequest.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenAllowanceRequest.h"

@implementation Ctp10TokenAllowanceRequest
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

- (void) setTokenOwner : (NSString *) tokenOwner {
    _tokenOwner = tokenOwner;
}
- (NSString *) getTokenOwner {
    return _tokenOwner;
}
@end
