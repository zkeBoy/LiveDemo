//
//  LLNavigationController.h
//  Live
//
//  Created by YellowBoy on 2017/8/3.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonTagType) {
    ButtonTagLeft        = 0, //最左边
    ButtonTagLeftRight   = 1, //最右边的左边
    ButtonTagRight       = 2  //最右边
};

typedef NS_ENUM(NSInteger, initType) {
    initTypeDefault = 0, //默认
    initTypeHome    = 1  //首页
};

//点击BarButton的代理方法
@protocol LLNaviagationControllerBarButtonDelegate <NSObject>
@required
- (void)navigationBarButton:(UIButton *)button didSelectItme:(ButtonTagType)item;
@end

//根据需求自定义Nav
@interface LLNavigationController : UINavigationController
@property (nonatomic, weak) id <LLNaviagationControllerBarButtonDelegate> LL_delegate;
- (LLNavigationController *)initNavigationControllerWithRootViewController:(UIViewController *)rootViewController andNavigationBarColor:(UIColor *)color andInitType:(initType)type;
    
- (LLNavigationController *)initNavigationControllerWithRootViewController:(UIViewController *)rootViewController andNavigationBarColor:(UIColor *)color;

- (LLNavigationController *)initNavigationControllerWithRootViewController:(UIViewController *)rootViewController andNavigationBarImage:(UIImage *)image;

@end
