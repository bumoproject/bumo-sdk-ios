//
//  TransactionBuildBlobResult.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionBuildBlobResult : NSObject
@property (nonatomic, copy) NSString *transactionBlob;
@property (nonatomic, copy) NSString *transactionHash;
@end
