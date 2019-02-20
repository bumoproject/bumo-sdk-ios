//
//  BlockGetNumberResult.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockNumber.h"

@interface BlockGetNumberResult : NSObject
@property (nonatomic, strong) BlockNumber *header;
@end
