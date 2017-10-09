//
//  LLPersonCellView.h
//  Live
//
//  Created by MliBo on 2017/9/20.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPersonSectionManager.h"
@class LLPersonNormalRow;

@interface LLPersonCellView : UITableViewCell
@property (nonatomic, strong) LLPersonNormalRow * item;
@end
