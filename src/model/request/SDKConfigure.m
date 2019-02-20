//
//  SDKConfigure.m
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/11/27.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import "SDKConfigure.h"

@implementation SDKConfigure
- (instancetype)init {
    _chainId = 0;
    _timeOut = 15;
    return [super init];
}

- (void) setChainId: (int64_t)chainId {
    _chainId = chainId;
}
- (int64_t) getChainId {
    return _chainId;
}
- (void) setTimeOut: (int64_t)timeOut {
    _timeOut = timeOut;
}
- (int64_t) getTimeOut {
    return _timeOut;
}
@end
