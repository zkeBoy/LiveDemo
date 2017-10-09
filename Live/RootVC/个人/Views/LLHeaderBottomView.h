//
//  LLHeaderBottomView.h
//  Live
//
//  Created by MliBo on 2017/9/19.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLHeaderBottomItem;
@protocol LLPersonHeaderBottomViewDelegate <NSObject>

@optional
- (void)didClickButtonWithTag:(NSInteger)tag;

@end

@interface LLHeaderBottomView : UIView
@property (nonatomic, weak) id <LLPersonHeaderBottomViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame withItems:(NSArray <LLHeaderBottomItem *> *)array;
@end

@interface LLHeaderBottomItem : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * imageName;

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName;
@end
