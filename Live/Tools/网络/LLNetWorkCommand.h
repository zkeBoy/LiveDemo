//
//  LLNetWorkCommand.h
//  Live
//
//  Created by MliBo on 2017/8/22.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#ifndef LLNetWorkCommand_h
#define LLNetWorkCommand_h

typedef void(^completeBlock)(id); //成功的回掉
typedef void(^failureBlock)(id);  //失败的回掉
typedef void(^uploadProgress)(NSProgress *);

//?uid=133825214&interest=1
#define baseURL           @"http://116.211.167.106" //跟域名
#define livePersonListURL @"/api/live/aggregation"  //获取主播列表
#define MiaoXingLiveURL   @"http://live.9158.com/Fans/GetHotLive?page="

#endif /* LLNetWorkCommand_h */
