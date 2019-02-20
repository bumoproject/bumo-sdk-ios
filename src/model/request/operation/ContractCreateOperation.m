//
//  ContractCreateOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractCreateOperation.h"

@implementation ContractCreateOperation
- (instancetype)init {
    _operationType = CONTRACT_CREATE;
    return [super init];
}

- (void) setInitBalance : (int64_t) initBalance {
    _initBalance = initBalance;
}
- (int64_t) getInitBalance {
    return _initBalance;
}

- (void) setType : (int32_t) type {
    _type = type;
}
-(int32_t) getType {
    return _type;
}

- (void) setPayload : (NSString *) payload {
    _payload = payload;
}
- (NSString *) getPayload {
    return _payload;
}

- (void) setInitInput : (NSString *) initInput {
    _initInput = initInput;
}
- (NSString *) getInitInput {
    return _initInput;
}
@end
