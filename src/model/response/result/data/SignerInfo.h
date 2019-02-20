//
//  SignerInfo.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignerInfo : NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) int64_t weight;
@end
