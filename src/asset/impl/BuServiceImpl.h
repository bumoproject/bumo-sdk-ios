//
//  BuServiceImpl.h
//  sdk-ios
//
//  Created by dxl on 2018/8/12.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUSendOperation.h"
#import "Chain.pbobjc.h"

@interface BuServiceImpl : NSObject
/**
 Send bu to other account that is in bu chain
 
 @param buSendOperation
            sourceAddress(NSString *) : The account who will make this sending bu operation
            destAddress(NSString *) : The account who will receive the bu
            amount(int64_t) : The bu amount
            metadata(NSString *) : Notes
 
 @param transSourceAddress : The source account who will start the transaction
 @return Operation *
 */
+ (Operation *) send : (BUSendOperation *) buSendOperation : (NSString *) transSourceAddress;
@end
