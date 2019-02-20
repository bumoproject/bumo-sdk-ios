//
//  Sha.h
//  sdk-ios
//
//  Created by riven on 2018/8/18.
//  Copyright © 2018 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hash : NSObject
+ (NSData *) sha224 : (NSData *) data;
+ (NSData *) sha256 : (NSData *) data;
+ (NSData *) sha384 : (NSData *) data;
+ (NSData *) sha512 : (NSData *) data;
+ (NSData *) md5 : (NSData *) data;
+ (NSData *) hmacMD5WithKey : (NSData *) data : (NSData *) key;
+ (NSData *) hmacSHA1WithKey : (NSData *) data : (NSData *) key;
+ (NSData *) hmacSHA224WithKey : (NSData *) data : (NSData *) key;
+ (NSData *) hmacSHA256WithKey : (NSData *) data : (NSData *) key;
+ (NSData *) hmacSHA384WithKey : (NSData *) data : (NSData *) key;
+ (NSData *) hmacSHA512WithKey : (NSData *) data : (NSData *) key;
@end
