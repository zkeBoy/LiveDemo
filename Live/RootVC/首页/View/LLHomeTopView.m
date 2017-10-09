//
//  LLHomeTopView.m
//  Live
//
//  Created by MliBo on 2017/8/11.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLHomeTopView.h"

#define s_h 40

@implementation LLHomeTopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    NSInteger width = scale(79);
    UIButton * btn1 = [self addButtonWithTag:selectButtonIndexOne title:@"推荐"]; btn1.selected = YES;
    UIButton * btn2 = [self addButtonWithTag:selectButtonIndexTwo title:@"游戏"];
    UIButton * btn3 = [self addButtonWithTag:selectButtonIndexThr title:@"娱乐"];
    UIButton * btn4 = [self addButtonWithTag:selectButtonIndexFor title:@"趣玩"];
    UIButton * btn5 = [self addButtonWithTag:selectButtonIndexFir title:@"手游"];
    [self addSubview:btn1];
    [self addSubview:btn2];
    [self addSubview:btn3];
    [self addSubview:btn4];
    [self addSubview:btn5];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.width.equalTo(@scale(width));
        make.height.equalTo(@scale(s_h));
        make.left.equalTo(self).offset(2);
    }];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.width.equalTo(@scale(width));
        make.height.equalTo(@scale(s_h));
        make.left.equalTo(btn1.mas_right).offset(4);
    }];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.width.equalTo(@scale(width));
        make.height.equalTo(@scale(s_h));
        make.left.equalTo(btn2.mas_right).offset(4);
    }];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.width.equalTo(@scale(width));
        make.height.equalTo(@scale(s_h));
        make.left.equalTo(btn3.mas_right).offset(4);
    }];
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.width.equalTo(@scale(width));
        make.height.equalTo(@scale(s_h));
        make.left.equalTo(btn4.mas_right).offset(4);
    }];

    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
        make.width.equalTo(@scale(width-30));
        make.left.equalTo(self).offset(15);
        make.height.equalTo(@scale(2));
    }];
    
    //最下面的细线
    UIView * splitline = [[UIView alloc] init];
    splitline.backgroundColor = [UIColor grayColor];
    [self addSubview:splitline];
    [splitline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(self).offset(0);
        make.height.equalTo(@0.5);
    }];
}

- (UIButton *)addButtonWithTag:(selectButtonIndex)tag title:(NSString *)title{
    UIButton * btn = [[UIButton alloc] init];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [btn addTarget:self action:@selector(clickTopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:tag];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    return btn;
}

- (void)clickTopButtonAction:(UIButton *)button{
    NSInteger index = button.tag;
    if ([self.delegate respondsToSelector:@selector(selectButtonWithIndex:)]) {
        [self.delegate selectButtonWithIndex:index];
    }
    self.lineView.centerX = button.centerX;
    
    //选中效果
    for (UIView * btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]&&[btn isEqual:button]) {
            ((UIButton *)btn).selected = YES;
        }else if ([btn isKindOfClass:[UIButton class]]){
            ((UIButton *)btn).selected = NO;
        }
    }
}

- (void)setlineViewOffsetx:(NSInteger)offsetx{
    for (UIView * btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]&&(btn.tag==offsetx+10)) {
            ((UIButton *)btn).selected = YES;
        }else if([btn isKindOfClass:[UIButton class]]&&(btn.tag!=offsetx+10)){
            ((UIButton *)btn).selected = NO;
        }
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
