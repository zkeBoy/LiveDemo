//
//  UIView+Draw.m
//  Live
//
//  Created by MliBo on 2017/9/1.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "UIImage+Draw.h"

@implementation UIImage (Draw)

//第一个参数表示所要创建的图片的尺寸;
//第二个参数用来指定所生成图片的背景是否为不透明，如上我们使用YES而不是NO，则我们得到的图片背景将会是黑色，显然这不是我想要的;
//第三个参数指定生成图片的缩放因子，这个缩放因子与UIImage的scale属性所指的含义是一致的。
//UIGraphicsBeginImageContextWithOptions(size, NO, 0);
+ (UIImage *)drawEyesImageWithSize:(CGSize)size{
    CGFloat w = size.width;
    CGFloat h = size.height;
    if (w<0||h<0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGPoint center = CGPointMake(w/2, h/2);
    UIBezierPath * eye = [UIBezierPath bezierPathWithArcCenter:center radius:w*0.2 startAngle:(0/180.0)*M_PI endAngle:(360.0/180.0)*M_PI clockwise:YES];
    //上半圆弧加中心圆
    /*
     moveToPoint:(开始点) startPoint
     addCurveToPoint/addQuadCurveToPoint:(结束点)endPoint 
     controlPoint:控制点
     */
    CGPoint startPoint = CGPointMake(0, h/2);
    CGPoint endPoint = CGPointMake(w, h/2);
    CGPoint upControlPoint = CGPointMake(w/2, 0-2); //上半控制点
    CGPoint boControlPoint = CGPointMake(w/2, h+2); //下半控制点
    [eye moveToPoint:startPoint];
    [eye addQuadCurveToPoint:endPoint controlPoint:upControlPoint];
    [[UIColor whiteColor] setStroke]; //边框颜色
    [[UIColor clearColor] setFill];  //填充颜色
    [eye stroke];
    [eye fill];
    //下半圆弧
    UIBezierPath * bottom = [UIBezierPath bezierPath];
    [bottom moveToPoint:startPoint];
    [bottom addQuadCurveToPoint:endPoint controlPoint:boControlPoint];
    [[UIColor whiteColor] setStroke]; //边框颜色
    [[UIColor clearColor] setFill];  //填充颜色
    [bottom stroke];
    [bottom fill];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
