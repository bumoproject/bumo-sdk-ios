//
//  OperationFormat.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountActiviateInfo.h"
#import "AssetIssueInfo.h"
#import "AssetSendInfo.h"
#import "BUSendInfo.h"
#import "AccountSetMetadataInfo.h"
#import "AccountSetPrivilegeInfo.h"
#import "LogInfo.h"

@interface OperationFormat : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *sourceAddress;
@property (nonatomic, copy) NSString *metadata;
@property (nonatomic, strong) AccountActiviateInfo *createAccount;
@property (nonatomic, strong) AssetIssueInfo *issueAsset;
@property (nonatomic, strong) AssetSendInfo *sendAsset;
@property (nonatomic, strong) BUSendInfo *sendBU;
@property (nonatomic, strong) AccountSetMetadataInfo *setMetadata;
@property (nonatomic, strong) AccountSetPrivilegeInfo *setPrivilege;
@property (nonatomic, strong) LogInfo *log;
@end
