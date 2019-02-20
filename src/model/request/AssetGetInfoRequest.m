//
//  AssetGetInfoRequest.m
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AssetGetInfoRequest.h"

@implementation AssetGetInfoRequest
- (void) setAddress : (NSString *)address {
    _address = address;
}
- (NSString *) getAddress {
    return _address;
}

- (void) setCode : (NSString *)code {
    _code = code;
}
- (NSString *) getCode {
    return _code;
}

- (void) setIssuer : (NSString *)issuer {
    _issuer = issuer;
}
- (NSString *) getIssuer {
    return _issuer;
}
@end
