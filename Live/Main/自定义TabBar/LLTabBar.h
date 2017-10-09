//
//  LLTabBar.h
//  Live
//
//  Created by YellowBoy on 2017/7/29.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLTabBarDelegate <NSObject>

@required
- (void)didClickCenterView;

@end

@interface LLTabBar : UITabBar
@property (nonatomic, weak) id <LLTabBarDelegate> delegate_;
    
/**
 初始化方法

 @param normal normal 状态下的背景图
 @param highlight highlight 状态下的背景图
 @return TabBar
 */
- (instancetype)initTabBarButtonStateNormal:(NSString *)normal
                             stateHighlight:(NSString *)highlight
                           tabBarItemNumber:(NSInteger)number;
@end
