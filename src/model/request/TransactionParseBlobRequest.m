//
//  TransactionParseBlobRequest.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionParseBlobRequest.h"

@implementation TransactionParseBlobRequest
- (void) setBlob : (NSString *)blob {
    _blob = blob;
}
- (NSString *) getBlob {
    return _blob;
}
@end
