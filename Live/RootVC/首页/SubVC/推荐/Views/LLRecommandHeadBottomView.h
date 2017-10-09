//
//  LLRecommandHeadBottomView.h
//  Live
//
//  Created by MliBo on 2017/8/28.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, eventType) {
    eventTypeOne   = 1,
    eventTypeTwo   = 2,
    eventTypeThree = 3,
    eventTypeFour  = 4
};

@protocol LLRecommandHeadBottomViewActionDelegate <NSObject>
@required
- (void)recommandHeadBottomClickButtonType:(eventType)type;

@end

@interface LLRecommandHeadBottomView : UIView
@property (weak, nonatomic) id <LLRecommandHeadBottomViewActionDelegate> delegate;

@end
