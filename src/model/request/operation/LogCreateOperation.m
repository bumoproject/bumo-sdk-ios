//
//  LogCreateOperation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "LogCreateOperation.h"

@implementation LogCreateOperation
- (instancetype)init {
    _operationType = LOG_CREATE;
    return [super init];
}

- (void) setTopic : (NSString *) topic {
    _topic = topic;
}
- (NSString *) getTopic {
    return _topic;
}

- (void) setDatas : (NSMutableArray<NSString *> *) datas {
    _datas = datas;
}
- (void) setData : (NSString *) data {
    if (nil == _datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    [_datas removeAllObjects];
    [_datas addObject : data];
}
- (void) addData : (NSString *) data {
    if (nil == _datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    [_datas addObject : data];
}
- (NSMutableArray<NSString *> *) getDatas {
    return _datas;
}
@end
