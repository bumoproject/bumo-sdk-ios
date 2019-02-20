//
//  BuServiceImpl.m
//  sdk-ios
//
//  Created by dxl on 2018/8/12.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BuServiceImpl.h"
#import "Tools.h"
#import "General.h"
#import "Constant.h"
#import "Http.h"
#import "SDKError.h"
#import "SDKException.h"

@implementation BuServiceImpl
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
+ (Operation *) send : (BUSendOperation *) buSendOperation : (NSString *) transSourceAddress {
    if ([Tools isEmpty : buSendOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [buSendOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    NSString *destAddress = [buSendOperation getDestAddress];
    if (![Tools isAddressValid : destAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_DESTADDRESS_ERROR];
    }
    BOOL isNotValid = (![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : destAddress]) || [transSourceAddress isEqualToString : destAddress];
    if (isNotValid) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_DESTADDRESS_ERROR];
    }
    int64_t amount = [buSendOperation getAmount];
    if (amount < 0) {
        @throw [[SDKException alloc] initWithCode : INVALID_BU_AMOUNT_ERROR];
    }
    NSString *metadata = [buSendOperation getMetadata];
    // make operation
    Operation *operation = [Operation message];
    [operation setType : Operation_Type_PayCoin];
    if (![Tools isEmpty : sourceAddress]) {
        [operation setSourceAddress : sourceAddress];
    }
    if (![Tools isEmpty : metadata]) {
        [operation setMetadata : [metadata dataUsingEncoding : NSUTF8StringEncoding]];
    }
    OperationPayCoin *operationPayCoin = [OperationPayCoin message];
    [operationPayCoin setDestAddress : destAddress];
    [operationPayCoin setAmount : amount];
    [operation setPayCoin : operationPayCoin];
    return operation;
}
@end
