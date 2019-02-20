//
//  TransactionBuildBlobResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "TransactionBuildBlobResult.h"

@interface TransactionBuildBlobResponse : BaseResponse
@property (nonatomic, strong) TransactionBuildBlobResult *result;

-(void)buildResponse:(int32_t)errorCode :(TransactionBuildBlobResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionBuildBlobResult *)result;
@end
