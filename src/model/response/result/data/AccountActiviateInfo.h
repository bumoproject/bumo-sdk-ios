//
//  AccountActiviateInfo.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContractInfo.h"
#import "Priv.h"
#import "MetadataInfo.h"

@interface AccountActiviateInfo : NSObject
@property (nonatomic, copy) NSString *destAddress;
@property (nonatomic, strong) ContractInfo *contract;
@property (nonatomic, strong) Priv *priv;
@property (nonatomic, strong) NSArray *MetadataInfo;
@property (nonatomic, assign) int64_t initBalance;
@property (nonatomic, copy) NSString *input;
@end
