//
//  AccountCheckValidRequest.h
//  test-sdk-ios
//
//  Created by dxl on 2018/7/24.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountCheckValidRequest : NSObject {
@private
    NSString *_address;
}

-(void)setAddress:(NSString *)address;
-(NSString *)getAddress;
@end
