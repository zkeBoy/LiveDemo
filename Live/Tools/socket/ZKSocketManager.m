//
//  ZKSocketManager.m
//  socketDemo
//
//  Created by MliBo on 2017/8/9.
//  Copyright © 2017年 MliBo. All rights reserved.
//

#import "ZKSocketManager.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface ZKSocketManager()<GCDAsyncSocketDelegate>
@property (nonatomic, strong) GCDAsyncSocket * socket;
@property (nonatomic, strong) NSThread * mainThread;
@property (nonatomic, strong) NSTimer  * timer;
@end

@implementation ZKSocketManager

+ (instancetype)socketManager{
    static ZKSocketManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZKSocketManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initSocket];
    }
    return self;
}

- (void)initSocket{
    NSError * error;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    GCDAsyncSocket * socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:queue];
    BOOL connect = [socket connectToHost:SOCKET_HOST onPort:SOCKRT_PORT error:&error];
    if (!connect) {
        //链接服务器失败
        [self.delegate connectFailWithError:error];
    }
    self.socket = socket;
}

#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    //链接成功
    NSLog(@"链接成功");
    //发送心跳
    [self.mainThread start];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err{
    //断开链接
    NSLog(@"断开链接");
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    //接收数据
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",text);
}

#pragma mark - Private Method
- (NSThread *)mainThread{
    if (!_mainThread) {
        _mainThread = [[NSThread alloc] initWithTarget:self
                                              selector:@selector(startHeartBeat)
                                                object:nil];
    }
    return _mainThread;
}

- (void)startHeartBeat{
    /*
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(sendData)
                                                userInfo:nil
                                                 repeats:YES];
    */
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer timerWithTimeInterval:60
                                         target:self
                                       selector:@selector(sendData)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)destoryHeartBeat{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)sendData{
    //[self.socket writeData:nil withTimeout:-1 tag:0];
    NSLog(@"heart start");
}

@end
