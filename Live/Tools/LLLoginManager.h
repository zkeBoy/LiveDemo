//
//  LLLoginManager.h
//  Live
//
//  Created by MliBo on 2017/9/14.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLLoginManager : NSObject
+ (void)firstInstall;
+ (BOOL)isFirstInsatll;

+ (void)login;
+ (BOOL)isLogin;
+ (void)logOut;
@end
