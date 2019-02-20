//
//  TransactionSubmitRequest.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignatureInfo.h"

@interface TransactionSubmitRequest : NSObject {
@private
    NSString *_transactionBlob;
    NSMutableArray<SignatureInfo *> *_signatures;
}

- (void) setTransactionBlob : (NSString *)transactionBlob;
- (NSString *) getTransactionBlob;

- (void) setSignatures : (NSMutableArray<SignatureInfo *> *) signatures;
- (void) setSignature : (SignatureInfo *) signature;
- (void) addSignature : (SignatureInfo *) signature;
- (NSMutableArray<SignatureInfo *> *) getSignatures;

@end
