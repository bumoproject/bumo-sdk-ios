//
//  Ctp10TokenGetSymbolRequest.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ctp10TokenGetSymbolRequest : NSObject {
@private
    NSString *_contractAddress;
}

- (void) setContractAddress : (NSString *) contractAddress;
- (NSString *) getContractAddress;

@end
