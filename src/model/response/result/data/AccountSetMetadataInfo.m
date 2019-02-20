//
//  AccountSetMetadataInfo.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountSetMetadataInfo.h"
#import "YYModelClass.h"

@implementation AccountSetMetadataInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"deleteFlag" : @"delete_flag"};
}
@end
