//
//  ScryptParamsEty.h
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/18.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScryptParamsEty : NSObject
@property (nonatomic, assign) uint64_t n;
@property (nonatomic, assign) uint32_t p;
@property (nonatomic, assign) uint32_t r;
@property (nonatomic, copy) NSString *salt;
@end

NS_ASSUME_NONNULL_END
