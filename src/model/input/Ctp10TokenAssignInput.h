//
//  Ctp10TokenAssignInput.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ctp10TokenAssignParams.h"

@interface Ctp10TokenAssignInput : NSObject
@property (nonatomic, copy) NSString *method;
@property (nonatomic, strong) Ctp10TokenAssignParams *params;
@end
