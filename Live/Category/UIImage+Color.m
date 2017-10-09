//
//  UIImage+Color.m
//  Live
//
//  Created by YellowBoy on 2017/8/5.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, color.CGColor);
    CGContextFillRect(contextRef, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color withRect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, color.CGColor);
    CGContextFillRect(contextRef, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
    
@end
