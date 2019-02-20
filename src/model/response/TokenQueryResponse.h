//
//  TokenQueryResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenQueryResult.h"
#import "TokenErrorResult.h"

@interface TokenQueryResponse : NSObject
@property (nonatomic, strong) TokenQueryResult *result;
@property (nonatomic, strong) TokenErrorResult *error;
@end
