//
//  Ctp10TokenIssueOperation.h
//  sdk-ios
//
//  Created by dxl on 2018/8/12.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@interface Ctp10TokenIssueOperation : BaseOperation {
@private
    int64_t _initBalance;
    NSString *_name;
    NSString *_symbol;
    int32_t _decimals;
    NSString *_supply;
}
- (void) setInitBalance : (int64_t) initBalance;
- (int64_t) getInitBalance;

- (void) setName : (NSString *) name;
- (NSString *) getName;

- (void) setSymbol : (NSString *) symbol;
- (NSString *) getSymbol;

- (void) setDecimals : (int32_t) decimals;
- (int32_t) getDecimals;

- (void) setSupply : (NSString *) supply;
- (NSString *) getSupply;
@end
