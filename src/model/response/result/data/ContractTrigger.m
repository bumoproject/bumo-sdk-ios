//
//  ContractTrigger.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractTrigger.h"
#import "YYModelClass.h"

@implementation ContractTrigger
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"transaction" : TriggerTransaction.class};
}
@end
