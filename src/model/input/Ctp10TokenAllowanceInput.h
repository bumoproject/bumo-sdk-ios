//
//  Ctp10TokenAllowanceInput.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ctp10TokenAllowanceParams.h"

@interface Ctp10TokenAllowanceInput : NSObject
@property (nonatomic, copy) NSString *method;
@property (nonatomic, strong) Ctp10TokenAllowanceParams *params;
@end
