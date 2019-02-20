//
//  AssetIssueOperation.h
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@interface AssetIssueOperation  : BaseOperation {
@private
    NSString *_code;
    int64_t _amount;
}

- (void) setCode : (NSString *) code;
- (NSString *) getCode;

- (void) setAmount : (int64_t) amount;
- (int64_t) getAmount;

@end
