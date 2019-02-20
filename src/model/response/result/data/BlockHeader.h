//
//  BlockHeader.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockHeader : NSObject
@property (nonatomic, assign) int64_t closeTime;
@property (nonatomic, assign) int64_t number;
@property (nonatomic, assign) int64_t txCount;
@property (nonatomic, copy) NSString *version;
@end
