//
//  LLRecommendItemView.m
//  Live
//
//  Created by MliBo on 2017/9/1.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLRecommendItemView.h"

@interface LLRecommendItemView ()
@property (nonatomic, strong) UIView      * mainView;
@property (nonatomic, strong) UIImageView * coverView;   //封面
@property (nonatomic, strong) UIImageView * peopleIcon;  //人Icon
@property (nonatomic, strong) UILabel     * nameLabel;   //昵称
@property (nonatomic, strong) UIImageView * eyesView;    //观看图标
@property (nonatomic, strong) UILabel     * watchNumber; //观看人数
@property (nonatomic, strong) UILabel     * titleLabel;  //标题
@end

@implementation LLRecommendItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addGestureRecognizer];
        [self initUI];
        [self layOutUI];
    }
    return self;
}

- (void)addGestureRecognizer{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickItemViewAction:)];
    [self addGestureRecognizer:tap];
}

- (void)initUI{
    [self addSubview:self.mainView];
    [self.mainView addSubview:self.coverView];
    [self.coverView addSubview:self.peopleIcon];
    [self.coverView addSubview:self.nameLabel];
    [self.coverView addSubview:self.watchNumber];
    [self.coverView addSubview:self.eyesView];
    [self.mainView addSubview:self.titleLabel];
}

- (void)layOutUI{
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.mainView);
        make.height.mas_equalTo(scale(140));
    }];
    
    [self.peopleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverView).offset(scale(CellSpace));
        make.bottom.equalTo(self.coverView).offset(-scale(CellSpace));
        make.width.height.mas_equalTo(scale(16));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.peopleIcon.mas_right).offset(scale(CellSpace));
        make.bottom.equalTo(self.peopleIcon);
        make.width.height.equalTo(self.nameLabel);
    }];
    
    [self.watchNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coverView).offset(scale(CellSpace));
        make.right.equalTo(self.coverView).offset(-scale(CellSpace));
        make.width.height.mas_equalTo(self.watchNumber);
    }];
    
    [self.eyesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.watchNumber);
        make.right.equalTo(self.watchNumber.mas_left).offset(-scale(CellSpace));
        make.width.mas_equalTo(scale(16));
        make.height.mas_equalTo(scale(14));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView).offset(0);
        make.top.equalTo(self.coverView.mas_bottom).offset(scale(CellSpace));
        make.width.height.equalTo(self.titleLabel);
    }];
}

#pragma mark - lazy init
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.clipsToBounds = YES;
    }
    return _mainView;
}

- (UIImageView *)coverView{
    if (!_coverView) {
        _coverView = [[UIImageView alloc] init];
        _coverView.backgroundColor = [UIColor whiteColor];
    }
    return _coverView;
}

- (UIImageView *)peopleIcon {
    if (!_peopleIcon) {
        _peopleIcon = [[UIImageView alloc] init];
        _peopleIcon.image = [UIImage imageNamed:@"watchPeople"];
        //_peopleIcon.image = [[UIImage imageNamed:@"watchPeople"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //_peopleIcon.tintColor = [UIColor orangeColor];
        _peopleIcon.backgroundColor = [UIColor whiteColor];
    }
    return _peopleIcon;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel initWithFrame:CGRectZero
                                       text:@"第一哥"
                              textAlignment:NSTextAlignmentCenter
                                  textColor:[UIColor whiteColor]
                                       font:[UIFont systemFontOfSize:11]
                               cornerRadius:0];
    }
    return _nameLabel;
}

- (UILabel *)watchNumber {
    if (!_watchNumber) {
        _watchNumber = [UILabel initWithFrame:CGRectZero
                                         text:@"10.2万"
                                textAlignment:NSTextAlignmentCenter
                                    textColor:[UIColor whiteColor]
                                         font:[UIFont systemFontOfSize:11]
                                 cornerRadius:0];
    }
    return _watchNumber;
}

- (UIImageView *)eyesView {
    if (!_eyesView) {
        _eyesView = [[UIImageView alloc] init];
        _eyesView.backgroundColor = [UIColor clearColor];
        UIImage * eyes = [UIImage drawEyesImageWithSize:CGSizeMake(16, 14)];
        _eyesView.image = eyes;
    }
    return _eyesView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel  = [UILabel initWithFrame:CGRectZero
                                         text:@"#鬼泣大神# 带你见证奇迹"
                                textAlignment:NSTextAlignmentCenter
                                    textColor:[UIColor blackColor]
                                         font:[UIFont systemFontOfSize:11]
                                 cornerRadius:0];
    }
    return _titleLabel;
}

#pragma mark - load data
- (void)setLiveData:(LLLivePerson *)liveData {
    _liveData = liveData;
    NSString *iconString = [liveData.creator objectForKey:iconKey];
    [self.coverView yy_setImageWithURL:[NSURL URLWithString:iconString] placeholder:nil options:YYWebImageOptionShowNetworkActivity progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        return [image yy_imageByRoundCornerRadius:8.0f];
    } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
    
    self.nameLabel.text = [liveData.creator objectForKey:nameKey];
    self.watchNumber.text = liveData.online_users;
}

#pragma mark - tap action
- (void)clickItemViewAction:(UITapGestureRecognizer *)tap{
    NSString * linkURL = _liveData.stream_addr;
    if ([self.delegate respondsToSelector:@selector(touchItemViewUpInsideWithLinkString:)]) { //返回直播链接
        [self.delegate touchItemViewUpInsideWithLinkString:linkURL];
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
