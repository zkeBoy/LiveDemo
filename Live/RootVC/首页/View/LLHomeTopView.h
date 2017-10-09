//
//  LLHomeTopView.h
//  Live
//
//  Created by MliBo on 2017/8/11.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, selectButtonIndex) {
    selectButtonIndexOne = 10, //推荐
    selectButtonIndexTwo = 11, //游戏
    selectButtonIndexThr = 12, //娱乐
    selectButtonIndexFor = 13, //趣玩
    selectButtonIndexFir = 14  //手游
};

@protocol LLHomeTopViewDelegate <NSObject>
@required
- (void)selectButtonWithIndex:(selectButtonIndex)index;
@end

@interface LLHomeTopView : UIView
@property (nonatomic, weak) id <LLHomeTopViewDelegate> delegate;
@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, assign) NSInteger selectIndex; //选中的一项,可以设置默认
- (void)setlineViewOffsetx:(NSInteger)offsetx;
@end
