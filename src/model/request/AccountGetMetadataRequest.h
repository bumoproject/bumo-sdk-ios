//
//  AccountGetMetadataRequest.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/3.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountGetMetadataRequest : NSObject {
@private
    NSString *_address;
    NSString *_key;
}
-(void)setAddress:(NSString *)address;
-(NSString *)getAddress;
-(void)setKey:(NSString *)key;
-(NSString *)getKey;
@end
