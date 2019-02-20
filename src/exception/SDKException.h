//
//  SDKException.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/1.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDKError.h"

@interface SDKException : NSException {
@private
    SdkError       _errorCode;
    NSString     *_errorDesc;
}
- (instancetype)initWithCode:(SdkError) errorCode;
- (instancetype)initWithCodeAndDesc:(int32_t) errorCode : (NSString *) errorDesc;
- (int32_t) getErrorCode;
- (NSString *) getErrorDesc;
@end
