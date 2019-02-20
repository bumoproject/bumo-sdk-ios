//
//  LogServiceImpl.m
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "LogServiceImpl.h"
#import "Tools.h"
#import "General.h"
#import "Constant.h"
#import "Http.h"
#import "SDKError.h"
#import "SDKException.h"
#import "YYModelClass.h"

@implementation LogServiceImpl
+ (Operation *) create : (LogCreateOperation *) logCreateOperation {
    if ([Tools isEmpty : logCreateOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [logCreateOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    NSString *topic = [logCreateOperation getTopic];
    if ([Tools isEmpty: topic] || [topic length] < LOG_TOPIC_MIN || [topic length] > LOG_TOPIC_MAX) {
        @throw [[SDKException alloc] initWithCode : INVALID_LOG_TOPIC_ERROR];
    }
    NSMutableArray<NSString *> *datas = [logCreateOperation getDatas];
    if ([Tools isEmpty: datas]) {
        @throw [[SDKException alloc] initWithCode : INVALID_LOG_DATA_ERROR];
    }
    for (NSString *data in datas) {
        if ([data length] < LOG_EACH_DATA_MIN || [data length] > LOG_EACH_DATA_MAX) {
            @throw [[SDKException alloc] initWithCode : INVALID_LOG_DATA_ERROR];
        }
    }
    NSString *metadata = [logCreateOperation getMetadata];
    // Build operation
    Operation *operation = [Operation message];
    [operation setType: Operation_Type_Log];
    if (![Tools isEmpty: sourceAddress]) {
        [operation setSourceAddress: sourceAddress];
    }
    if (![Tools isEmpty: metadata]) {
        [operation setMetadata: [metadata dataUsingEncoding : NSUTF8StringEncoding]];
    }
    OperationLog *operationLog = [OperationLog message];
    [operationLog setTopic: topic];
    [operationLog setDatasArray: datas];
    [operation setLog: operationLog];
    
    return operation;
}
@end
