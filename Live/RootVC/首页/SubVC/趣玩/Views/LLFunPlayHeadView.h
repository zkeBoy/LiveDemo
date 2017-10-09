//
//  LLFunPlayHeadView.h
//  Live
//
//  Created by MliBo on 2017/9/15.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBlock)();

@interface LLFunPlayHeadView : UIView
+ (instancetype)headWithFrame:(CGRect)frame click:(clickBlock)block;
@end
