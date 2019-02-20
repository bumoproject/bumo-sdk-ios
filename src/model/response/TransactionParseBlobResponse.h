//
//  TransactionParseBlobResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "TransactionParseBlobResult.h"

@interface TransactionParseBlobResponse : BaseResponse
@property (nonatomic, strong) TransactionParseBlobResult *result;

-(void)buildResponse:(int32_t)errorCode :(TransactionParseBlobResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionParseBlobResult *)result;
@end
