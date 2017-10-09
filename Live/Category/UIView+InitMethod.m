//
//  UIView+InitMethod.m
//  Live
//
//  Created by YellowBoy on 2017/8/3.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "UIView+InitMethod.h"

@implementation UIView (InitMethod)
   
+ (UIButton *)initWithFrame:(CGRect)frame imageNormalState:(UIImage *)imageNormal imageHighlightState:(UIImage *)imageHighlight{
    UIButton * button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:imageNormal forState:UIControlStateNormal];
    [button setBackgroundImage:imageHighlight forState:UIControlStateHighlighted];
    return button;
}

+ (UIButton *)initWithFrame:(CGRect)frame imageNormalState:(UIImage *)imageNormal imageHighlightState:(UIImage *)imageHighlight andButtonTag:(NSInteger)tag{
    UIButton * button = [UIButton initWithFrame:frame imageNormalState:imageNormal imageHighlightState:imageHighlight];
    button.tag = tag;
    return button;
}

+ (UIButton *)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)controlEvents imageNormalState:(UIImage *)imageNormal imageHighlightState:(UIImage *)imageHighlight andButtonTag:(NSInteger)tag{
    UIButton * button = [UIButton initWithFrame:frame imageNormalState:imageNormal imageHighlightState:imageHighlight];
    [button addTarget:target action:selector forControlEvents:controlEvents];
    button.tag = tag;
    return button;
}

+ (UIButton *)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)selector withTag:(NSInteger)tag forControlEvents:(UIControlEvents)controlEvents title:(NSString *)title titleNormalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor{
    UIButton * button = [[UIButton alloc] initWithFrame:frame];
    [button setTag:tag];
    [button addTarget:target action:selector forControlEvents:controlEvents];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectColor forState:UIControlStateSelected];
    return button;
}

+ (UIButton *)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)controlEvents image:(UIImage *)image imageEdgeInsets:(UIEdgeInsets)imageInset titleEdgeInsets:(UIEdgeInsets)titleInset title:(NSString *)title titleColor:(UIColor *)color andButtonTag:(NSInteger)tag{
    UIButton * button = [[UIButton alloc] initWithFrame:frame];
    [button setTag:tag];
    [button addTarget:target action:selector forControlEvents:controlEvents];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setImageEdgeInsets:imageInset];
    [button setTitleEdgeInsets:titleInset];
    return button;
}

+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)color font:(UIFont *)font{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textAlignment = alignment;
    label.textColor = color;
    label.font = font;
    return label;
}

+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)color font:(UIFont *)font cornerRadius:(CGFloat)radius{
    UILabel * label = [UILabel initWithFrame:frame text:text textAlignment:alignment textColor:color font:font];
    label.layer.cornerRadius = radius;
    label.clipsToBounds = YES;
    return label;
}

+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)color backgroundColor:(UIColor *)background alpha:(CGFloat)alpha font:(UIFont *)font cornerRadius:(CGFloat)radius addTarget:(id)target clickAction:(SEL)action{
    UILabel * label = [UILabel initWithFrame:frame text:text textAlignment:alignment textColor:color font:font];
    label.layer.cornerRadius = radius;
    label.alpha = alpha;
    label.backgroundColor = background;
    label.clipsToBounds = YES;
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [label addGestureRecognizer:tap];
    return label;
}

@end
