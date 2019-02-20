//
//  Ctp10TokenGetBalanceInput.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ctp10TokenGetBalanceParams.h"

@interface Ctp10TokenGetBalanceInput : NSObject
@property (nonatomic, copy) NSString *method;
@property (nonatomic, strong) Ctp10TokenGetBalanceParams *params;
@end
