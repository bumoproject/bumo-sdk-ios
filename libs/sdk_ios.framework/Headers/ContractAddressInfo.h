//
//  ContractAddressInfo.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContractAddressInfo : NSObject
@property (nonatomic, copy) NSString *contractAddress;
@property (nonatomic, assign) int32_t operationIndex;
@end
