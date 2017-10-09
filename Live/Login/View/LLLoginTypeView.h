//
//  LLLoginTypeView.h
//  Live
//
//  Created by MliBo on 2017/8/10.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, loginType) {
    loginTypeWeiChat = 0, //微信
    loginTypeQQ      = 1, //QQ
    loginTypeWeiBo   = 2, //微博
    loginTypeOther   = 3  //其他
};

@interface LLLoginTypeView : UIView
@property (nonatomic, copy) void (^clickActionBlock)(loginType);
@end
