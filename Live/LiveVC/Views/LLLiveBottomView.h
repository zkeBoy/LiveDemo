//
//  LLLiveBottomView.h
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//
typedef NS_ENUM(NSInteger, selectTag) {
    selectTagClose   = 100, //关闭按钮tag
    selectTagGift    = 101, //礼物按钮tag
    selectTagShare   = 102, //分享按钮tag
    selectTagMessage = 103  //消息按钮tag
};

#import <UIKit/UIKit.h>
@protocol LLLiveBottomViewSelectDelegate <NSObject>
@optional
- (void)didSelectItemWithTag:(NSInteger)tag;

@end

@interface LLLiveBottomView : UIView
@property (nonatomic, weak) id <LLLiveBottomViewSelectDelegate> delegate;

@end
