//
//  ContractCallInput.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractCallInput.h"
#import "YYModelClass.h"

@implementation ContractCallInput
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"sourceAddress" : @"source_address",
             @"contractAddress" : @"contract_address",
              @"optType" : @"opt_type",
              @"contractBalance" : @"contract_balance",
              @"feeLimit" : @"fee_limit",
              @"gasPrice" : @"gas_price"};
}
@end
