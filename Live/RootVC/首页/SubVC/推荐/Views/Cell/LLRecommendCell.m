//
//  LLRecommendCell.m
//  Live
//
//  Created by MliBo on 2017/8/31.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLRecommendCell.h"
#import "LLRecommendItemView.h"
#import "LLRecommendSectionHeadView.h"
#import "LLMoreViewController.h"
@interface LLRecommendCell ()<LLRecommendItemViewDelegate>
@property (nonatomic, strong) UIView                     * mainView;
@property (nonatomic, strong) LLRecommendSectionHeadView * sectionHeadView;

@end

@implementation LLRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addUI];
        [self layOutUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone; //点击效果
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addUI];
    [self layOutUI];
}

- (void)addUI{
    [self.contentView addSubview:self.mainView];
    [self.mainView addSubview:self.sectionHeadView];
}

- (void)layOutUI{
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
  
    [self.sectionHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.mainView).offset(0);
        make.height.mas_equalTo(scale(S_H));
    }];
}

- (void)setItems:(NSArray *)items { //重用机制
    self.load = YES;
    _items = items;
    NSInteger count = items.count>0?items.count:4;
    NSInteger addCount = 0;
    for (NSInteger index = 0; index<count; index++) {
        addCount = index/2;
        LLRecommendItemView * itemView = [[LLRecommendItemView alloc] init];
        itemView.delegate = self;
        [self.mainView addSubview:itemView];
        if (index%2==0) { //第一列
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.sectionHeadView.mas_bottom).offset(addCount*scale(N_C_H));
                make.left.equalTo(self.mainView).offset(scale(CellSpace));
                make.width.mas_equalTo(scale(N_C_W));
                make.height.mas_equalTo(scale(N_C_H));
            }];
        }else{ //第二列
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.sectionHeadView.mas_bottom).offset(addCount*scale(N_C_H));
                make.right.equalTo(self.mainView).offset(-scale(CellSpace));
                make.width.mas_equalTo(scale(N_C_W));
                make.height.mas_equalTo(scale(N_C_H));
            }];
        }
        itemView.liveData = items[index];
    }
}

//更新数据
- (void)reloadData:(NSArray *)items{
    NSArray * subViews = self.mainView.subviews; NSInteger index =0;
    for (UIView * view in subViews) {
        if ([view isKindOfClass:[LLRecommendItemView class]]) {
            LLRecommendItemView * itemView = (LLRecommendItemView *)view;
            itemView.liveData = items[index];
            index++;
        }
    }
}

- (BOOL)load {
    return _load;
}

#pragma mark - lazy init
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (LLRecommendSectionHeadView *)sectionHeadView {
    if (!_sectionHeadView) {
        __weak typeof(self)weakSelf = self;
        _sectionHeadView = [[LLRecommendSectionHeadView alloc] init];
        _sectionHeadView.backgroundColor = [UIColor whiteColor];
        _sectionHeadView.clickMoreAction = ^{
            [weakSelf clickSectionHeadView];
        };
    }
    return _sectionHeadView;
}

#pragma mark - Touch Action
- (void)clickSectionHeadView{ //More
    NSLog(@"%s",__func__);
    UIViewController * currentNav = [LLTools getCurrentViewController];
    if ([currentNav isKindOfClass:NSClassFromString(@"LLNavigationController")]) {
        UINavigationController * nav = (UINavigationController *)currentNav;
        UIViewController * currentVC = nav.visibleViewController;
        LLMoreViewController * moreVC = [[LLMoreViewController alloc] init];
        [currentVC.navigationController pushViewController:moreVC animated:YES];
    }
}

//LLRecommendItemViewDelegate
- (void)touchItemViewUpInsideWithLinkString:(NSString *)linkString{
    NSLog(@"%@",linkString);
    UIViewController * currentVC = [LLTools getCurrentViewController];
    LLLivePlayViewController * livePlayVC = [[LLLivePlayViewController alloc] initWithLiveString:linkString];
    [currentVC presentViewController:livePlayVC animated:YES completion:nil];
}

@end
