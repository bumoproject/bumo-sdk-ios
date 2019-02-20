//
//  TransactionTestRequest.m
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/30.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import "TransactionTestRequest.h"
#import "YYModelClass.h"

@implementation TransactionTestRequest
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"items" : [TransactionItem class]};
}

- (void) setTransactionItems : (NSMutableArray *) items {
    _items = items;
}
- (void) setTransactionItem : (TransactionItem *) item {
    if (nil == _items) {
        _items = [[NSMutableArray alloc] init];
    }
    [_items removeAllObjects];
    [_items addObject : item];
}
- (void) addTransactionItem : (TransactionItem *) item {
    if (nil == _items) {
        _items = [[NSMutableArray alloc] init];
    }
    [_items addObject : item];
}
- (NSMutableArray *) getOperations {
    return _items;
}
@end
