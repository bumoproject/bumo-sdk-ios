//
//  LogServiceImpl.h
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chain.pbobjc.h"
#import "LogCreateOperation.h"

@interface LogServiceImpl : NSObject
+ (Operation *) create : (LogCreateOperation *) logCreateOperation;
@end
