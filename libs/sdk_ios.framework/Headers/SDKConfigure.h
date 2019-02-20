//
//  SDKConfigure.h
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/11/27.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDKConfigure : NSObject {
@private
    int64_t _chainId;
    int64_t _timeOut;
}
- (void) setChainId: (int64_t)chainId;
- (int64_t) getChainId;
- (void) setTimeOut: (int64_t)timeOut;
- (int64_t) getTimeOut;
@end

NS_ASSUME_NONNULL_END
