//
//  AssetService.m
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AssetService.h"

#define AbstractMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@implementation AssetService
- (instancetype)init {
    NSAssert(![self isMemberOfClass:[AssetService class]], @"AssetService is an abstract class, you should not instantiate it directly.");
    return [super init];
}

- (AssetGetInfoResponse *) getInfo : (AssetGetInfoRequest *) assetGetRequest {
    AbstractMethodNotImplemented();
}
@end
