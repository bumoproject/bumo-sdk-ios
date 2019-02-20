//
//  TransactionServiceImpl.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionService.h"

@interface TransactionServiceImpl : TransactionService

/**
 Get the transaction information

 @param hash The transaction hash
 @return TransactionGetInfoResponse The transaction information
 */
+ (TransactionGetInfoResponse *) getTransactionInfo : (NSString *) hash;
@end
