//
//  YZMyHeaderView.h
//  yuzhuaAPP
//
//  Created by yzw_xlf on 2018/3/7.
//  Copyright © 2018年 北京鱼爪网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YZMyHeaderViewDelegate;
@interface YZMyHeaderView : UIView
@property (nonatomic, strong) UIButton * switchBtn;
@property (nonatomic, strong) UIButton * messagesBtn;
@property (nonatomic, strong) UILabel  * titleLabel;
@property (nonatomic,   weak) id <YZMyHeaderViewDelegate> delegate;

//init Method
+ (instancetype)initWithFrame:(CGRect)frame andShowToView:(UIView *)view andDelegate:(id)delegate;
@end

@protocol YZMyHeaderViewDelegate <NSObject>
- (void)didSelectSwitchUserType; //切换用户
- (void)didSelectMoreMessage;    //选择更多消息


@end
