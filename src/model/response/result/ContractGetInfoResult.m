//
//  ContractGetInfoResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractGetInfoResult.h"
#import "YYModelClass.h"

@implementation ContractGetInfoResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"contract" : ContractInfo.class};
}
@end
