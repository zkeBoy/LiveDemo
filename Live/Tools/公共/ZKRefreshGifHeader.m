//
//  ZKRefreshGifHeader.m
//  Live
//
//  Created by MliBo on 2017/8/23.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "ZKRefreshGifHeader.h"

@implementation ZKRefreshGifHeader

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setGiftImages];
    }
    return self;
}

- (void)setGiftImages{
    [self.lastUpdatedTimeLabel setHidden:YES];
    [self.stateLabel setHidden:YES];
    NSArray * images = @[[UIImage imageNamed:@"reflesh1_60x55"],
                         [UIImage imageNamed:@"reflesh2_60x55"],
                         [UIImage imageNamed:@"reflesh3_60x55"]];
    [self setImages:images forState:MJRefreshStateRefreshing];
    [self setImages:images forState:MJRefreshStatePulling];
    [self setImages:images forState:MJRefreshStateIdle];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
