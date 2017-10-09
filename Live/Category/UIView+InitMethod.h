//
//  UIView+InitMethod.h
//  Live
//
//  Created by YellowBoy on 2017/8/3.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (InitMethod)
+ (UIButton *)initWithFrame:(CGRect)frame imageNormalState:(UIImage *)imageNormal imageHighlightState:(UIImage *)imageHighlight;
+ (UIButton *)initWithFrame:(CGRect)frame imageNormalState:(UIImage *)imageNormal imageHighlightState:(UIImage *)imageHighlight andButtonTag:(NSInteger)tag;
+ (UIButton *)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)controlEvents imageNormalState:(UIImage *)imageNormal imageHighlightState:(UIImage *)imageHighlight andButtonTag:(NSInteger)tag;
+ (UIButton *)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)selector withTag:(NSInteger)tag forControlEvents:(UIControlEvents)controlEvents title:(NSString *)title titleNormalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor;
+ (UIButton *)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)controlEvents image:(UIImage *)image imageEdgeInsets:(UIEdgeInsets)imageInset titleEdgeInsets:(UIEdgeInsets)titleInset title:(NSString *)title titleColor:(UIColor *)color andButtonTag:(NSInteger)tag;

+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)color font:(UIFont *)font;
+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)color font:(UIFont *)font cornerRadius:(CGFloat)radius;
+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)color backgroundColor:(UIColor *)background alpha:(CGFloat)alpha font:(UIFont *)font cornerRadius:(CGFloat)radius addTarget:(id)target clickAction:(SEL)action;
@end
