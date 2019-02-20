//
//  BlockGetLatestFeesResult.h
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fees.h"

@interface BlockGetLatestFeesResult : NSObject
@property (nonatomic, strong) Fees *fees;
@end
