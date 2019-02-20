//
//  KeyStoreEty.m
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/26.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import "KeyStoreEty.h"

@implementation KeyStoreEty
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"aesctrIv" : @"aesctr_iv",
             @"cypherText" : @"cypher_text",
             @"scryptParams" : @"scrypt_params",
             @"aes128ctrIv" : @"aes128ctr_iv"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"scryptParams" : ScryptParamsEty.class};
}
@end
