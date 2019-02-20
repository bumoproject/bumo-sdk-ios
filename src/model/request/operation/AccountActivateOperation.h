//
//  AccountActivateOperation.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@interface AccountActivateOperation : BaseOperation {
@private
    NSString *_destAddress;
    int64_t _initBalance;
}
- (void) setDestAddress : (NSString *) destAddress;
- (NSString *) getDestAddress;

- (void) setInitBalance : (int64_t) initBalance;
- (int64_t) getInitBalance;
@end
