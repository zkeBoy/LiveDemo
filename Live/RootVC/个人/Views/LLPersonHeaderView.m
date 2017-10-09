//
//  LLPersonHeaderView.m
//  Live
//
//  Created by MliBo on 2017/9/19.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLPersonHeaderView.h"

@interface LLPersonHeaderView ()<LLPersonHeaderTopViewDelegate, LLPersonHeaderBottomViewDelegate>
@property (nonatomic, strong) LLHeaderTopView    * topView;
@property (nonatomic, strong) LLHeaderBottomView * bottonView;

@end

#define T_H 220

@implementation LLPersonHeaderView

+ (instancetype)headerWithFrame:(CGRect)frame andDelegate:(id)weak{
    LLPersonHeaderView * header = [[LLPersonHeaderView alloc] initWithFrame:frame];
    header.delegate = weak;
    return header;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self).offset(0);
        make.height.mas_offset(scale(T_H));
    }];
    
    [self addSubview:self.bottonView];
    [self.bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self).offset(0);
        make.top.equalTo(self.topView.mas_bottom).offset(0);
    }];
}

#pragma mark - lazy init
- (LLHeaderTopView *)topView{
    if (!_topView) {
        _topView = [[LLHeaderTopView alloc] init];
        _topView.delegate = self;
        _topView.backgroundColor = [UIColor orangeColor];
    }
    return _topView;
}

- (LLHeaderBottomView *)bottonView{
    if (!_bottonView) {
        NSArray * items = [[self newBottomItems] mutableCopy];
        _bottonView = [[LLHeaderBottomView alloc] initWithFrame:CGRectZero withItems:items];
        _bottonView.delegate = self;
        _bottonView.backgroundColor = [UIColor whiteColor];
    }
    return _bottonView;
}

#pragma mark - Private method
- (NSArray *)newBottomItems{
    LLHeaderBottomItem * item1 = [[LLHeaderBottomItem alloc] initWithTitle:@"消息" imageName:@"icon_messgae_setting"];
    LLHeaderBottomItem * item2 = [[LLHeaderBottomItem alloc] initWithTitle:@"任务" imageName:@"icon_messgae_setting"];
    LLHeaderBottomItem * item3 = [[LLHeaderBottomItem alloc] initWithTitle:@"排行" imageName:@"icon_account_setting"];
    LLHeaderBottomItem * item4 = [[LLHeaderBottomItem alloc] initWithTitle:@"充值" imageName:@"icon_account_setting"];
    
    NSArray * items = @[item1,
                        item2,
                        item3,
                        item4];
    return items;
}

#pragma mark - <LLPersonHeaderTopViewDelegate>
- (void)clickHeaderTopViewWithType:(topViewType)type{
    if ([self.delegate respondsToSelector:@selector(didClickHeaderTopViewWithType:)]) {
        [self.delegate didClickHeaderTopViewWithType:type];
    }
}

#pragma mark - <LLPersonHeaderBottomViewDelegate>
- (void)didClickButtonWithTag:(NSInteger)tag{
    if ([self.delegate respondsToSelector:@selector(didClickHeaderBottonViewWithTag:)]) {
        [self.delegate didClickHeaderBottonViewWithTag:tag];
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
