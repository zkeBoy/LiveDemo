//
//  LLPersonHeaderView.h
//  Live
//
//  Created by MliBo on 2017/9/19.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLHeaderTopView.h"
#import "LLHeaderBottomView.h"

@protocol LLPersonHeaderViewDelegate <NSObject>

@optional
- (void)didClickHeaderTopViewWithType:(topViewType)type;
- (void)didClickHeaderBottonViewWithTag:(NSInteger)tag;

@end

@interface LLPersonHeaderView : UIView
@property (nonatomic, weak) id <LLPersonHeaderViewDelegate> delegate;
+ (instancetype)headerWithFrame:(CGRect)frame andDelegate:(id)weak;
@end
