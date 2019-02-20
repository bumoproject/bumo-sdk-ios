//
//  Ctp10TokenAllowanceRequest.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ctp10TokenAllowanceRequest : NSObject {
@private
    NSString *_contractAddress;
    NSString *_tokenOwner;
    NSString *_spender;
}

- (void) setContractAddress : (NSString *) contractAddress;
- (NSString *) getContractAddress;

- (void) setSpender : (NSString *) spender;
- (NSString *) getSpender;

- (void) setTokenOwner : (NSString *) tokenOwner;
- (NSString *) getTokenOwner;
@end
