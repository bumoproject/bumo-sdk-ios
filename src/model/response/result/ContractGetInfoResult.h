//
//  ContractGetInfoResult.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContractInfo.h"

@interface ContractGetInfoResult : NSObject
@property (nonatomic, strong) ContractInfo *contract;
@end
