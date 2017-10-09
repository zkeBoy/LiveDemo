//
//  LLNetWorkManager.h
//  Live
//
//  Created by MliBo on 2017/8/22.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "LLNetWorkCommand.h"

typedef NS_ENUM(NSInteger, cErrorCode) {
    cErrorCodelackInternet = 100000 //缺少网络
};

@interface LLNetWorkManager : NSObject

+ (LLNetWorkManager *)shareManager;

/**
 请求网络接口

 @param urlString 请求地址
 @param para 请求体
 @param success 成功的回掉
 @param failure 失败的回掉
 @return task
 */
- (NSURLSessionTask *)requestURLString:(NSString *)urlString
                              withPara:(NSDictionary *)para
                         completeBlock:(completeBlock)success
                          failureBlock:(failureBlock) failure;


/**
 GET 请求方式

 @param urlString 请求的连接
 @param para 请求体
 @param success 成功的回掉
 @param failure 失败的回掉
 @return task
 */
- (NSURLSessionTask *)requestGetMethodWithURLString:(NSString *)urlString
                                         parameters:(NSDictionary *)para
                                      completeBlock:(completeBlock)success
                                       failureBlock:(failureBlock) failure;


/**
 POST 上传图片

 @param HeadImage 需要上传的图片
 @param urlString 上传的地址
 @param progress 上传的进度
 @param uploadSuccess 成功的回掉
 @param failure 失败的回掉
 */
- (NSURLSessionTask *)uploadUserHeadImage:(UIImage *)HeadImage
                            postURLString:(NSString *)urlString
                             postProgress:(uploadProgress)progress
                                  success:(completeBlock)uploadSuccess
                             failureBlock:(failureBlock) failure;
@end
