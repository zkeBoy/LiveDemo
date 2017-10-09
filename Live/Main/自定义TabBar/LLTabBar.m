//
//  LLTabBar.m
//  Live
//
//  Created by YellowBoy on 2017/7/29.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLTabBar.h"

@interface LLTabBar ()

@property (nonatomic, strong) UIButton * centerItem;
@property (nonatomic, copy)   NSString * imageNameNormal;
@property (nonatomic, copy)   NSString * imageNameHighlight;
@property (nonatomic, assign) NSInteger  number;
@end

@implementation LLTabBar
    
- (instancetype)initTabBarButtonStateNormal:(NSString *)normal stateHighlight:(NSString *)highlight tabBarItemNumber:(NSInteger)number{
    self = [super init];
    if (self) {
        self.imageNameNormal = normal;
        self.imageNameHighlight = highlight;
        self.number = number;
    }
    return self;
}
    
- (UIButton *)centerItem{
    if (!_centerItem) {
        _centerItem = [[UIButton alloc] init];
        [_centerItem setBackgroundImage:[UIImage imageNamed:_imageNameNormal] forState:UIControlStateNormal];
        [_centerItem setBackgroundImage:[UIImage imageNamed:_imageNameHighlight] forState:UIControlStateHighlighted];
        [_centerItem setBackgroundColor:[UIColor clearColor]];
        [_centerItem addTarget:self action:@selector(clickCenterAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_centerItem];
    }
    return _centerItem;
}
    
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width  = self.frame.size.width/self.number;
    CGFloat height = self.frame.size.height;
    CGFloat frame_y = 0;
    __block CGFloat frame_x = 0;
    NSMutableArray * tabBarButtons = [NSMutableArray array];
    for (UIView * subView in self.subviews) {
        //过滤掉不是TabBarButton的View
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:subView];
        }
    }
    
    [tabBarButtons enumerateObjectsUsingBlock:^(UIView *  _Nonnull subView, NSUInteger index, BOOL * _Nonnull stop) {
        frame_x = index * width;
        if ((tabBarButtons.count%2!=0)&&(index==tabBarButtons.count/2)) {
            //重写设置中间的位置
            self.centerItem.frame = CGRectMake(frame_x, frame_y, width, height);
            [self bringSubviewToFront:self.centerItem];
        }else{
            subView.frame = CGRectMake(frame_x, frame_y, width, height);
        }
    }];
}
    
- (void)clickCenterAction{
    if ([self.delegate_ respondsToSelector:@selector(didClickCenterView)]) {
        [self.delegate_ didClickCenterView];
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
