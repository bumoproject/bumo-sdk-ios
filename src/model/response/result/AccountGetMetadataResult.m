//
//  AccountGetMetadataResult.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountGetMetadataResult.h"
#import "YYModelClass.h"

@implementation AccountGetMetadataResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"metadatas" : [MetadataInfo class]};
}
@end
