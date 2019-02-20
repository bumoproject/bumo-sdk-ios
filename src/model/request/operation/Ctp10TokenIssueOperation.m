//
//  Ctp10TokenIssueOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/12.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenIssueOperation.h"

@implementation Ctp10TokenIssueOperation
- (instancetype)init {
    _operationType = TOKEN_ISSUE;
    return [super init];
}
- (void) setInitBalance : (int64_t) initBalance {
    _initBalance = initBalance;
}
- (int64_t) getInitBalance {
    return _initBalance;
}

- (void) setName : (NSString *) name {
    _name = name;
}
- (NSString *) getName {
    return _name;
}

- (void) setSymbol : (NSString *) symbol {
    _symbol = symbol;
}
- (NSString *) getSymbol {
    return _symbol;
}

- (void) setDecimals : (int32_t) decimals {
    _decimals = decimals;
}
- (int32_t) getDecimals {
    return _decimals;
}

- (void) setSupply : (NSString *) supply {
    _supply = supply;
}
- (NSString *) getSupply {
    return _supply;
}
@end
