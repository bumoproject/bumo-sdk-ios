//
//  LogCreateOperation.h
//  sdk-ios
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseOperation.h"

@interface LogCreateOperation : BaseOperation {
@private
    NSString *_topic;
    NSMutableArray<NSString *> *_datas;
}

- (void) setTopic : (NSString *) topic;
- (NSString *) getTopic;

- (void) setDatas : (NSMutableArray<NSString *> *) datas;
- (void) setData : (NSString *) data;
- (void) addData : (NSString *) data;
- (NSMutableArray<NSString *> *) getDatas;
@end
