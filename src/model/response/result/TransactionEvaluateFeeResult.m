//
//  TransactionEvaluateFeeResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "TransactionEvaluateFeeResult.h"
#import "YYModelClass.h"

@implementation TransactionEvaluateFeeResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"data" : TestTx.class};
}
@end
