//
//  KeyStoreEty.h
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/26.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScryptParamsEty.h"

NS_ASSUME_NONNULL_BEGIN

@interface KeyStoreEty : NSObject
@property (nonatomic, copy) NSString *aesctrIv;
@property (nonatomic, copy) NSString *aes128ctrIv;
@property (nonatomic, copy) NSString *cypherText;
@property (nonatomic, strong) ScryptParamsEty *scryptParams;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) int32_t version;
@end

NS_ASSUME_NONNULL_END
