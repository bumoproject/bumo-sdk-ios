//
//  ContractAddressInfo.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractAddressInfo.h"
#import "YYModelClass.h"

@implementation ContractAddressInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"contractAddress" : @"contract_address",
             @"operationIndex" : @"operation_index"
             };
}
@end
