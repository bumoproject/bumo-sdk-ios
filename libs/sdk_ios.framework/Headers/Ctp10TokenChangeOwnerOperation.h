//
//  Ctp10TokenChangeOwnerOperation.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@interface Ctp10TokenChangeOwnerOperation : BaseOperation {
@private
    NSString *_contractAddress;
    NSString *_tokenOwner;
}

- (void) setContractAddress : (NSString *) contractAddress;
- (NSString *) getContractAddress;

- (void) setTokenOwner : (NSString *) tokenOwner;
- (NSString *) getTokenOwner;
@end
