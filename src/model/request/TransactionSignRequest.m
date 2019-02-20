//
//  TransactionSignRequest.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "TransactionSignRequest.h"

@implementation TransactionSignRequest
- (void) setBlob : (NSString *)blob {
    _blob = blob;
}
- (NSString *) getBlob {
    return _blob;
}

- (void) setPrivateKeys : (NSMutableArray<NSString *> *) privateKeys {
    _privateKeys = privateKeys;
}
- (void) setPrivateKey : (NSString *) privateKey {
    if (nil == _privateKeys) {
        _privateKeys = [[NSMutableArray alloc] init];
    }
    [_privateKeys removeAllObjects];
    [_privateKeys addObject : privateKey];
}
- (void) addPrivateKey : (NSString *) privateKey {
    if (nil == _privateKeys) {
        _privateKeys = [[NSMutableArray alloc] init];
    }
    [_privateKeys addObject : privateKey];
}
- (NSMutableArray<NSString *> *) getPrivateKeys {
    return _privateKeys;
}
@end
