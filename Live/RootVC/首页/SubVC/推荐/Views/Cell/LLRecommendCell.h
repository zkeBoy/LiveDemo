//
//  LLRecommendCell.h
//  Live
//
//  Created by MliBo on 2017/8/31.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define S_H 40 //(section header height)

@interface LLRecommendCell : UITableViewCell
@property (nonatomic, strong) NSArray * items;
@property (nonatomic, assign) BOOL      load; //是否已经加载过
//更新数据
- (void)reloadData:(NSArray *)items;
@end
