//
//  Base58.h
//  examples
//
//  Created by riven on 2018/8/17.
//  Copyright © 2018 dlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base58 : NSObject {
@private
    const NSString* _alphabet;
    const NSString *_base58;
    const NSString *_base256;
    const NSData *_index;
}

- (uint8_t) divmo58 : (NSData **) input : (NSUInteger) startAt;
- (uint8_t) divmod256 : (NSData **)input : (NSUInteger) startAt;
- (NSString *) encode : (NSData *) data;
- (NSData *) decode : (NSString *) data;
@end
