//
//  LLLoginTypeView.m
//  Live
//
//  Created by MliBo on 2017/8/10.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLLoginTypeView.h"

static NSInteger const W_H = 60; //width and height
static NSInteger const O_L = 50; //offset of left

@implementation LLLoginTypeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    UIButton * weiChatBtn = [self addButtonWithTag:loginTypeWeiChat
                                         forNormal:[UIImage imageNamed:@"wxLoginicon_60x60"]
                                         highlight:[UIImage imageNamed:@""]];
    UIButton * qqBtn      = [self addButtonWithTag:loginTypeQQ
                                         forNormal:[UIImage imageNamed:@"qqLoginicon_60x60"]
                                         highlight:[UIImage imageNamed:@""]];
    UIButton * weiBoBtn   = [self addButtonWithTag:loginTypeWeiBo
                                         forNormal:[UIImage imageNamed:@"wbLoginicon_60x60"]
                                         highlight:[UIImage imageNamed:@""]];
    
    [self addSubview:weiChatBtn];
    [self addSubview:qqBtn];
    [self addSubview:weiBoBtn];
    [weiChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.height.equalTo(@(W_H));
        make.left.equalTo(self).offset(O_L);
    }];
    
    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@(W_H));
    }];
    
    [weiBoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.height.equalTo(@(W_H));
        make.right.equalTo(self).offset(-O_L);
    }];
}

- (UIButton *)addButtonWithTag:(NSInteger)tag forNormal:(UIImage *)imageNormal highlight:(UIImage *)imageHighlight{
    UIButton * button = [[UIButton alloc] init];
    [button setTag:tag];
    [button setBackgroundImage:imageNormal forState:UIControlStateNormal];
    [button setBackgroundImage:imageHighlight forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)clickButtonAction:(UIButton *)btn{
    loginType type = btn.tag;
    if (self.clickActionBlock) {
        self.clickActionBlock(type);
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
