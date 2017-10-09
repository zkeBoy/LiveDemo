//
//  LLLivePersonManager.m
//  Live
//
//  Created by MliBo on 2017/8/22.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLLivePersonManager.h"

@implementation LLLivePersonManager

+ (LLLivePersonManager *)livePersonManager {
    static LLLivePersonManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LLLivePersonManager alloc] init];
    });
    return manager;
}

- (void)refleshRequestWithResponse:(void (^)(id))responseBlock{
    NSString * url = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    [[LLNetWorkManager shareManager] requestGetMethodWithURLString:url parameters:nil completeBlock:^(NSDictionary * response) {
        NSMutableArray * livePersons = [NSMutableArray array];
        NSArray * lives = [response objectForKey:@"lives"];
        for (NSDictionary * live in lives) {
            LLLivePerson * livePerson = [[LLLivePerson alloc] init];
            livePerson.sourceData = live;
            [livePersons addObject:livePerson];
        }
        NSArray * sections = [self appendSectionAccordingArray:livePersons];
        if (responseBlock) {
            responseBlock (sections);
        }
    } failureBlock:^(NSDictionary * dic) {
        
    }];
}

- (void)requestAdListWithResponse:(void (^)(id))resopnseBlock{
    NSString * urlString = @"http://live.9158.com/Living/GetAD";
    [[LLNetWorkManager shareManager] requestGetMethodWithURLString:urlString parameters:nil completeBlock:^(NSDictionary * result) {
        NSArray * list = result[@"data"];
        if (list.count) {
            NSMutableArray * ads = [NSMutableArray array];
            for (NSDictionary * dic in list) {
                LLAdModel *adModel = [[LLAdModel alloc] init];
                [adModel setValuesForKeysWithDictionary:dic];
                [ads addObject:adModel];
            }
            if (resopnseBlock) {
                resopnseBlock (ads);
            }
        }else{
            if (resopnseBlock) {
                resopnseBlock (nil);
            }
        }
    } failureBlock:^(id error) {
        if (!error) {
            if (resopnseBlock) {
                resopnseBlock (nil);
            }
        }
    }];
}

- (void)requestMiaoXingLivesWithURL:(NSString *)urlString response:(void(^)(id))responseBlock{
    [[LLNetWorkManager shareManager] requestGetMethodWithURLString:urlString parameters:nil completeBlock:^(NSDictionary * responseObject) {
        NSArray *result = [LLMoreLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        if (responseBlock) {
            responseBlock (result);
        }
    } failureBlock:^(id error) {
        if (responseBlock) {
            responseBlock (nil);
        }
    }];
}


- (NSArray *)appendSectionAccordingArray:(NSArray *)array{
    if (!array.count) {
        return nil;
    }
    NSInteger section = 4;
    NSInteger row = 4;
    NSMutableArray * sections = [NSMutableArray array]; NSInteger index = 0;
    for (NSInteger i = 0; i < section; i++) {
        NSMutableArray * rows = [NSMutableArray arrayWithCapacity:row];
        for (NSInteger k = 0; k < row; k++) {
            LLLivePerson * live = array[index];
            [rows addObject:live];
            index ++;
        }
        [sections addObject:rows];
    }
    NSArray * arr = [[NSArray alloc] initWithArray:sections];
    return arr;
}

@end
