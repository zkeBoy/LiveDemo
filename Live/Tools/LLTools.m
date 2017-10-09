//
//  LLTools.m
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLTools.h"

#define LLUserDefaults [NSUserDefaults standardUserDefaults]

@implementation LLTools

+ (LLTools *)shareTools{
    static LLTools * tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[LLTools alloc] init];
    });
    return tools;
}

+ (UIViewController *)getCurrentViewController{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}

+ (UIViewController *)getViewControllerByClass:(Class)class{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController * currentVC = keyWindow.rootViewController;
    while (currentVC.presentedViewController) {
        currentVC = currentVC.presentedViewController;
        if ([currentVC isKindOfClass:class]) {
            return currentVC;
        }
    }
    return currentVC;
}

+ (void)setObject:(id)object key:(NSString *)key{
    [LLUserDefaults setObject:object forKey:key];
    [LLUserDefaults synchronize];
}

+ (id)getObjectByKey:(NSString *)key{
    id object = [LLUserDefaults objectForKey:key];
    [LLUserDefaults synchronize];
    return object;
}

+ (void)removeObjAccordingByKey:(NSString *)key{
    [LLUserDefaults removeObjectForKey:key];
    [LLUserDefaults synchronize];
}

@end
