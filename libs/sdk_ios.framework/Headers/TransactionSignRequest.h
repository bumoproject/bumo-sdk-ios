//
//  TransactionSignRequest.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionSignRequest : NSObject {
@private
    NSString *_blob;
    NSMutableArray<NSString *> *_privateKeys;
}
- (void) setBlob : (NSString *)blob;
- (NSString *) getBlob;

- (void) setPrivateKeys : (NSMutableArray<NSString *> *) privateKeys;
- (void) setPrivateKey : (NSString *) privateKey;
- (void) addPrivateKey : (NSString *) privateKey;
- (NSMutableArray<NSString *> *) getPrivateKeys;
@end
