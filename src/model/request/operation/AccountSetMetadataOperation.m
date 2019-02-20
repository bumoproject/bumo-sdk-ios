//
//  AccountSetMetadataOperation.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "AccountSetMetadataOperation.h"

@implementation AccountSetMetadataOperation

- (instancetype)init {
    _operationType = ACCOUNT_SET_METADATA;
    return [super init];
}

- (void) setKey : (NSString *) key {
    _key = key;
}
- (NSString *) getKey {
    return _key;
}

- (void) setValue: (NSString *) value {
    _value = value;
}
- (NSString *) getValue {
    return _value;
}

- (void) setVersion : (int64_t) version {
    _version = version;
}
- (int64_t) getVersion {
    return _version;
}

- (void) setDeleteFlag : (BOOL) deleteFlag {
    _deleteFlag = deleteFlag;
}
- (BOOL) getDeleteFlag {
    return _deleteFlag;
}
@end
