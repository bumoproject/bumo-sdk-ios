//
//  KeyStore.h
//  sdk-ios
//
//  Created by dxl on 2018/8/8.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyStoreEty.h"

@interface KeyStore : NSObject

+ (KeyStoreEty *) generateKeyStoreFromData : (NSData *) password Data: (NSData *) data : (int32_t) version;
+ (KeyStoreEty *) generateKeyStoreFromData : (NSData *) password Data: (NSData *) data : (uint64_t) n : (uint32_t) r : (uint32_t) p : (int32_t) version;
+ (NSData *) decipherKeyStoreWithData : (KeyStoreEty *) key_store : (NSData *) password;

//If new_private_key is empty, create a new private key.
+ (KeyStoreEty *) generateKeyStore : (NSData *) password PrivateKey: (NSString *) privateKey : (int32_t) version;
+ (KeyStoreEty *) generateKeyStore : (NSData *) password PrivateKey: (NSString *) privateKey : (uint64_t) n : (uint32_t) r : (uint32_t) p : (int32_t) version;
+ (NSString *) decipherKeyStore : (KeyStoreEty *) key_store : (NSData *) password;

@end

