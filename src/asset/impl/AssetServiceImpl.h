//
//  AssetServiceImpl.h
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AssetService.h"
#import "AssetIssueOperation.h"
#import "AssetSendOperation.h"
#import "Chain.pbobjc.h"

@interface AssetServiceImpl : AssetService
/**
 Issue asset
 
 @param assetIssueOperation
            sourceAddress(NSString *) : The account who will make this issurance operation
            code(NSString *) : The asset code
            amount(int64_t) : The asset amount
            metadata(NSString *) : Notes
 
 @return Operation *
 */
+ (Operation *) issue : (AssetIssueOperation *) assetIssueOperation;

/**
 Send asset to other account that is in bu chain
 
 @param assetSendOperation
            sourceAddress(NSString *) : The account who will make this sending asset operation
            destAddress(NSString *) : The account who will receive the asset
            code(NSString *) : The asset code
            issuer(NSString *) : The asset issuer
            amount(int64_t) : The asset amount
            metadata(NSString *) : Notes
 
 @param transSourceAddress : The source account who will start the transaction
 @return Operation *
 */
+ (Operation *) send : (AssetSendOperation *) assetSendOperation : (NSString *) transSourceAddress;
@end
