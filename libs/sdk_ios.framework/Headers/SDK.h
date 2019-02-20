//
//  SDK.h
//  sdk-ios
//
//  Created by dxl on 2018/8/8.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountService.h"
#import "AssetService.h"
#import "TransactionService.h"
#import "BlockService.h"
#import "ContractService.h"
#import "Ctp10TokenService.h"
#import "BaseOperation.h"
#import "AccountSetPrivilegeOperation.h"
#import "AccountSetMetadataOperation.h"
#import "AccountActivateOperation.h"
#import "AssetIssueOperation.h"
#import "AssetSendOperation.h"
#import "BUSendOperation.h"
#import "Ctp10TokenIssueOperation.h"
#import "Ctp10TokenTransferOperation.h"
#import "Ctp10TokenTransferFromOperation.h"
#import "Ctp10TokenApproveOperation.h"
#import "Ctp10TokenAssignOperation.h"
#import "Ctp10TokenChangeOwnerOperation.h"
#import "ContractCreateOperation.h"
#import "ContractInvokeByAssetOperation.h"
#import "ContractInvokeByBUOperation.h"
#import "LogCreateOperation.h"
#import "SDKConfigure.h"
#import "Tools.h"
#import "YYModelClass.h"
#import "Mnemonic.h"
#import "KeyStore.h"
#import "KeyStoreEty.h"
#import "ScryptParamsEty.h"
#import "Keypair.h"

@interface SDK : NSObject
+ (instancetype) sharedInstance;
+ (id) allocWithZone : (struct _NSZone *)zone;
- (id) copyWithZone : (struct _NSZone *)zone;
- (instancetype) setUrl : (NSString *) url;
+ (NSString *) getUrl;
- (instancetype) setConfigure : (SDKConfigure *) sdkConfigure;
+ (SDKConfigure *) getConfigure;

- (AccountService *) getAccountService;
- (AssetService *) getAssetService;
- (TransactionService *) getTransactionService;
- (BlockService *) getBlockService;
- (ContractService *) getContractService;
- (Ctp10TokenService *) getCtp10TokenService;
@end
