//
//  LLLiveContentView.h
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLLivePersonDetailView.h"

static NSString * const NotificationLiveContentViewDidClick = @"didSingleClickLiveContentView";

@protocol LLLiveContentViewDelegate <NSObject>
@optional
- (void)touchUpInsideXXXViewWithCloseLiveRoom; //关闭直播
- (void)touchUpInsideXXXViewWithPostMessage;   //发送消息
- (void)touchUpInsideXXXViewWithSendGift;      //发送礼物
- (void)touchUpInsideXXXViewWithShareStation;  //分享平台

- (void)didSelectHeaderBottomViewWithTag:(btnTagType)type;

@end

@interface LLLiveContentView : UIView
@property (nonatomic, weak) id <LLLiveContentViewDelegate> delegate;
@end
