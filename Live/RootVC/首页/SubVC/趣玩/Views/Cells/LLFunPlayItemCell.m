//
//  LLFunPlayItemCell.m
//  Live
//
//  Created by MliBo on 2017/9/18.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLFunPlayItemCell.h"

@interface LLFunPlayItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView * iconView;
@property (weak, nonatomic) IBOutlet UILabel     * titleView;
@end

@implementation LLFunPlayItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
}

- (void)setUI{
    UIImage * image = [UIImage imageNamed:@"placeholder_head"];
    self.iconView.image = [image yy_imageByRoundCornerRadius:image.size.width];
    
    self.titleView.textColor = [UIColor lightGrayColor];
    self.titleView.text = @"王者农药";
}

@end
