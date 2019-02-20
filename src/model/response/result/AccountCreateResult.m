//
//  AccountCreateResult.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/1.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountCreateResult.h"
#import "YYModelClass.h"

@implementation AccountCreateResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"privateKey" : @"private_key",
             @"publicKey" : @"public_key",
             @"address" : @"address"};
}
@end
