//
//  LLPersonSectionManager.h
//  Live
//
//  Created by MliBo on 2017/9/20.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, cellType) {
    cellTypeDefault      = 0, //默认
    cellTypePersonalInfo = 1, //个人信息
    cellTypeGame         = 2 //游戏
};

@class LLPersonNormalRow;
@interface LLPersonSectionManager : NSObject
@property (nonatomic, strong) NSMutableArray * sections;
+ (LLPersonSectionManager *)shareManager;
@end

@interface LLPersonNormalRow : NSObject
@property (nonatomic, copy)   NSString * icon;
@property (nonatomic, copy)   NSString * title;
@property (nonatomic, copy)   NSString * detailTitle;
@property (nonatomic, assign) cellType type;
- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title detailTitle:(NSString *)detailTitle type:(cellType)type;
@end
