//
//  LLPersonSectionManager.m
//  Live
//
//  Created by MliBo on 2017/9/20.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLPersonSectionManager.h"

@interface LLPersonSectionManager ()

@end

@implementation LLPersonSectionManager

+ (LLPersonSectionManager *)shareManager {
    static LLPersonSectionManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LLPersonSectionManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.sections = [[NSMutableArray alloc] init];
        [self appendSection];
    }
    return self;
}

- (void)appendSection{
    LLPersonNormalRow * rows1_1 = [[LLPersonNormalRow alloc] initWithIcon:@"" title:@"个人信息" detailTitle:@"未完善" type:cellTypeDefault];
    LLPersonNormalRow * rows1_2 = [[LLPersonNormalRow alloc] initWithIcon:@"" title:@"我的空间" detailTitle:@"" type:cellTypeDefault];
    LLPersonNormalRow * rows1_3 = [[LLPersonNormalRow alloc] initWithIcon:@"" title:@"我的粉丝" detailTitle:@"" type:cellTypeDefault];
    NSArray * section1 = @[rows1_1,rows1_2,rows1_3];
    
    LLPersonNormalRow * rows2_1 = [[LLPersonNormalRow alloc] initWithIcon:@"icon_level_setting" title:@"我的等级" detailTitle:@"" type:cellTypeDefault];
    LLPersonNormalRow * rows2_2 = [[LLPersonNormalRow alloc] initWithIcon:@"" title:@"游戏中心" detailTitle:@"" type:cellTypeDefault];
    LLPersonNormalRow * rows2_3 = [[LLPersonNormalRow alloc] initWithIcon:@"" title:@"排行榜" detailTitle:@"" type:cellTypeDefault];
    NSArray * section2 = @[rows2_1,rows2_2,rows2_3];
    
    LLPersonNormalRow * rows3_1 = [[LLPersonNormalRow alloc] initWithIcon:@"" title:@"我的视频" detailTitle:@"" type:cellTypeDefault];
    LLPersonNormalRow * rows3_2 = [[LLPersonNormalRow alloc] initWithIcon:@"" title:@"我的收藏" detailTitle:@"" type:cellTypeDefault];
    NSArray * section3 = @[rows3_1,rows3_2];
    
    LLPersonNormalRow * rows4_1 = [[LLPersonNormalRow alloc] initWithIcon:@"icon_privacy_setting" title:@"隐私政策" detailTitle:@"" type:cellTypeDefault];
    LLPersonNormalRow * rows4_2 = [[LLPersonNormalRow alloc] initWithIcon:@"icon_star_setting" title:@"赏个好评" detailTitle:@"" type:cellTypeDefault];
    NSArray * section4 = @[rows4_1,rows4_2];
    
    LLPersonNormalRow * rows5_1 = [[LLPersonNormalRow alloc] initWithIcon:@"" title:@"设置" detailTitle:@"" type:cellTypeDefault];
    NSArray * section5 = @[rows5_1];
    
    [self.sections addObjectsFromArray:@[section1,section2,section3,section4,section5]];
}

- (NSMutableArray *)sections {
    return _sections;
}

@end

@implementation LLPersonNormalRow

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title detailTitle:(NSString *)detailTitle type:(cellType)type{
    self = [super init];
    if (self) {
        _icon        = icon;
        _title       = title;
        _detailTitle = detailTitle;
        _type        = type;
    }
    return self;
}

@end
