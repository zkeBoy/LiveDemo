//
//  LLLivePersonManager.h
//  Live
//
//  Created by MliBo on 2017/8/22.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLAdModel.h"
#import "LLMoreLiveModel.h"

@interface LLLivePersonManager : NSObject
+ (LLLivePersonManager *)livePersonManager;
- (void)refleshRequestWithResponse:(void (^)(id))responseBlock;
- (void)requestAdListWithResponse:(void (^)(id))resopnseBlock;

- (void)requestMiaoXingLivesWithURL:(NSString *)urlString response:(void(^)(id))responseBlock;
- (NSArray *)appendSectionAccordingArray:(NSArray *)array;
@end
