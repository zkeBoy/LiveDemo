//
//  LLLiveTopView.h
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, selectType) {
    selectTypeUserInfo     = 0, //查看用户信息
    selectTypeLiverEarning = 1  //查看主播收益
};

@protocol LLLiveTopViewDelegate <NSObject>
@optional
- (void)topViewDelegateActionAccordingType:(selectType)type;

- (void)seeLiverUserInfomation;     //查看主播用户信息
- (void)seeUserInfomation:(id)info; //查看用户信息

@end

@interface LLLiveTopView : UIView
@property (nonatomic, weak) id <LLLiveTopViewDelegate> delegate;
@end
