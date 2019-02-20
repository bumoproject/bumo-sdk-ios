//
//  Ctp10TokenIssueInitInput.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenIssueInitInput.h"
#import "YYModelClass.h"

@implementation Ctp10TokenIssueInitInput
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"params" : Ctp10TokenIssueParams.class};
}
@end
