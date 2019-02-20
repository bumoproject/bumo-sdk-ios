//
//  SignatureInfo.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "SignatureInfo.h"
#import "YYModelClass.h"

@implementation SignatureInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"signData" : @"sign_data",
             @"publicKey" : @"public_key"};
}
@end
