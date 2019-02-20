//
//  AccountGetInfoRequest.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountGetInfoRequest : NSObject {
@private
    NSString *_address;
}
-(void)setAddress:(NSString *)address;
-(NSString *)getAddress;
@end
