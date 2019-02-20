//
//  TransactionSignResult.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "TransactionSignResult.h"
#import "YYModelClass.h"

@implementation TransactionSignResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"signatures" : [SignatureInfo class]};
}
@end
