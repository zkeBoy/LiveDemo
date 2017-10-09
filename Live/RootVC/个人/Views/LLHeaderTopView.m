//
//  LLHeaderTopView.m
//  Live
//
//  Created by MliBo on 2017/9/19.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLHeaderTopView.h"

@interface LLHeaderTopView ()
@property (nonatomic, strong) UIButton * settingButton;  //设置
@property (nonatomic, strong) UIButton * historyButton;  //回看
@property (nonatomic, strong) UIButton * iconButton;     //用户头像
@property (nonatomic, strong) UIButton * registerButton; //注册
@property (nonatomic, strong) UIButton * loginButton;    //登陆
@property (nonatomic, strong) UIButton * messageButton;
@end

@implementation LLHeaderTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        //self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)setUI {
    [self addSubview:self.settingButton];
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(scale(28));
        make.height.mas_equalTo(scale(44));
        make.top.equalTo(self).offset(scale(28));
        make.right.equalTo(self).offset(scale(-10));
    }];
    
    [self addSubview:self.historyButton];
    [self.historyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.settingButton.mas_width);
        make.height.equalTo(self.settingButton.mas_height);
        make.top.equalTo(self.settingButton);
        make.right.equalTo(self.settingButton.mas_left).offset(scale(-14));
    }];
    
    [self addSubview:self.messageButton];
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(scale(14));
        //make.right.equalTo(self).offset(scale(-14)); //奇怪了
        make.bottom.equalTo(self).offset(scale(-8));
        make.height.mas_equalTo(scale(30));
    }];

    
    [self addSubview:self.iconButton];
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(scale(80));
        make.bottom.equalTo(self.messageButton.mas_top).offset(scale(-8));
        make.left.equalTo(self).offset(scale(10));
    }];
    
    [self addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconButton.mas_centerY);
        make.left.equalTo(self.iconButton.mas_right).offset(scale(18));
        make.width.mas_equalTo(scale(80));
        make.height.mas_equalTo(scale(30));
    }];
    
    [self addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.loginButton);
        make.centerY.equalTo(self.loginButton);
        make.left.equalTo(self.loginButton.mas_right).offset(scale(12));
    }];
}

#pragma mark - lazy init 
- (UIButton *)settingButton {
    if (!_settingButton) {
        _settingButton = [UIButton initWithFrame:CGRectZero
                                       addTarget:self
                                          action:@selector(clickActionWithButton:)
                                forControlEvents:UIControlEventTouchUpInside
                                imageNormalState:[UIImage imageNamed:@"icon_SetUp_normal"]
                             imageHighlightState:[UIImage imageNamed:@"icon_SetUp_press"]
                                    andButtonTag:topViewTypeSetting];
    }
    return _settingButton;
}

- (UIButton *)historyButton {
    if (!_historyButton) {
        _historyButton = [UIButton initWithFrame:CGRectZero
                                       addTarget:self
                                          action:@selector(clickActionWithButton:)
                                forControlEvents:UIControlEventTouchUpInside
                                imageNormalState:[UIImage imageNamed:@"icon_SetUp_normal"]
                             imageHighlightState:[UIImage imageNamed:@"icon_SetUp_press"]
                                    andButtonTag:topViewTypeHistory];
        _historyButton.hidden = YES;
    }
    return _historyButton;
}

- (UIButton *)messageButton {
    if (!_messageButton) {
        _messageButton = [UIButton initWithFrame:CGRectZero
                                       addTarget:self
                                          action:@selector(clickActionWithButton:)
                                forControlEvents:UIControlEventTouchUpInside
                                imageNormalState:nil
                             imageHighlightState:nil
                                    andButtonTag:topViewTypeUMessage];
        _messageButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _messageButton.backgroundColor = [UIColor blackColor];
        _messageButton.alpha = 0.2;
        _messageButton.layer.cornerRadius = 15;
        [_messageButton setTitle:@"  主人太懒,没有留下任何信息,是不是变猪了  " forState:UIControlStateNormal];
        [_messageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _messageButton;
}

- (UIButton *)iconButton {
    if (!_iconButton) {
        UIImage * image = [[UIImage imageNamed:@"placeholder_head"] yy_imageByRoundCornerRadius:80];
        _iconButton = [UIButton initWithFrame:CGRectZero
                                    addTarget:self
                                       action:@selector(clickActionWithButton:)
                             forControlEvents:UIControlEventTouchUpInside
                             imageNormalState:image
                          imageHighlightState:nil
                                 andButtonTag:topViewTypeIcon];
        //_iconButton.layer.cornerRadius = 100/2;
    }
    return _iconButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton initWithFrame:CGRectZero
                                     addTarget:self
                                        action:@selector(clickActionWithButton:)
                              forControlEvents:UIControlEventTouchUpInside
                              imageNormalState:nil
                           imageHighlightState:nil
                                  andButtonTag:topViewTypeLogin];
        _loginButton.layer.cornerRadius = 4.0;
        _loginButton.layer.borderWidth = 1.0;
        _loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _loginButton.layer.masksToBounds = YES;
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton initWithFrame:CGRectZero
                                        addTarget:self
                                           action:@selector(clickActionWithButton:)
                                 forControlEvents:UIControlEventTouchUpInside
                                 imageNormalState:nil
                              imageHighlightState:nil
                                     andButtonTag:topViewTypeRegister];
        _registerButton.layer.cornerRadius = 4.0;
        _registerButton.layer.borderWidth = 1.0;
        _registerButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _registerButton.layer.masksToBounds = YES;
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    }
    return _registerButton;
}

- (void)clickActionWithButton:(UIButton *)button{
    NSInteger tag = button.tag;
    if ([self.delegate respondsToSelector:@selector(clickHeaderTopViewWithType:)]) {
        [self.delegate clickHeaderTopViewWithType:tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
