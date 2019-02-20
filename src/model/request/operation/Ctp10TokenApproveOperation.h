//
//  Ctp10TokenApproveOperation.h
//  sdk-ios
//
//  Created by dxl on 2018/8/13.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@interface Ctp10TokenApproveOperation : BaseOperation {
@private
    NSString *_contractAddress;
    NSString *_spender;
    NSString *_tokenAmount;
}
- (void) setContractAddress : (NSString *) contractAddress;
- (NSString *) getContractAddress;

- (void) setSpender : (NSString *) spender;
- (NSString *) getSpender;

- (void) setTokenAmount : (NSString *) tokenAmount;
- (NSString *) getTokenAmount;
@end
