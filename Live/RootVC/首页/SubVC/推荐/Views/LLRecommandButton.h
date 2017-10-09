//
//  LLRecommandButton.h
//  Live
//
//  Created by MliBo on 2017/8/28.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickTapGestureBlock)();

@interface LLRecommandButton : UIView

+ (instancetype)initWithFrame:(CGRect)frame
                        image:(NSString *)imageName
                        title:(NSString *)title
                     tapBlock:(clickTapGestureBlock)block;
@end
