//
//  LLRecommandButton.m
//  Live
//
//  Created by MliBo on 2017/8/28.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLRecommandButton.h"

#define B_W 59/2
#define B_H 59/2
#define B_T 10

#define L_W 59
#define L_H 18


@interface LLRecommandButton ()
@property (nonatomic, copy) NSString * imageName;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) clickTapGestureBlock clickTapBlock;
@end

@implementation LLRecommandButton

+ (instancetype)initWithFrame:(CGRect)frame image:(NSString *)imageName title:(NSString *)title tapBlock:(clickTapGestureBlock)block{
    LLRecommandButton * button = [[LLRecommandButton alloc] initWithFrame:frame];
    if (block) {
        button.clickTapBlock = block;
    }
    button.imageName = imageName;
    button.title     = title;
    [button setUI];
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setUI{
    NSString * imageName = [self.imageName mutableCopy];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = CGRectMake(self.width/2-B_W/2, B_T, B_W, B_H);
    imageView.userInteractionEnabled = NO; //不接收事件
    [self addSubview:imageView];
    
    NSString * title = [self.title mutableCopy];
    CGFloat L_T = CGRectGetMaxY(imageView.frame)+10;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, L_T, self.width, L_H)];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.userInteractionEnabled = NO;
    [self addSubview:label];
}


- (void)singleTapGestureRecognizer:(UITapGestureRecognizer *)tap{
    if (self.clickTapBlock) {
        self.clickTapBlock ();
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
