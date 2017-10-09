//
//  LLLoginManager.m
//  Live
//
//  Created by MliBo on 2017/9/14.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLLoginManager.h"

@implementation LLLoginManager

+ (void)firstInstall{
    BOOL install = YES;
    [LLTools setObject:@(install) key:FirstInstallKey];
}

+ (BOOL)isFirstInsatll{
    BOOL firstInstall = [LLTools getObjectByKey:FirstInstallKey];
    return firstInstall;
}

+ (void)login{
    BOOL login = YES;
    [LLTools setObject:@(login) key:LoginSuccessKey];
}

+ (BOOL)isLogin{
    BOOL login = [LLTools getObjectByKey:LoginSuccessKey];
    return login;
}

+ (void)logOut{
    [LLTools removeObjAccordingByKey:LoginSuccessKey];
}
 

@end
