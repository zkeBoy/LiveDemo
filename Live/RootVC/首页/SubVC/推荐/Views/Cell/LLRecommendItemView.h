//
//  LLRecommendItemView.h
//  Live
//
//  Created by MliBo on 2017/9/1.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLRecommendItemViewDelegate <NSObject>

@optional
- (void)touchItemViewUpInsideEvent;
- (void)touchItemViewUpInsideWithLinkString:(NSString *)linkString; //返回点击的连接

@end

@interface LLRecommendItemView : UIView
@property (nonatomic, weak) id <LLRecommendItemViewDelegate> delegate;
@property (nonatomic, strong) LLLivePerson * liveData; //直播相关信息
@end
