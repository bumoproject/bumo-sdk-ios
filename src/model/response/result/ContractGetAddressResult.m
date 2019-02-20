//
//  ContractGetAddressResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractGetAddressResult.h"
#import "YYModelClass.h"

@implementation ContractGetAddressResult
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"contractAddressInfos" : @"contract_address_infos"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"contractAddressInfos" : [ContractAddressInfo class]};
}
@end
