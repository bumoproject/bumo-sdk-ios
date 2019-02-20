//
//  Ctp10TokenChangeOwnerInput.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ctp10TokenChangeOwnerParams.h"

@interface Ctp10TokenChangeOwnerInput : NSObject
@property (nonatomic, copy) NSString *method;
@property (nonatomic, strong) Ctp10TokenChangeOwnerParams *params;
@end
