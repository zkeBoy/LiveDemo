//
//  LLNavigationController.m
//  Live
//
//  Created by YellowBoy on 2017/8/3.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLNavigationController.h"
#import "LLSearchBar.h"

@interface LLNavigationController ()<UINavigationControllerDelegate>
/********************首页的NavigationController*********************/
@property (nonatomic, strong) UIColor * barColor;
@property (nonatomic, strong) UIImage * barBackgroundImage;
@property (nonatomic, assign) initType  type;
/********************首页的NavigationController*********************/
    
@end

@implementation LLNavigationController
#pragma mark -
- (LLNavigationController *)initNavigationControllerWithRootViewController:(UIViewController *)rootViewController andNavigationBarColor:(UIColor *)color andInitType:(initType)type{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate = self;
        self.barColor = color;
        self.type = type;
    }
    return self;
}

- (LLNavigationController *)initNavigationControllerWithRootViewController:(UIViewController *)rootViewController andNavigationBarColor:(UIColor *)color{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate = self;
        self.barColor = color;
        self.type     = initTypeHome;
    }
    return self;
}

- (LLNavigationController *)initNavigationControllerWithRootViewController:(UIViewController *)rootViewController andNavigationBarImage:(UIImage *)image{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate           = self;
        self.barBackgroundImage = image;
        self.type     = initTypeHome;
    }
    return self;
}
    
#pragma mark - UINavigationControllerDelegate Method
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.type==initTypeDefault) {
        
    }else if (self.type==initTypeHome){
        NSArray * subVCs = self.viewControllers;
        if ([viewController isKindOfClass:[subVCs[0] class]]) { //rootViewController
            [self setShowViewController:viewController];
        }
    }
}
 
//Push的时候做一些特别的处理
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES; //跳转页面时隐藏TabBar
    }
    [super pushViewController:viewController animated:animated];
}

    
- (void)setShowViewController:(UIViewController *)viewController{
    
    CGRect frame = CGRectMake(0, 0, 60, 30);
    UIButton * leftBarButton = [UIButton initWithFrame:frame
                                             addTarget:self
                                                action:@selector(touchUpInsideOfButtonAction:)
                                      forControlEvents:UIControlEventTouchUpInside
                                      imageNormalState:[UIImage imageWithColor:[UIColor orangeColor]]
                                   imageHighlightState:[UIImage imageWithColor:[UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:0.8]]
                                          andButtonTag:ButtonTagLeft];
    leftBarButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    
    
    frame = CGRectMake(0, 0, 200, 30);
    LLSearchBar * searchView = [[LLSearchBar alloc] initWithFrame:frame];
    
    
    frame = CGRectMake(0, 0, 30, 30);
    UIButton * gameButton = [UIButton initWithFrame:frame
                                          addTarget:self
                                             action:@selector(touchUpInsideOfButtonAction:)
                                   forControlEvents:UIControlEventTouchUpInside
                                   imageNormalState:[UIImage imageWithColor:[UIColor grayColor]]
                                imageHighlightState:[UIImage imageWithColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.8]]
                                       andButtonTag:ButtonTagLeftRight];
    gameButton.backgroundColor = [UIColor greenColor];
    UIBarButtonItem * right1 = [[UIBarButtonItem alloc] initWithCustomView:gameButton];
    
    
    frame = CGRectMake(0, 0, 30, 30);
    UIButton * rightBarButton = [UIButton initWithFrame:frame
                                              addTarget:self
                                                 action:@selector(touchUpInsideOfButtonAction:)
                                       forControlEvents:UIControlEventTouchUpInside
                                       imageNormalState:[UIImage imageWithColor:[UIColor redColor]]
                                    imageHighlightState:[UIImage imageWithColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.8]]
                                           andButtonTag:ButtonTagRight];
    rightBarButton.backgroundColor = [UIColor purpleColor];
    UIBarButtonItem * right2 = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    
    
    viewController.navigationItem.leftBarButtonItem = left;
    viewController.navigationItem.titleView = searchView;
    viewController.navigationItem.rightBarButtonItems = @[right2, right1];
    UIImage * barImage;
    if (self.barColor) {
        barImage = [UIImage imageWithColor:self.barColor];
    }else{
        barImage = self.barBackgroundImage;
    }
    [viewController.navigationController.navigationBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    
    //设置分割线颜色
    //[viewController.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor blackColor]]];
    //[viewController.navigationController.navigationBar setClipsToBounds:YES]; //隐藏分割线
}
    
#pragma mark - Private Method
- (void)touchUpInsideOfButtonAction:(UIButton *)sender{
    NSInteger buttonTag = sender.tag;
    if (buttonTag == ButtonTagLeft) {
        if ([self.LL_delegate respondsToSelector:@selector(navigationBarButton:didSelectItme:)]) {
            [self.LL_delegate navigationBarButton:sender didSelectItme:ButtonTagLeft];
        }
    }else if (buttonTag == ButtonTagLeftRight){
        if ([self.LL_delegate respondsToSelector:@selector(navigationBarButton:didSelectItme:)]) {
            [self.LL_delegate navigationBarButton:sender didSelectItme:ButtonTagLeftRight];
        }
    }else if (buttonTag == ButtonTagRight){
        if ([self.LL_delegate respondsToSelector:@selector(navigationBarButton:didSelectItme:)]) {
            [self.LL_delegate navigationBarButton:sender didSelectItme:ButtonTagRight];
        }
    }
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
