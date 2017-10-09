//
//  UIImage+Color.h
//  Live
//
//  Created by YellowBoy on 2017/8/5.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color withRect:(CGRect)rect;
@end
