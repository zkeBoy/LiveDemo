//
//  LLLiveBottomView.m
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLLiveBottomView.h"

#define W_H 40 //(width & height)
#define B_O 10 //(button offset)
#define B_S 20 //(button space)

@interface LLLiveBottomView ()
@property (nonatomic, strong) UIButton * closeButton; //关闭按钮
@property (nonatomic, strong) UIButton * giftButton;  //发送礼物
@property (nonatomic, strong) UIButton * shareButton; //分享按钮
@property (nonatomic, strong) UIButton * messageButton; //发送消息

@end

@implementation LLLiveBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self addSubview:self.closeButton];
    [self addSubview:self.messageButton];
    [self addSubview:self.shareButton];
    [self addSubview:self.giftButton];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(scale(-B_O));
        make.width.height.mas_equalTo(scale(W_H));
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(scale(B_O));
        make.width.height.mas_equalTo(scale(W_H));
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.messageButton.mas_right).offset(scale(B_S));
        make.width.height.mas_equalTo(scale(W_H));
    }];
    
    [self.giftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.shareButton.mas_right).offset(scale(B_S));
        make.width.height.mas_equalTo(scale(W_H));
    }];
}

#pragma mark - lazy init
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton initWithFrame:CGRectZero
                                     addTarget:self
                                        action:@selector(clickButtonAction:)
                              forControlEvents:UIControlEventTouchUpInside
                              imageNormalState:[UIImage imageNamed:@"talk_close_40x40_"]
                           imageHighlightState:[UIImage imageNamed:@""]
                                  andButtonTag:selectTagClose];
    }
    return _closeButton;
}

- (UIButton *)messageButton {
    if (!_messageButton) {
        _messageButton = [UIButton initWithFrame:CGRectZero
                                       addTarget:self
                                          action:@selector(clickButtonAction:)
                                forControlEvents:UIControlEventTouchUpInside
                                imageNormalState:[UIImage imageNamed:@"talk_public_40x40_"]
                             imageHighlightState:[UIImage imageNamed:@""]
                                    andButtonTag:selectTagMessage];
    }
    return _messageButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton initWithFrame:CGRectZero
                                     addTarget:self
                                        action:@selector(clickButtonAction:)
                              forControlEvents:UIControlEventTouchUpInside
                              imageNormalState:[UIImage imageNamed:@"talk_share_40x40_"]
                           imageHighlightState:[UIImage imageNamed:@""]
                                  andButtonTag:selectTagShare];
    }
    return _shareButton;
}

- (UIButton *)giftButton {
    if (!_giftButton) {
        _giftButton = [UIButton initWithFrame:CGRectZero
                                    addTarget:self
                                       action:@selector(clickButtonAction:)
                             forControlEvents:UIControlEventTouchUpInside
                             imageNormalState:[UIImage imageNamed:@"talk_sendgift_40x40_"]
                          imageHighlightState:[UIImage imageNamed:@""]
                                 andButtonTag:selectTagGift];
    }
    return _giftButton;
}

- (void)clickButtonAction:(UIButton *)button{
    NSInteger tag = button.tag;
    if ([self.delegate respondsToSelector:@selector(didSelectItemWithTag:)]) {
        [self.delegate didSelectItemWithTag:tag];
    }
}

- (void)dealloc {
    NSLog(@"LLLiveBottomView dealloc !!!!!!");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
