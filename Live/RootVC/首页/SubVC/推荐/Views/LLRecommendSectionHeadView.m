//
//  LLRecommendSectionHeadView.m
//  Live
//
//  Created by MliBo on 2017/8/31.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLRecommendSectionHeadView.h"

#define W_H 20

@interface LLRecommendSectionHeadView ()
@property (nonatomic, strong) UIImageView * typeIConView;
@property (nonatomic, strong) UILabel     * typeTitleLabel;
@property (nonatomic, strong) UILabel     * moreLabel;
@property (nonatomic, strong) UIImageView * moreIconView;
@end

@implementation LLRecommendSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTapGestureRecognizer];
        [self initUI];
        [self layOutUI];
    }
    return self;
}

- (void)addTapGestureRecognizer{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self addGestureRecognizer:tap];
}

- (void)initUI{
    [self addSubview:self.typeIConView];
    [self addSubview:self.typeTitleLabel];
    [self addSubview:self.moreLabel];
    [self addSubview:self.moreIconView];
}

- (void)layOutUI{
    [self.typeIConView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(CellSpace);
        make.width.height.mas_equalTo(scale(W_H));
    }];
    
    [self.typeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.typeIConView.mas_right).offset(CellSpace);
        make.width.height.equalTo(self.typeTitleLabel);
    }];
    
    [self.moreIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-CellSpace);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(scale(14));
    }];
    
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moreIconView.mas_left).offset(-CellSpace);
        make.centerY.equalTo(self);
        make.width.height.equalTo(self.moreLabel);
    }];
}

#pragma mark - lazy init
- (UIImageView *)typeIConView{
    if (!_typeIConView) {
        _typeIConView = [[UIImageView alloc] init];
        _typeIConView.backgroundColor = [UIColor redColor];
        _typeIConView.userInteractionEnabled = NO;
    }
    return _typeIConView;
}

- (UILabel *)typeTitleLabel {
    if (!_typeTitleLabel) {
        _typeTitleLabel = [[UILabel alloc] init];
        _typeTitleLabel.text = @"this is a test";
        _typeTitleLabel.textColor = [UIColor blackColor];
        _typeTitleLabel.textAlignment = NSTextAlignmentLeft;
        _typeTitleLabel.font = [UIFont systemFontOfSize:14];
        _typeTitleLabel.userInteractionEnabled = NO;
    }
    return _typeTitleLabel;
}

- (UILabel *)moreLabel {
    if (!_moreLabel) {
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.text = @"更多";
        _moreLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _moreLabel.textAlignment = NSTextAlignmentRight;
        _moreLabel.font = [UIFont systemFontOfSize:13];
        _moreLabel.userInteractionEnabled = NO;
    }
    return _moreLabel;
}

- (UIImageView *)moreIconView {
    if (!_moreIconView) {
        _moreIconView = [[UIImageView alloc] init];
        _moreIconView.image = [UIImage imageNamed:@"right_arrow"];
        _moreIconView.userInteractionEnabled = NO;
    }
    return _moreIconView;
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap{
    if (self.clickMoreAction) {
        self.clickMoreAction();
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
