//
//  SDKException.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/1.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "SDKException.h"

@implementation SDKException

- (instancetype)initWithCode:(SdkError) errorCode{
    _errorCode = errorCode;
    _errorDesc = [SDKError getDescription : errorCode];
    return self;
}

- (instancetype)initWithCodeAndDesc:(int32_t) errorCode : (NSString *) errorDesc {
    _errorCode = errorCode;
    _errorDesc = errorDesc;
    return self;
}

- (int32_t) getErrorCode {
    return _errorCode;
}

- (NSString *) getErrorDesc {
    return _errorDesc;
}
@end
