//
//  LLMoreViewCell.m
//  Live
//
//  Created by MliBo on 2017/9/7.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLMoreViewCell.h"

#define W_H 40

@interface LLMoreViewCell()
@property (nonatomic, strong) UIView      * mainView;    // 主视图
@property (nonatomic, strong) UIImageView * iconView;    // 头像
@property (nonatomic, strong) UIImageView * coverView;
@property (nonatomic, strong) UILabel     * nameLabel;   // 昵称
@property (nonatomic, strong) UILabel     * cityLabel;   // 城市
@property (nonatomic, strong) UILabel     * numberLabel; // 多少人观看
@end

@implementation LLMoreViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.contentView.backgroundColor = MainColor;
    [self.contentView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-scale(10));
    }];
    
    [self.mainView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.mainView).offset(scale(CellSpace));
        make.width.height.mas_equalTo(scale(W_H));
    }];
    
    [self.mainView addSubview:self.coverView];
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(scale(CellSpace));
        make.left.right.bottom.equalTo(self.mainView).offset(0);
    }];
    
    [self.mainView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(scale(CellSpace));
        make.top.equalTo(self.iconView);
        make.width.height.equalTo(self.nameLabel);
    }];
    
    [self.mainView addSubview:self.cityLabel];
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.iconView);
        make.width.height.equalTo(self.cityLabel);
    }];
    
    [self.mainView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(self.mainView).offset(scale(26));
        make.right.equalTo(self.mainView).offset(-scale(CellSpace));
        make.width.height.equalTo(self.numberLabel);
        make.centerY.equalTo(self.iconView.mas_centerY);
    }];
}

- (void)setLiveModel:(LLMoreLiveModel *)liveModel{
    _liveModel = liveModel;
    
    NSString * iconString = liveModel.smallpic;
    [self.iconView yy_setImageWithURL:[NSURL URLWithString:iconString] placeholder:nil options:YYWebImageOptionShowNetworkActivity progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        return [image yy_imageByRoundCornerRadius:W_H];
    } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
    
    self.nameLabel.text = liveModel.myname;
    
    self.cityLabel.text    = liveModel.gps;
    
    NSString * coverString = liveModel.bigpic;
    [self.coverView yy_setImageWithURL:[NSURL URLWithString:coverString] placeholder:nil options:YYWebImageOptionShowNetworkActivity completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
    
    NSString * online = [NSString stringWithFormat:@"%ld",liveModel.allnum];
    NSRange range = NSMakeRange(0, online.length);
    NSString * allString = [online stringByAppendingString:@"在观看"];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:allString];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
    [self.numberLabel setAttributedText:attributedString];
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

- (UIImageView *)coverView{
    if (!_coverView) {
        _coverView = [[UIImageView alloc] init];
        _coverView.backgroundColor = [UIColor whiteColor];
    }
    return _coverView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel initWithFrame:CGRectZero
                                       text:@""
                              textAlignment:NSTextAlignmentCenter
                                  textColor:[UIColor blackColor]
                                       font:[UIFont systemFontOfSize:14]];
    }
    return _nameLabel;
}

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [UILabel initWithFrame:CGRectZero
                                       text:@""
                              textAlignment:NSTextAlignmentCenter
                                  textColor:[[UIColor grayColor] colorWithAlphaComponent:0.8]
                                       font:[UIFont systemFontOfSize:11]];
    }
    return _cityLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [UILabel initWithFrame:CGRectZero
                                       text:@""
                              textAlignment:NSTextAlignmentCenter
                                  textColor:nil
                                       font:[UIFont systemFontOfSize:14]];
    }
    return _numberLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
