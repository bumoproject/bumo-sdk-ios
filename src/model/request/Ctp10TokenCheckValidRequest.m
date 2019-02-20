//
//  Ctp10TokenCheckValidRequest.m
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Ctp10TokenCheckValidRequest.h"

@implementation Ctp10TokenCheckValidRequest
- (void) setContractAddress : (NSString *) contractAddress {
    _contractAddress = contractAddress;
}
- (NSString *) getContractAddress {
    return _contractAddress;
}
@end
