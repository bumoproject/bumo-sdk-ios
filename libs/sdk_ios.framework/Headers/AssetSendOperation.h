//
//  AssetSendOperation.h
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@interface AssetSendOperation : BaseOperation {
@private
    NSString *_destAddress;
    NSString *_code;
    NSString *_issuer;
    int64_t _amount;
}

- (void) setDestAddress : (NSString *) destAddress;
- (NSString *) getDestAddress;

- (void) setCode : (NSString *) code;
- (NSString *) getCode;

- (void) setIssuer : (NSString *) issuer;
- (NSString *) getIssuer;

- (void) setAmount : (int64_t) amount;
- (int64_t) getAmount;

@end
