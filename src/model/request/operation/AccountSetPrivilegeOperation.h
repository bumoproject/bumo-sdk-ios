//
//  AccountSetPrivilegeOperation.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "BaseOperation.h"
#import "SignerInfo.h"
#import "TypeThreshold.h"

@interface AccountSetPrivilegeOperation : BaseOperation {
@private
    NSString *_masterWeight;
    NSMutableArray<SignerInfo *> *_signers;
    NSString *_txThreshold;
    NSMutableArray<TypeThreshold *> *_typeThresholds;
}
- (void) setMasterWeight : (NSString *) masterWeight;
- (NSString *) getMasterWeight;

- (void) setTxThreshold : (NSString *) txThreshold;
- (NSString *) getTxThreshold;

- (void) setSigners : (NSMutableArray<SignerInfo *> *) signers;
- (void) setSigner : (SignerInfo *) signer;
- (void) addSigner : (SignerInfo *) signer;
- (NSMutableArray<SignerInfo *> *) getSigners;

- (void) setTypeThresholds : (NSMutableArray<TypeThreshold *> *) typeThresholds;
- (void) setTypeThreshold : (TypeThreshold *) typeThreshold;
- (void) addTypeThreshold : (TypeThreshold *) typeThreshold;
- (NSMutableArray<TypeThreshold *> *) getTypeThresholds;

@end
