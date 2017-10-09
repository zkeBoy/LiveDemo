//
//  LLPersonCellView.m
//  Live
//
//  Created by MliBo on 2017/9/20.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLPersonCellView.h"

@interface LLPersonCellView ()
@property (nonatomic, strong) UIView      * mainView;
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UILabel     * detailLabel;
@property (nonatomic, strong) UILabel     * titleLabel;

@end

@implementation LLPersonCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self.contentView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.mainView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mainView.mas_centerY);
        make.left.equalTo(self.mainView).offset(scale(20));
        make.width.height.mas_equalTo(scale(24));
    }];
    
    [self.mainView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mainView);
        make.width.height.mas_equalTo(self.titleLabel);
        make.left.equalTo(self.iconView.mas_right).offset(scale(20));
    }];
    
    [self.mainView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mainView);
        make.width.height.mas_equalTo(self.detailLabel);
        make.right.equalTo(self.mainView).offset(scale(-20));
    }];
}

- (void)setItem:(LLPersonNormalRow *)item{
    _item = item;
    self.iconView.image = [UIImage imageNamed:item.icon];
    
    self.titleLabel.text  = item.title;
    self.detailLabel.text = item.detailTitle;
}

#pragma mark - lazy init
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor whiteColor];
    }
    return _iconView;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel initWithFrame:CGRectZero
                                         text:@""
                                textAlignment:NSTextAlignmentLeft
                                    textColor:[UIColor lightGrayColor]
                                         font:[UIFont systemFontOfSize:14]];
    }
    return _detailLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel initWithFrame:CGRectZero
                                        text:@""
                               textAlignment:NSTextAlignmentRight
                                   textColor:[UIColor blackColor]
                                        font:[UIFont systemFontOfSize:14]];
    }
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
