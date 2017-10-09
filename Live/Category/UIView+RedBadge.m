//
//  UIView+RedBadge.m
//  Live
//
//  Created by MliBo on 2017/9/22.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "UIView+RedBadge.h"
#import <objc/runtime.h>

static NSString * const redKey       = @"redBadeg";
static NSString * const redHiddenKey = @"redBadegHidden";

@implementation UIView (RedBadge)

- (void)setRed:(UIView *)red{
    objc_setAssociatedObject(self, &redKey, red, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)red{
    return objc_getAssociatedObject(self, &redKey);
}

- (void)setRedHidden:(BOOL)redHidden{
    objc_setAssociatedObject(self, &redHiddenKey, [NSNumber numberWithBool:redHidden], OBJC_ASSOCIATION_RETAIN);
    if (redHidden) {
        [self addRedBadeg];
        self.red.hidden = YES;
    }else{
        [self addRedBadeg];
        self.red.hidden = NO;
    }
}

- (BOOL)redHidden{
    return objc_getAssociatedObject(self, &redHiddenKey);
}

- (void)addRedBadeg{
    NSInteger pointWidth = 8; //小红点的宽高
    NSInteger rightRange = 5; //距离控件右边的距离
    self.red = [[UIView alloc] init];
    self.red.frame = CGRectMake(self.frame.size.width + rightRange, -pointWidth / 2, pointWidth, pointWidth);
    self.red.backgroundColor = [UIColor colorWithRed:251.0f/255.0f green:22.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
    //圆角为宽度的一半
    self.red.layer.cornerRadius = pointWidth / 2;
    //确保可以有圆角
    self.red.layer.masksToBounds = YES;
    [self addSubview:self.red];
    [self bringSubviewToFront:self.red];
    [self.red mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-2.f);
        make.right.mas_equalTo(pointWidth);
        make.height.width.mas_equalTo(pointWidth);
    }];
}

@end
