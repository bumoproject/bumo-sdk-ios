//
//  TransactionSignResult.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignatureInfo.h"

@interface TransactionSignResult : NSObject
@property (nonatomic, strong) NSArray *signatures;
@end
