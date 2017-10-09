//
//  LLLiveOtherUserCell.m
//  Live
//
//  Created by MliBo on 2017/9/12.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLLiveOtherUserCell.h"

#define B_W 40

@interface LLLiveOtherUserCell ()
@property (nonatomic, strong) UIView      * mainView;
@property (nonatomic, strong) UIImageView * imageView;
@end

@implementation LLLiveOtherUserCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
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
    
    [self.mainView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainView);
    }];
}

#pragma mark - lazy init
- (UIView *)mainView {
    if (!_mainView) {
        _mainView= [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor clearColor];
    }
    return _mainView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        UIImage * image = [UIImage imageNamed:@"placeholder_head"];
        _imageView = [[UIImageView alloc] initWithImage:[image yy_imageByRoundCornerRadius:B_W]];
    }
    return _imageView;
}

@end
