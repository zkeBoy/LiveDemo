//
//  LLRecommendHeadView.h
//  Live
//
//  Created by MliBo on 2017/8/23.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, clickType) {
    clickTypeScro  = 0,
    clickTypeOne   = 1,
    clickTypeTwo   = 2,
    clickTypeThree = 3,
    clickTypeFour  = 4
};

typedef void(^LLClickBlock)(clickType, NSString * linkURL);

@protocol LLRecommendHeadViewDelegate <NSObject>

@optional
- (void)headViewClickWithType:(clickType)type linkURL:(NSString *)link;

@end

@interface LLRecommendHeadView : UIView

+ (instancetype)headwithFrame:(CGRect)frame andClickBlock:(LLClickBlock)clickBlock;
+ (instancetype)headWithClickBlock:(LLClickBlock)clickBlock;
- (void)setAdArrays:(NSArray *)adArrays;


/**
 * 代理与block 二者选一, block优先级大于代理
 */
@property (nonatomic, strong) id <LLRecommendHeadViewDelegate> delegate;

@end
