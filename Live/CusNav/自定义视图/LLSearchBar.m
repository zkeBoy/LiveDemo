//
//  LLSearchBar.m
//  Live
//
//  Created by YellowBoy on 2017/8/3.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLSearchBar.h"
@interface LLSearchBar()
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UIImageView * searchIconView;
@property (nonatomic, strong) UISearchBar * searchView;
@property (nonatomic, strong) UIButton * scanView;
@end


@implementation LLSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
    
- (void)setUI{
    self.contentView = [[UIView alloc] initWithFrame:self.bounds];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    
    
}
    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
