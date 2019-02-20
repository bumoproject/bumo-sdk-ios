//
//  Http.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Http : NSObject
+ (NSData *) get : (NSString *) url;

+ (NSData *) post : (NSString *)url : (NSString *)body;
@end
