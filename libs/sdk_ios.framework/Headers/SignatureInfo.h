//
//  SignatureInfo.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/4.
//  Copyright © 2018 bumo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignatureInfo : NSObject
@property (nonatomic, copy) NSString *signData;
@property (nonatomic, copy) NSString *publicKey;
@end
