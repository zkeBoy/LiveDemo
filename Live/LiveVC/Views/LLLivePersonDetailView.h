//
//  LLLivePersonDetailView.h
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//  个人详情页面

typedef NS_ENUM(NSInteger, showType) {
    showTypeOther   = 0, //观众
    showTypeLiver   = 1, //主播
    showTypeLoginer = 2, //自己
    showTypeDefault = 3  //默认
};

typedef NS_ENUM(NSInteger, btnTagType) {
    btnTagTypeFollow  = 1, //关注
    btnTagTypePChat   = 2, //私信
    btnTagTypeLianMai = 3, //连麦
    btnTagTypeHomePage = 4 //主页
};

#import <UIKit/UIKit.h>

@protocol LLLivePersonDetailViewDelegate <NSObject>

@optional
- (void)selectHeaderBottomItemWithTag:(NSInteger)tag;

@end

@interface LLLivePersonDetailView : UIView
@property (nonatomic, weak) id <LLLivePersonDetailViewDelegate> delegate;

- (instancetype)initWithType:(showType)type;

- (void)show;

@end
