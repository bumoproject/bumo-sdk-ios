//
//  Ctp10TokenMessageResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "Ctp10TokenMessageResult.h"

@interface Ctp10TokenMessageResponse : BaseResponse
@property (nonatomic, strong) Ctp10TokenMessageResult *result;
@end
