//
//  Ctp10TokenAssignOperation.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@interface Ctp10TokenAssignOperation : BaseOperation {
@private
    NSString *_contractAddress;
    NSString *_destAddress;
    NSString *_tokenAmount;
}

- (void) setContractAddress : (NSString *) contractAddress;
- (NSString *) getContractAddress;

- (void) setDestAddress : (NSString *) destAddress;
- (NSString *) getDestAddress;

- (void) setTokenAmount : (NSString *) tokenAmount;
- (NSString *) getTokenAmount;
@end
