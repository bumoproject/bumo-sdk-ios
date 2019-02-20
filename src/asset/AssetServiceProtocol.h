//
//  AssetServiceProtocol.h
//  sdk-ios
//
//  Created by dxl on 2018/8/10.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssetGetInfoResponse.h"
#import "AssetGetInfoRequest.h"

@protocol AssetServiceProtocol <NSObject>
@required

/**
 Get an asset of an account through asset key
 
 @param assetGetRequest
            address(NSString *) : the address of an account
 @return AssetGetInfoResponse
            errorCode(int64_t)
            errorDesc(NSString *)
            result(AssetGetAssetResult *)
                assets(NSArray<AssetInfo *> *) : asset list
                    key(AssetKeyInfo *) : asset key
                        code(NSString *) : asset code
                        issuer(NSString *) : asset issuer
                    amount(int64_t) : asset amount
 */
- (AssetGetInfoResponse *) getInfo : (AssetGetInfoRequest *) assetGetRequest;
@end
