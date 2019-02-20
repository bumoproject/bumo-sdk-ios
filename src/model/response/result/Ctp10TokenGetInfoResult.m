//
//  Ctp10TokenGetInfoResult.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenGetInfoResult.h"
#import "YYModelClass.h"

@implementation Ctp10TokenGetInfoResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"contractInfo" : TokenInfo.class};
}
@end
