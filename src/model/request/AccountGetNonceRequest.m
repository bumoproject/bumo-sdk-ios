//
//  AccountGetNonceRequest.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountGetNonceRequest.h"

@implementation AccountGetNonceRequest
-(void)setAddress:(NSString *)address {
    _address = address;
}
-(NSString *)getAddress {
    return _address;
}
@end
