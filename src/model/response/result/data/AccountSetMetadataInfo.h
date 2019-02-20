//
//  AccountSetMetadataInfo.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountSetMetadataInfo : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) int64_t version;
@property (nonatomic, assign) BOOL deleteFlag;
@end
