//
//  LLHeaderBottomView.m
//  Live
//
//  Created by MliBo on 2017/9/19.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLHeaderBottomView.h"

@interface LLHeaderBottomView ()
@property (nonatomic, strong) NSArray * items;

@end

@implementation LLHeaderBottomView

- (instancetype)initWithFrame:(CGRect)frame withItems:(NSArray <LLHeaderBottomItem *> *)array{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = array;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    NSMutableArray * objs = [NSMutableArray arrayWithCapacity:self.items.count];
    NSInteger tag = 100;
    for (LLHeaderBottomItem * item in self.items) {
        UIButton * button = [UIButton initWithFrame:CGRectZero
                                          addTarget:self
                                             action:@selector(touchUpInsideWithButton:)
                                   forControlEvents:UIControlEventTouchUpInside
                                              image:[UIImage imageNamed:item.imageName]
                                    imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)
                                    titleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)
                                              title:item.title
                                         titleColor:[UIColor blackColor]
                                       andButtonTag:tag];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height-4, 0, 0, -button.titleLabel.intrinsicContentSize.width+8)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.currentImage.size.height+4, -button.currentImage.size.width, 0, 0)];
        button.backgroundColor = [UIColor clearColor];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [objs addObject:button];
        [self addSubview:button];
        tag ++;
    }
    // 创建水平排列图标 arr中放置了2个或连个以上的初始化后的控件
    // alongAxis 轴线方向 固定间隔 头部间隔 尾部间隔
    [objs mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [objs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    //添加竖线
    for (NSInteger index=0; index<objs.count-1; index++) {
        UIButton * button = objs[index];
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = MainColor;
        [button addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button).offset(scale(2));
            make.bottom.equalTo(button).offset(scale(-2));
            make.right.equalTo(button).offset(0);
            make.width.mas_offset(1);
        }];
    }
}

- (void)touchUpInsideWithButton:(UIButton *)button{
    NSInteger tag = button.tag;
    if ([self.delegate respondsToSelector:@selector(didClickButtonWithTag:)]) {
        [self.delegate didClickButtonWithTag:tag];
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

@implementation LLHeaderBottomItem

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName{
    if (self) {
        _title = title;
        _imageName = imageName;
    }
    return self;
}

@end
