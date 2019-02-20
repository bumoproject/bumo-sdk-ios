//
//  AssetGetInfoRequest.h
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetGetInfoRequest : NSObject {
@private
    NSString *_address;
    NSString *_code;
    NSString *_issuer;
}
- (void) setAddress : (NSString *)address;
- (NSString *) getAddress;

- (void) setCode : (NSString *)code;
- (NSString *) getCode;

- (void) setIssuer : (NSString *)issuer;
- (NSString *) getIssuer;
@end
