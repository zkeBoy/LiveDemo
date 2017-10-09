//
//  LLLivePersonDetailView.m
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLLivePersonDetailView.h"
@interface LLLivePersonDetailView()
@property (nonatomic, strong) UIView      * contentView;
@property (nonatomic, strong) UIButton    * reportButton; //举报
@property (nonatomic, strong) UIButton    * closeButton;  //关闭按钮
@property (nonatomic, strong) UIImageView * headerIconView;  //头像

@property (nonatomic, strong) UIView      * underlineView; //线
@end

@implementation LLLivePersonDetailView{
    showType _showType;
}

- (instancetype)initWithType:(showType)type {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _showType = type;
        self.alpha = 0;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_offset(scale(340));
        make.height.mas_offset(scale(420));
    }];
    
    [self.contentView addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(scale(30));
        make.top.equalTo(self.contentView).offset(scale(10));
        make.right.equalTo(self.contentView).offset(-scale(10));
    }];
    
    [self.contentView addSubview:self.reportButton];
    [self.reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(scale(30));
        make.width.mas_equalTo(scale(40));
    }];
    
    [self.contentView addSubview:self.headerIconView];
    [self.headerIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(scale(20));
        make.width.height.mas_equalTo(scale(80));
    }];
    
    [self.contentView addSubview:self.underlineView];
    [self.underlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(scale(-50));
    }];
    
    if (_showType!=showTypeLoginer) {
        [self addBottomBtns];
    }
}

- (void)addBottomBtns{
    NSArray * titles = @[@"关注",@"私聊",@"连麦",@"主页"];
    NSMutableArray * objs = [NSMutableArray arrayWithCapacity:titles.count];
    NSInteger tag = btnTagTypeFollow;
    for (NSInteger index=0; index<titles.count; index++) {
        UIButton * button = [UIButton initWithFrame:CGRectZero
                                          addTarget:self
                                             action:@selector(didClickButtonWithTag:)
                                   forControlEvents:UIControlEventTouchUpInside
                                              image:nil
                                    imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)
                                    titleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)
                                              title:titles[index]
                                         titleColor:[UIColor blackColor]
                                       andButtonTag:tag];
        button.backgroundColor = [UIColor clearColor];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [objs addObject:button];
        [self.contentView addSubview:button];
        tag ++;
    }
    [objs mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [objs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.underlineView).offset(0);
        make.bottom.equalTo(@0);
    }];
    
    //添加竖线
    for (NSInteger index=0; index<objs.count-1; index++) {
        UIButton * button = objs[index];
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = MainColor;
        [button addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button).offset(scale(4));
            make.bottom.equalTo(button).offset(scale(-4));
            make.right.equalTo(button).offset(0);
            make.width.mas_offset(1);
        }];
    }
}

#pragma mark - lazy init 
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 8.0f;
        _contentView.layer.shadowColor = [UIColor grayColor].CGColor;
        _contentView.layer.shadowOffset = CGSizeMake(5, 5);
        _contentView.layer.shadowOpacity = 0.4;
    }
    return _contentView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _closeButton.backgroundColor = [UIColor clearColor];
        [_closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"talk_close_40x40_"] forState:UIControlStateNormal];
    }
    return _closeButton;
}

- (UIButton *)reportButton {
    if (!_reportButton) {
        _reportButton = [UIButton initWithFrame:CGRectZero
                                      addTarget:self
                                         action:@selector(reportButtonAction)
                                        withTag:100
                               forControlEvents:UIControlEventTouchUpInside
                                          title:@"举报"
                               titleNormalColor:[UIColor redColor]
                                    selectColor:[UIColor whiteColor]];
    }
    return _reportButton;
}

- (UIImageView *)headerIconView {
    if (!_headerIconView) {
        UIImage * image = [UIImage imageNamed:@"placeholder_head"];
        _headerIconView = [[UIImageView alloc] init];
        [_headerIconView setImage:[image yy_imageByRoundCornerRadius:image.size.width]];
        _headerIconView.backgroundColor = [UIColor clearColor];
    }
    return _headerIconView;
}

- (UIView *)underlineView{
    if (!_underlineView) {
        _underlineView = [[UIView alloc] init];
        _underlineView.backgroundColor = MainColor;
    }
    return _underlineView;
}

#pragma mark - Out Action
- (void)show{
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.alpha = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }completion:^(BOOL finished) {
    
    }];
}

- (void)hidden{
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Private Method 
- (void)closeButtonAction{
    [self hidden];
}

- (void)reportButtonAction{ //举报

}

- (void)didClickButtonWithTag:(UIButton *)button{
    NSInteger tag = button.tag;
    if (tag==btnTagTypeFollow) {
        button.selected = !button.selected;
        if (button.selected) {
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationFollowSomeOneKey object:nil userInfo:@{@"follow":[NSNumber numberWithBool:YES]}];
        }else{
            [button setTitle:@"关注" forState:UIControlStateNormal];
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationFollowSomeOneKey object:nil userInfo:@{@"follow":[NSNumber numberWithBool:NO]}];
        }
    }
    if ([self.delegate respondsToSelector:@selector(selectHeaderBottomItemWithTag:)]) {
        [self.delegate selectHeaderBottomItemWithTag:tag];
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
