//
//  mnemonic.h
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/11.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mnemonic : NSObject
+ (NSArray *) generateMnemonicCode: (NSData *)random;
+ (NSData *) randomFromMnemonicCode: (NSArray *)mnemonicCodes;
+ (NSArray *) generatePrivateKeys: (NSArray *)mnemonicCodes : (NSArray *)hdPaths;
@end

NS_ASSUME_NONNULL_END
