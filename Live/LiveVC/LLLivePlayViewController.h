//
//  LLLivePlayViewController.h
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//  播放直播

#import <UIKit/UIKit.h>

@interface LLLivePlayViewController : UIViewController
@property (nonatomic, strong) id liveModel;

- (instancetype)initWithLiveString:(NSString *)liveString;
- (instancetype)initWithLiveModel:(id)model;
@end
