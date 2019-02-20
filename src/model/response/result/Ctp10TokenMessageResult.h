//
//  TokenMessageResult.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MetadataInfo.h"
#import "ContractInfo.h"

@interface Ctp10TokenMessageResult : NSObject
@property (nonatomic, strong) NSArray *metadatas;
@property (nonatomic, strong) ContractInfo *contract;
@end
