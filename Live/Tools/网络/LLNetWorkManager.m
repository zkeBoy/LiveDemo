//
//  LLNetWorkManager.m
//  Live
//
//  Created by MliBo on 2017/8/22.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLNetWorkManager.h"

@interface LLNetWorkManager ()

@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;

@end

@implementation LLNetWorkManager

+ (LLNetWorkManager *)shareManager {
    static LLNetWorkManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LLNetWorkManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                         @"text/plain",
                                                                         @"text/json",
                                                                         @"text/javascript",
                                                                         @"text/html",
                                                                         @"image/jpeg",
                                                                         @"application/octet-stream",
                                                                         @"image/png", nil];
    }
    return self;
}

//判断网络是否可用
- (BOOL)compareNetworkReachabilityEnable{
    BOOL internet = NO;
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    internet = reachabilityManager.reachable;
    return internet;
}

- (NSURLSessionTask *)requestURLString:(NSString *)urlString withPara:(NSDictionary *)para completeBlock:(completeBlock)success failureBlock:(failureBlock) failure{
    [[UIApplication sharedApplication] isNetworkActivityIndicatorVisible]; //显示网络请求
    if (![self compareNetworkReachabilityEnable]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (failure) {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"is a error test"                                                                      forKey:NSLocalizedDescriptionKey];
                NSError * error = [self customErrorDomain:@"" code:cErrorCodelackInternet userInfo:userInfo];
                failure(error);
            }
            return ;
        });
    }
    NSString * url = [baseURL stringByAppendingString:urlString];
    NSMutableURLRequest * request = [self.sessionManager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:para error:nil];
    [request setTimeoutInterval:20]; //设置请求超时时间
    NSURLSessionTask * task = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if (success) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    success (responseObject);
                }else{
                    NSDictionary * res = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    success (res);
                }
            }
        }else{
            //请求失败
        }
    }];
    [task resume];
    return task;
}

- (NSURLSessionTask *)requestGetMethodWithURLString:(NSString *)urlString parameters:(NSDictionary *)para completeBlock:(completeBlock)success failureBlock:(failureBlock)failure{
    [[UIApplication sharedApplication] isNetworkActivityIndicatorVisible]; //显示网络请求
    NSMutableURLRequest * request = [self.sessionManager.requestSerializer requestWithMethod:@"GET" URLString:urlString parameters:para error:nil];
    [request setTimeoutInterval:6]; //设置请求超时时间
    NSURLSessionTask * task = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if (success) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    success (responseObject);
                }else{
                    NSDictionary * res = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    success (res);
                }
            }
        }else{
            if (failure) {
                failure(nil);
            }
        }
    }];
    [task resume];
    return task;
}
    
- (NSURLSessionTask *)uploadUserHeadImage:(UIImage *)HeadImage
                            postURLString:(NSString *)urlString
                             postProgress:(uploadProgress)progress
                                  success:(completeBlock)uploadSuccess
                             failureBlock:(failureBlock) failure{
    NSData * imageData = UIImageJPEGRepresentation(HeadImage, 1.0);
    [[UIApplication sharedApplication] isNetworkActivityIndicatorVisible]; //显示网络请求
    NSURLSessionTask * task = [self.sessionManager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString * formatterString = [formatter stringFromDate:[NSDate date]];
        NSString * fileName = [NSString stringWithFormat:@"%@.jpg",formatterString];
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (uploadSuccess) {
            uploadSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure (error);
        }
    }];
    [task resume];
    return task;
}

- (NSError *)customErrorDomain:(NSString *)domain code:(cErrorCode)code userInfo:(NSDictionary *)userInfo{
    NSError *aError = [NSError errorWithDomain:domain code:code userInfo:userInfo];
    return aError;
}

@end
