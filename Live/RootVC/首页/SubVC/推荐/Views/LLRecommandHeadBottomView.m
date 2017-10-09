//
//  LLRecommandHeadBottomView.m
//  Live
//
//  Created by MliBo on 2017/8/28.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLRecommandHeadBottomView.h"
#import "LLRecommandButton.h"

#define B_W 100
#define B_H 80
#define B_O 8

@interface LLRecommandHeadBottomView ()

@end

@implementation LLRecommandHeadBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    __weak typeof(self)weakSelf = self;
    self.userInteractionEnabled = YES;
    LLRecommandButton * button1 = [LLRecommandButton initWithFrame:CGRectMake(B_O+B_W*0, 0, B_W, B_H) image:@"bottom1" title:@"排行榜" tapBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(recommandHeadBottomClickButtonType:)]) {
            [weakSelf.delegate recommandHeadBottomClickButtonType:eventTypeOne];
        }
    }];
    [self addSubview:button1];
    
    LLRecommandButton * button2 = [LLRecommandButton initWithFrame:CGRectMake(B_O+B_W*1, 0, B_W, B_H) image:@"bottom2" title:@"消息" tapBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(recommandHeadBottomClickButtonType:)]) {
            [weakSelf.delegate recommandHeadBottomClickButtonType:eventTypeTwo];
        }
    }];
    [self addSubview:button2];
    
    LLRecommandButton * button3 = [LLRecommandButton initWithFrame:CGRectMake(B_O+B_W*2, 0, B_W, B_H) image:@"bottom3" title:@"活动" tapBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(recommandHeadBottomClickButtonType:)]) {
            [weakSelf.delegate recommandHeadBottomClickButtonType:eventTypeThree];
        }
    }];
    [self addSubview:button3];
    
    LLRecommandButton * button4 = [LLRecommandButton initWithFrame:CGRectMake(B_O+B_W*3, 0, B_W, B_H) image:@"bottom4" title:@"直播" tapBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(recommandHeadBottomClickButtonType:)]) {
            [weakSelf.delegate recommandHeadBottomClickButtonType:eventTypeFour];
        }
    }];
    [self addSubview:button4];
    
}

- (void)touchUpInsideWithButton:(UIButton *)button{
    eventType type = button.tag;
    if ([self.delegate respondsToSelector:@selector(recommandHeadBottomClickButtonType:)]) {
        [self.delegate recommandHeadBottomClickButtonType:type];
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
