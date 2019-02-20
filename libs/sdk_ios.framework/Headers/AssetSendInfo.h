//
//  AssetSendInfo.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssetInfo.h"

@interface AssetSendInfo : NSObject
@property (nonatomic, copy) NSString *destAddress;
@property (nonatomic, strong) AssetInfo *asset;
@property (nonatomic, copy) NSString *input;
@end
