//
//  BUChainKey.h
//  sdk-ios
//
//  Created by 冯瑞明 on 2018/10/18.
//  Copyright © 2018年 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUChainKey : NSObject
// Initializes master keychain from a seed. This is the "root" keychain of the entire hierarchy.
// Sets the network to mainnet. To specify testnet, use `-initWithSeed:network:`
- (id) initWithSeed:(NSData*)seed;

// Parses the BIP32 path and derives the chain of keychains accordingly.
// Path syntax: (m?/)?([0-9]+'?(/[0-9]+'?)*)?
// The following paths are valid:
//
// "" (root key)
// "m" (root key)
// "/" (root key)
// "m/0'" 或 "m/0H" (hardened child #0 of the root key)
// "/0'" 或 "/0H" (hardened child #0 of the root key)
// "0'" 或 "0H" (hardened child #0 of the root key)
// "m/44'/1'/2'" 或 "m/44H/1H/2H" (BIP44 testnet account #2)
// "/44'/1'/2'" 或 "44H/1H/2H" (BIP44 testnet account #2)
// "44'/1'/2'" 或 "44H/1H/2H" (BIP44 testnet account #2)
//
// The following paths are invalid:
//
// "m / 0 / 1" (contains spaces)
// "m/b/c" (alphabetical characters instead of numerical indexes)
// "m/1.2^3" (contains illegal characters)
- (BUChainKey*) derivedKeychainWithPath:(NSString*)path;

- (NSString *) getEncPrivateKey;
@end

NS_ASSUME_NONNULL_END
