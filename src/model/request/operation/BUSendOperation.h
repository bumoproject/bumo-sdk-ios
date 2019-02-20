//
//  BUSendOperation.h
//  sdk-ios
//
//  Created by dxl on 2018/8/12.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@interface BUSendOperation : BaseOperation {
@private
    NSString *_destAddress;
    int64_t _amount;
}

- (void) setDestAddress : (NSString *) destAddress;
- (NSString *) getDestAddress;

- (void) setAmount : (int64_t) amount;
- (int64_t) getAmount;

@end
