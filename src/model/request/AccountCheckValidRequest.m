//
//  AccountCheckValidRequest.m
//  test-sdk-ios
//
//  Created by dxl on 2018/7/24.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountCheckValidRequest.h"

@implementation AccountCheckValidRequest
-(void)setAddress:(NSString *)address {
    _address = address;
}
-(NSString *)getAddress {
    return _address;
}
@end
