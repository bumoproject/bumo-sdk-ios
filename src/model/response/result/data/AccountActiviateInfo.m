//
//  AccountActiviateInfo.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountActiviateInfo.h"
#import "YYModelClass.h"

@implementation AccountActiviateInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"destAddress" : @"dest_address",
             @"initBalance" : @"init_balance",
             @"input" : @"init_input"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"contract" : [ContractInfo class],
             @"priv" : Priv.class,
             @"metadatas" : MetadataInfo.class};
}
@end
