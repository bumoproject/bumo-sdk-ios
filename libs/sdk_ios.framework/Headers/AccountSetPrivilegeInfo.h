//
//  AccountSetPrivilegeInfo.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignerInfo.h"
#import "TypeThreshold.h"

@interface AccountSetPrivilegeInfo : NSObject
@property (nonatomic, copy) NSString *masterWeight;
@property (nonatomic, strong) NSArray *signers;
@property (nonatomic, copy) NSString *txThreshold;
@property (nonatomic, strong) NSArray *typeThresholds;
@end
