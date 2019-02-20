//
//  AccountSetPrivilegeOperation.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "AccountSetPrivilegeOperation.h"

@implementation AccountSetPrivilegeOperation

- (instancetype)init {
    _operationType = ACCOUNT_SET_PRIVILEGE;
    return [super init];
}

- (void) setMasterWeight : (NSString *) masterWeight {
    _masterWeight = masterWeight;
}
- (NSString *) getMasterWeight {
    return _masterWeight;
}

- (void) setTxThreshold : (NSString *) txThreshold {
    _txThreshold = txThreshold;
}
- (NSString *) getTxThreshold {
    return _txThreshold;
}

- (void) setSigners : (NSMutableArray<SignerInfo *> *) signers {
    _signers = signers;
}
- (void) setSigner : (SignerInfo *) signer {
    if (nil == _signers) {
        _signers = [[NSMutableArray alloc] init];
    }
    [_signers removeAllObjects];
    [_signers addObject : signer];
}
- (void) addSigner : (SignerInfo *) signer {
    if (nil == _signers) {
        _signers = [[NSMutableArray alloc] init];
    }
    [_signers addObject : signer];
}
- (NSMutableArray<SignerInfo *> *) getSigners {
    return _signers;
}

- (void) setTypeThresholds : (NSMutableArray<TypeThreshold *> *) typeThresholds {
    _typeThresholds = typeThresholds;
}
- (void) setTypeThreshold : (TypeThreshold *) typeThreshold {
    if (nil == _typeThresholds) {
        _typeThresholds = [[NSMutableArray alloc] init];
    }
    [_typeThresholds removeAllObjects];
    [_typeThresholds addObject : typeThreshold];
}
- (void) addTypeThreshold : (TypeThreshold *) typeThreshold {
    if (nil == _typeThresholds) {
        _typeThresholds = [[NSMutableArray alloc] init];
    }
    [_typeThresholds addObject : typeThreshold];
}
- (NSMutableArray<TypeThreshold *> *) getTypeThresholds {
    return _typeThresholds;
}
@end
