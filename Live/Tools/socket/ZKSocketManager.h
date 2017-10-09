//
//  ZKSocketManager.h
//  socketDemo
//
//  Created by MliBo on 2017/8/9.
//  Copyright © 2017年 MliBo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SOCKET_HOST @"121.196.196.10"   //域名
#define SOCKRT_PORT 7272                //端口

@protocol ZKSocketManagerDelegate

- (void)connectFailWithError:(NSError *)error;

@end

@interface ZKSocketManager : NSObject

@property (nonatomic, weak) id <ZKSocketManagerDelegate> delegate;
+ (instancetype)socketManager;

@end
