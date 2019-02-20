//
//  AccountGetInfoResult.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Priv.h"

@interface AccountGetInfoResult : NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) int64_t balance;
@property (nonatomic, assign) int64_t nonce;
@property (nonatomic, strong) Priv *priv;
@end
