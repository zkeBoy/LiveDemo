//
//  LLZKCommandDefine.h
//  Live
//
//  Created by MliBo on 2017/8/10.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#ifndef LLZKCommandDefine_h
#define LLZKCommandDefine_h

#define D_WIDTH  [UIScreen mainScreen].bounds.size.width
#define D_HEIGHT [UIScreen mainScreen].bounds.size.height
#define scale(s) ((D_HEIGHT/736)*s)
#define CellSpace 6                      //cell 之间的间距
#define N_C_W    (D_WIDTH-3*CellSpace)/2 //普通Cell width  (Normal Cell Width)
#define N_C_H    180                     //普通Cell height (Normal Cell Height)
#define MainColor [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]
#define TabBar 49
#define NavBar 64

#endif /* LLZKCommandDefine_h */
