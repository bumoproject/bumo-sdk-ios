//
//  AccountGetMetadataRequest.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountGetMetadataRequest.h"

@implementation AccountGetMetadataRequest
-(void)setAddress:(NSString *)address {
    _address = address;
}
-(NSString *)getAddress {
    return _address;
}
-(void)setKey:(NSString *)key {
    _key = key;
}
-(NSString *)getKey {
    return _key;
}
@end
