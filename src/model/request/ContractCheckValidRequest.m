//
//  ContractCheckValidRequest.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ContractCheckValidRequest.h"

@implementation ContractCheckValidRequest
- (void) setContractAddress : (NSString *) contractAddress {
    _contractAddress = contractAddress;
}
- (NSString *) getContractAddress {
    return _contractAddress;
}
@end
