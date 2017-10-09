//
//  LLHeaderTopView.h
//  Live
//
//  Created by MliBo on 2017/9/19.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, topViewType) {
    topViewTypeSetting  = 1, //设置
    topViewTypeRegister = 2, //注册
    topViewTypeLogin    = 3, //登陆
    topViewTypeIcon     = 4, //头像
    topViewTypeHistory  = 5, //历史记录
    topViewTypeUMessage = 6, //用户签名
    topViewTypeOther    = 10 //其他
};

@protocol LLPersonHeaderTopViewDelegate <NSObject>

@optional
- (void)clickHeaderTopViewWithType:(topViewType)type;               

@end

@interface LLHeaderTopView : UIView
@property (nonatomic, weak) id <LLPersonHeaderTopViewDelegate> delegate;
@end
