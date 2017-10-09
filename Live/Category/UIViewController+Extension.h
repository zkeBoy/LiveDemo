//
//  UIViewController+Extension.h
//  Live
//
//  Created by MliBo on 2017/9/6.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)
@property (nonatomic, strong) UIView      * bgView;     //默认是白色的
@property (nonatomic, strong) UIImageView * loadingHUB; //加载视图

- (void)showloadingHUB:(NSArray *)images toView:(UIView *)view;
- (void)hiddenloadingHUB;

- (void)showloadErrorImage:(UIImage *)image
                     title:(NSDictionary *)title
                   message:(NSDictionary *)message
               addSelector:(SEL)method
                    toView:(UIView *)view;

- (void)addEffectToView:(UIImageView *)imageView;

#pragma mark -
- (void)setNavigationBarBackgroundColor:(UIColor *)color;
- (void)setNavigationBarBackgroundImage:(UIImage *)image;
- (void)setNavigationBarSeparateLineColor:(UIColor *)color;
- (void)setNavigationBarSeparateLineStatus:(BOOL)hidden;
- (void)hiddenNavigationBarStatus:(BOOL)hidden;

@end
