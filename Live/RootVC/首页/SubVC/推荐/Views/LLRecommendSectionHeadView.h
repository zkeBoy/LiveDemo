//
//  LLRecommendSectionHeadView.h
//  Live
//
//  Created by MliBo on 2017/8/31.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickMoreBlock) ();
@interface LLRecommendSectionHeadView : UIView
@property (nonatomic, copy) clickMoreBlock clickMoreAction;
@end
