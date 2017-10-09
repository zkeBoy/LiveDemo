//
//  UIViewController+Extension.m
//  Live
//
//  Created by MliBo on 2017/9/6.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/runtime.h>

static NSString * const loadingKey = @"loadView";
static NSString * const background = @"bgView";

@implementation UIViewController (Extension)

- (void)setLoadingHUB:(UIView *)loadingHUB{
    objc_setAssociatedObject(self, &loadingKey, loadingHUB, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)loadingHUB{
    return objc_getAssociatedObject(self, &loadingKey);
}

- (void)setBgView:(UIView *)bgView{
    objc_setAssociatedObject(self, &background, bgView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)bgView{
    return objc_getAssociatedObject(self, &background);
}

- (void)instanceBgView:(UIView *)toView{
    UIView * vv = [[UIView alloc] init];
    vv.backgroundColor = [UIColor whiteColor];
    [toView addSubview:vv];
    [toView bringSubviewToFront:vv];
    [vv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.bgView = vv;
}

- (void)showloadingHUB:(NSArray *)images toView:(UIView *)view{
    if (self.bgView) {
        return;
    }
    
    [self instanceBgView:view];
    if (!images.count) {
        images = @[[UIImage imageNamed:@"hold1_60x72_"],
                   [UIImage imageNamed:@"hold2_60x72_"],
                   [UIImage imageNamed:@"hold3_60x72_"]];
    }
    UIImageView * HUB = [[UIImageView alloc] init];
    HUB.backgroundColor = [UIColor clearColor];
    HUB.userInteractionEnabled = NO;
    [self.bgView addSubview:HUB];
    [HUB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@60);
        make.height.equalTo(@70);
    }];
    self.loadingHUB = HUB;
    //动画图片数组
    self.loadingHUB.animationImages = images;
    //执行一次完整动画所需的时长
    self.loadingHUB.animationDuration = 0.5;
    //动画重复次数, 设置成0 就是无限循环
    self.loadingHUB.animationRepeatCount = 0;
    [self.loadingHUB startAnimating];
}

- (void)hiddenloadingHUB{
    if (self.loadingHUB.isAnimating) {
        [self.loadingHUB stopAnimating];
        [self.loadingHUB removeFromSuperview];
        self.loadingHUB = nil;
    }
    
    if (self.bgView) {
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }
}

- (void)showloadErrorImage:(UIImage *)image title:(NSDictionary *)title message:(NSDictionary *)message addSelector:(SEL)method toView:(UIView *)view{
    if (!image) {
        image = [UIImage imageNamed:@""];
    }
    [self instanceBgView:view];
    UIImageView * icon = [[UIImageView alloc] initWithImage:image];
    [self.bgView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(self.bgView).offset(scale(200));
        make.width.mas_equalTo(scale(40));
        make.height.mas_equalTo(scale(60));
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.attributedText = [NSString initAttriButedStringWithDictionary:title];
    [self.bgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(scale(30));
        make.centerX.equalTo(self.bgView);
        make.width.height.equalTo(titleLabel);
    }];
    
    UILabel * messageLabel = [[UILabel alloc] init];
    messageLabel.attributedText = [NSString initAttriButedStringWithDictionary:message];
    [self.bgView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(scale(30));
        make.centerX.equalTo(self.bgView);
        make.width.height.equalTo(messageLabel);
    }];
    
    UIButton * btn = [[UIButton alloc] init];
    btn.layer.cornerRadius = 4.0f;
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"点击重试" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [btn addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(messageLabel.mas_bottom).offset(scale(30));
        make.width.mas_equalTo(scale(160));
        make.height.mas_equalTo(scale(30));
    }];
}

- (void)addEffectToView:(UIImageView *)imageView{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = imageView.bounds;
    [imageView addSubview:effectView];
}

+ (void)load{
    //Method originalMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
    //Method swizzledMethod = class_getInstanceMethod(self, @selector(zk_viewDidLoad));
    //method_exchangeImplementations(originalMethod, swizzledMethod);
}

#pragma mark - Extension Method
- (void)setNavigationBarBackgroundColor:(UIColor *)color{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color]
                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavigationBarBackgroundImage:(UIImage *)image{
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavigationBarSeparateLineColor:(UIColor *)color{
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:color]];
}

- (void)setNavigationBarSeparateLineStatus:(BOOL)hidden{
    [self.navigationController.navigationBar setClipsToBounds:hidden];
}

- (void)hiddenNavigationBarStatus:(BOOL)hidden{
    [self.navigationController setNavigationBarHidden:hidden animated:NO];
}

@end
