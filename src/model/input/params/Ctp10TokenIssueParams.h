//
//  Ctp10TokenIssueParams.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ctp10TokenIssueParams : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, assign) int32_t decimals;
@property (nonatomic, copy) NSString *supply;
@end
