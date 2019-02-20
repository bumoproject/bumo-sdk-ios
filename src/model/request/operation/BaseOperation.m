//
//  BaseOperation.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@implementation BaseOperation

- (OperationType) getOperationType {
    return _operationType;
}
- (void) setSourceAddress : (NSString *) sourceAddress {
    _sourceAddress = sourceAddress;
}
- (NSString *) getSourceAddress {
    return _sourceAddress;
}

- (void) setMetadata : (NSString *) metadata {
    _metadata = metadata;
}
- (NSString *) getMetadata {
    return _metadata;
}

@end
