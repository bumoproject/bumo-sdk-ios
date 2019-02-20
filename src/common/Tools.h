//
//  Tools.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/1.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
+ (BOOL) isEmpty : (id) thing;
+ (BOOL) isPrivateKeyValid : (NSString *) privateKey;
+ (BOOL) isAddressValid : (NSString *) address;
+ (NSString *) sign : (NSString *) privateKey : (NSData *) data;
+ (NSString *) getPublicKey : (NSString *) privateKey;
+ (NSDictionary *) createAccount;
+ (NSData *) hexStrToData : (NSString *) hexStr;
+ (NSString *) dataToHexStr : (NSData *) data;
+ (NSString *) generateHashHex : (NSData *) data;
+ (NSArray *) dataToBitArray : (NSData *)hexData;
+ (BOOL) regexMatch : (NSString *) pattern : (NSString *) message : (NSError **) error;
+ (NSDecimalNumber *)unitWithoutDecimals : (NSString *)unitWithDecimals : (int) decimals;
+ (NSDecimalNumber *) unitWithDecimals : (NSString *)unitWithoutDecimals : (int) decimals;
+ (NSDecimalNumber *) MO2BU : (NSString *) mo;
+ (NSDecimalNumber *) BU2MO : (NSString *) bu;
@end
