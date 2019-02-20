//
//  Ctp10TokenGetBalanceRequest.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ctp10TokenGetBalanceRequest : NSObject {
@private
    NSString *_contractAddress;
    NSString *_tokenOwner;
}

- (void) setContractAddress : (NSString *) contractAddress;
- (NSString *) getContractAddress;

- (void) setTokenOwner : (NSString *) tokenOwner;
- (NSString *) getTokenOwner;
@end
