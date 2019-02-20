//
//  TransactionSignResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import "BaseResponse.h"
#import "TransactionSignResult.h"

@interface TransactionSignResponse : BaseResponse
@property (nonatomic, strong) TransactionSignResult *result;

-(void)buildResponse:(int32_t)errorCode :(TransactionSignResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionSignResult *)result;
@end
