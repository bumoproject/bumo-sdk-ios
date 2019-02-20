//
//  BaseOperation.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OperationType) {
    // Unknown operation
    UNKNOWN = 0,

    // Activate an account
    ACCOUNT_ACTIVATE,
    
    // Set metadata
    ACCOUNT_SET_METADATA,
    
    // Set privilege
    ACCOUNT_SET_PRIVILEGE,
    
    // Issue token
    ASSET_ISSUE,
    
    // Send token
    ASSET_SEND,
    
    // Send bu
    BU_SEND,
    
    // Issue token
    TOKEN_ISSUE,
    
    // Transfer token
    TOKEN_TRANSFER,
    
    // Transfer token from an account
    TOKEN_TRANSFER_FROM,
    
    // Approve token
    TOKEN_APPROVE,
    
    // Assign token
    TOKEN_ASSIGN,
    
    // Change owner of token
    TOKEN_CHANGE_OWNER,
    
    // Create contract
    CONTRACT_CREATE,
    
    // Invoke contract by sending token
    CONTRACT_INVOKE_BY_ASSET,
    
    // Invoke contract by sending bu
    CONTRACT_INVOKE_BY_BU,
    
    // Create log
    LOG_CREATE
};

@interface BaseOperation : NSObject {
@protected
    OperationType _operationType;
@private
    NSString *_sourceAddress;
    NSString *_metadata;
}
- (OperationType) getOperationType;
- (void) setSourceAddress : (NSString *) sourceAddress;
- (NSString *) getSourceAddress;

- (void) setMetadata : (NSString *) metadata;
- (NSString *) getMetadata;
@end
