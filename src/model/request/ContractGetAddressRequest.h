//
//  ContractGetAddressRequest.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContractGetAddressRequest : NSObject {
@private
    NSString *_hash;
}

- (void) setHash : (NSString *)hash;
- (NSString *) getHash;
@end
