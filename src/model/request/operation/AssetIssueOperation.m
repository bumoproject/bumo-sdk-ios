//
//  AssetIssueOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AssetIssueOperation.h"

@implementation AssetIssueOperation

- (instancetype)init {
    _operationType = ASSET_ISSUE;
    return [super init];
}

- (void) setCode : (NSString *) code {
    _code = code;
}
- (NSString *) getCode {
    return _code;
}

- (void) setAmount : (int64_t) amount {
    _amount = amount;
}
- (int64_t) getAmount {
    return _amount;
}
@end
