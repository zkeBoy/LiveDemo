//
//  LLMainViewController.m
//  Live
//
//  Created by YellowBoy on 2017/7/29.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLMainViewController.h"
#import "LLHomeViewController.h"
#import "LLNearViewController.h"
#import "LLLiveViewController.h"
#import "LLNewViewController.h"
#import "LLPersonViewController.h"
#import "LLNavigationController.h"
#import "LLTabBar.h"
#import "YZMyInformationVC.h"

@interface LLMainViewController ()<LLTabBarDelegate,UITabBarControllerDelegate,LLNaviagationControllerBarButtonDelegate>
@property (nonatomic, strong) NSArray * classNames;
@end

@implementation LLMainViewController
    
- (instancetype)init{
    self = [super init];
    if (self) {
        [self addNotifications];
        [self initTabItems];
    }
    return self;
}

- (void)addNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut) name:NSNotificationTokenDisableErrorKey object:nil];
}

- (void)remoNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectedIndex = 0;
    self.delegate = self;
}

#pragma mark - 初始化ViewController
- (void)initTabItems{
    NSArray * titles       = @[@"首页",@"最新",@"",@"附近",@"个人"];
    NSArray * images       = @[@"toolbar_home",@"",@"toolbar_live",@"",@"toolbar_me"];
    NSArray * selectImages = @[@"toolbar_home_sel",@"",@"",@"",@"toolbar_me_sel"];
    NSMutableArray * viewControllers = [NSMutableArray arrayWithCapacity:5];
    for (int index = 0; index<self.classNames.count; index++) {
        NSString * className = [self.classNames objectAtIndex:index];
        NSString * title = [titles objectAtIndex:index];
        UIImage * normal = [UIImage imageNamed:images[index]];
        UIImage * select = [UIImage imageNamed:selectImages[index]];
        if (index == 0) {
            
            UIViewController * viewController = (UIViewController *)[[NSClassFromString(className) alloc] init];
            LLNavigationController * nav = [[LLNavigationController alloc]
                                            initNavigationControllerWithRootViewController:viewController
                                            andNavigationBarImage:[UIImage imageNamed:@"navBar_bg_414x70"]];
            nav.LL_delegate = self;
            nav.tabBarItem.title = title;
            nav.tabBarItem.image = normal;
            nav.tabBarItem.selectedImage = select;
            NSDictionary * normal = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
            NSDictionary * select = @{NSForegroundColorAttributeName:[UIColor purpleColor]};
            [nav.tabBarItem setTitleTextAttributes:normal forState:UIControlStateNormal];
            [nav.tabBarItem setTitleTextAttributes:select forState:UIControlStateSelected];
            [viewControllers addObject:nav];
             
        }else if(((self.classNames.count-1)/2==index)&&(self.classNames.count%2!=0)){ //中间那位
            UINavigationController * nav = (UINavigationController *)[self initViewControllerWithName:className title:title andItemImage:normal selectImage:nil];
            nav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            [viewControllers addObject:nav];
        }else{
            UINavigationController * nav = (UINavigationController *)[self initViewControllerWithName:className title:title andItemImage:normal selectImage:select];
            [viewControllers addObject:nav];
        }
    }
    self.viewControllers = viewControllers;
    /*去掉黑线*/
    //[self.tabBar setShadowImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    //[self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
}
    
#pragma mark - 设置自定义的TabBar
- (void)setUpCustomTabBar{
    LLTabBar * tabBar = [[LLTabBar alloc] initTabBarButtonStateNormal:@"toolbar_live"
                                                       stateHighlight:@""
                                                     tabBarItemNumber:self.classNames.count];
    tabBar.delegate_ = self;
    [self setValue:tabBar forKey:@"tabBar"];
}
    
#pragma mark - LLTabBarDelegate
- (void)didClickCenterView{
    NSLog(@"ssss");
    NSInteger index = (self.classNames.count-1)/2;
    self.selectedIndex = index;
}

#pragma mark - 私有方法
- (id)initViewControllerWithName:(NSString *)className title:(NSString *)title andItemImage:(UIImage *)image selectImage:(UIImage *)selectImage{
    UIViewController * viewController = (UIViewController *)[[NSClassFromString(className) alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = selectImage;
    NSDictionary * normal = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
    NSDictionary * select = @{NSForegroundColorAttributeName:[UIColor purpleColor]};
    [nav.tabBarItem setTitleTextAttributes:normal forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:select forState:UIControlStateSelected];
    return (id)nav;
}

- (NSArray *)classNames{
    if (!_classNames) {
        self.classNames = @[@"LLHomeViewController",
                            @"LLNewViewController",
                            @"LLLiveViewController",
                            @"LLNearViewController",
                            @"YZMyInformationVC"];
    }
    return _classNames;
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
    if(viewController == [tabBarController.viewControllers objectAtIndex:2]){
        UINavigationController * nav = (UINavigationController *)[self initViewControllerWithName:@"LLLiveViewController" title:nil andItemImage:nil selectImage:nil];
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    return YES;
}

#pragma mark - LLNaviagationControllerBarButtonDelegate
- (void)navigationBarButton:(UIButton *)button didSelectItme:(ButtonTagType)item{
    if (item==ButtonTagLeft) {
        [self logOut];
    }
}

#pragma mark - LogOut
- (void)logOut{
    [self remoNotifications];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%@",@"LLMainViewController dealloc !!!!!!");
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
