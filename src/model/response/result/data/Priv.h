//
//  Priv.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignerInfo.h"
#import "Threshold.h"

@interface Priv : NSObject
@property (nonatomic, copy) NSString *masterWeight;
@property (nonatomic, strong) NSArray<SignerInfo *> *signers;
@property (nonatomic, strong) Threshold *thresholds;
@end
