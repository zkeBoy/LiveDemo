//
//  LLTools.h
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLTools : NSObject
+ (UIViewController *)getCurrentViewController;
+ (UIViewController *)getViewControllerByClass:(Class)class;
+ (void)setObject:(id)object key:(NSString *)key;
+ (id)getObjectByKey:(NSString *)key;
+ (void)removeObjAccordingByKey:(NSString *)key;
@end
