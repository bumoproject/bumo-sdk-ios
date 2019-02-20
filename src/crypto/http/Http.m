//
//  Http.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "Http.h"
#import "SDK.h"
#import "SDKError.h"
#import "SDKException.h"

@implementation Http
+ (NSData *) get : (NSString *) url {
    int64_t timeOut = 15;
    SDKConfigure *sdkConfigure = [SDK getConfigure];
    int64_t timeOutConf = [sdkConfigure getTimeOut];
    if (timeOutConf > 0) {
        timeOut = timeOutConf;
    }
    NSURL *nsUrl = [NSURL URLWithString : url];
    // url转化为一个请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL : nsUrl cachePolicy : NSURLRequestReloadIgnoringLocalCacheData timeoutInterval : timeOut];
    // 设置请求方法
    [request setHTTPMethod : @"GET"];
    // 同步执行Http请求，获取返回数据
    NSURLResponse *response;
    NSError *error;
    NSData *resultData = [NSURLConnection sendSynchronousRequest : request returningResponse : &response error : &error];
    if (error != nil) {
        SDKException *sdkException = [[SDKException alloc] initWithCode : CONNECTNETWORK_ERROR];
        @throw sdkException;
    }
    // 返回数据转为字符串
    //NSString *result = [[NSString alloc] initWithData:resultData encoding : NSUTF8StringEncoding];
    return resultData;
}

+ (NSData *) post : (NSString *)url : (NSString *)body {
    int64_t timeOut = 15;
    SDKConfigure *sdkConfigure = [SDK getConfigure];
    int64_t timeOutConf = [sdkConfigure getTimeOut];
    if (timeOutConf > 0) {
        timeOut = timeOutConf;
    }
    NSURL *nsUrl = [NSURL URLWithString : url];
    // url转化为一个请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL : nsUrl cachePolicy : NSURLRequestReloadIgnoringLocalCacheData timeoutInterval : timeOut];
    // 设置请求方法
    [request setHTTPMethod : @"POST"];
    //设置要发送的正文内容（适用于Post请求）
    if (![Tools isEmpty:body]) {
        NSData *data = [body dataUsingEncoding : NSUTF8StringEncoding];
        [request setHTTPBody : data];
    }
    // 同步执行Http请求，获取返回数据
    NSURLResponse *response;
    NSError *error;
    NSData *resultData = [NSURLConnection sendSynchronousRequest : request returningResponse : &response error : &error];
    if (error != nil) {
        SDKException *sdkException = [[SDKException alloc] initWithCode : CONNECTNETWORK_ERROR];
        @throw sdkException;
    }
    //返数据转成字符串
    //NSString *result = [[NSString alloc] initWithData : resultData encoding : NSUTF8StringEncoding];
    return resultData;
}
@end
