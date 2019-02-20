//
//  Keypair.h
//  sdk-ios
//
//  Created by riven on 2018/8/18.
//  Copyright © 2018 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Keypair : NSObject {
@private
    NSData *_privateKey;
    NSData *_publicKey;
}

- (instancetype)initWithData : (NSData *)data;
- (NSString *) getEncPrivateKey;
- (NSString *) getEncPublicKey;
- (NSString *) getEncAddress;
- (NSData *) sign : (NSData *) data;
- (BOOL) verify : (NSData *)signature : (NSData *)data;

+ (NSString *) getEncPublicKey : (NSString *) privateKey;
+ (NSString *) getEncAddress : (NSString *) publicKey;
+ (NSString *) getEncAddressFromPrivateKey : (NSString *) privateKey;
+ (NSData *) sign : (NSData *) data : (NSString *) privateKey;
+ (BOOL) verify : (NSData *)signature : (NSData *) data : (NSString *) publicKey;
+ (BOOL) isPrivateKeyValid : (NSString *) privateKey;
+ (BOOL) isAddressValid : (NSString *) address;
@end
