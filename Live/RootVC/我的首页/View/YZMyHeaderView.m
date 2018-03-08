//
//  YZMyHeaderView.m
//  yuzhuaAPP
//
//  Created by yzw_xlf on 2018/3/7.
//  Copyright © 2018年 北京鱼爪网络科技有限公司. All rights reserved.
//

#import "YZMyHeaderView.h"

@implementation YZMyHeaderView

+ (instancetype)initWithFrame:(CGRect)frame andShowToView:(UIView *)view andDelegate:(id)delegate {
    YZMyHeaderView * header = [[YZMyHeaderView alloc] initWithFrame:frame];
    header.delegate = delegate;
    return header;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self addSubview:self.switchBtn];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(14);
        make.top.equalTo(self).offset(17);
        make.width.mas_equalTo(47);
        make.height.mas_equalTo(12);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(16);
        make.left.equalTo(self.switchBtn.mas_left).offset(104);
        make.top.equalTo(self).offset(13);
    }];
    
    [self addSubview:self.messagesBtn];
    [self.messagesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

#pragma mark - Button Action
- (void)switchUserTypeWithSender:(UIButton *)sender {
    
}

- (void)selectMoreMessageWithSender:(UIButton *)sender {
    
}

#pragma mark - lazy init
- (UIButton *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UIButton alloc] init];
        [_switchBtn addTarget:self action:@selector(switchUserTypeWithSender:) forControlEvents:UIControlEventTouchUpInside];
        [_switchBtn setTitle:@"买家信息" forState:UIControlStateNormal];
        [_switchBtn setTitle:@"卖家信息" forState:UIControlStateSelected];
        [_switchBtn setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] forState:UIControlStateNormal];
        [_switchBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Light" size:12.f]];
    }
    return _switchBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"我的";
        [_titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Light" size:18]];
        [_titleLabel setTintColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UIButton *)messagesBtn {
    if (!_messagesBtn) {
        
    }
    return _messagesBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
