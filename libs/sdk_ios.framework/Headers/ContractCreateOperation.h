//
//  ContractCreateOperation.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@interface ContractCreateOperation : BaseOperation {
@private
    int64_t _initBalance;
    int32_t _type;
    NSString *_payload;
    NSString *_initInput;
}

- (void) setInitBalance : (int64_t) initBalance;
- (int64_t) getInitBalance;

- (void) setType : (int32_t) type;
-(int32_t) getType;

- (void) setPayload : (NSString *) payload;
- (NSString *) getPayload;

- (void) setInitInput : (NSString *) initInput;
- (NSString *) getInitInput;

@end
