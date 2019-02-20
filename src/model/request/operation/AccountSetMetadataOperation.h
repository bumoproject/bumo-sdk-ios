//
//  AccountSetMetadataOperation.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "BaseOperation.h"

@interface AccountSetMetadataOperation : BaseOperation  {
@private
    NSString *_key;
    NSString *_value;
    int64_t _version;
    BOOL _deleteFlag;
}
- (void) setKey : (NSString *) key;
- (NSString *) getKey;

- (void) setValue: (NSString *) value;
- (NSString *) getValue;

- (void) setVersion : (int64_t) version;
- (int64_t) getVersion;

- (void) setDeleteFlag : (BOOL) deleteFlag;
- (BOOL) getDeleteFlag;

@end
