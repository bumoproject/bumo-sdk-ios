//
//  TokenMessageResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenMessageResult.h"
#import "YYModelClass.h"

@implementation Ctp10TokenMessageResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"metadatas" : [MetadataInfo class],
             @"contract" : ContractInfo.class};
}
@end
