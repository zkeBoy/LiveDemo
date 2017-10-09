//
//  LLRecommendHeadView.m
//  Live
//
//  Created by MliBo on 2017/8/23.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLRecommandHeadBottomView.h"
#import "LLRecommendHeadView.h"
#import <XRCarouselView.h>
#import "LLAdModel.h"
@interface LLRecommendHeadView () <XRCarouselViewDelegate, LLRecommandHeadBottomViewActionDelegate>
@property (nonatomic, copy)   LLClickBlock     clickBlock;
@property (nonatomic, strong) XRCarouselView * scrollView;
@property (nonatomic, strong) NSMutableArray * imageArrays; //广告图片
@property (nonatomic, strong) NSMutableArray * linkArrays;  //广告链接
@property (nonatomic, strong) LLRecommandHeadBottomView * bottomView;
@end

@implementation LLRecommendHeadView

+ (instancetype)headwithFrame:(CGRect)frame andClickBlock:(LLClickBlock)clickBlock {
    LLRecommendHeadView * headView = [[LLRecommendHeadView alloc] initWithFrame:frame];
    if (clickBlock) headView.clickBlock = clickBlock;
    return headView;
}

+ (instancetype)headWithClickBlock:(LLClickBlock)clickBlock{
    LLRecommendHeadView * headView = [[LLRecommendHeadView alloc] init];
    if (clickBlock) headView.clickBlock = clickBlock;
    return headView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArrays = [NSMutableArray array];
        self.linkArrays  = [NSMutableArray array];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(0);
        make.width.mas_equalTo(D_WIDTH);
        make.height.mas_equalTo(scale(128));
    }];
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).offset(0);
        make.left.width.equalTo(self.scrollView);
        make.height.mas_equalTo(scale(80));
    }];
}

- (void)setAdArrays:(NSArray *)adArrays{
    [self.imageArrays removeAllObjects];
    [self.linkArrays removeAllObjects];
    for (LLAdModel * ad in adArrays) {
        NSString * imageUrl = ad.imageUrl;
        NSString * link     = ad.link;
        [self.imageArrays addObject:imageUrl];
        [self.linkArrays addObject:link];
    }
    NSArray * ads = [self.imageArrays mutableCopy]; //防止循环引用
    self.scrollView.imageArray = ads;
}

#pragma mark - lazy init
- (XRCarouselView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[XRCarouselView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagePosition = PositionBottomRight;
        _scrollView.time = 1.5;
        [_scrollView setPageColor:[UIColor grayColor] andCurrentPageColor:[UIColor redColor]];
    }
    return _scrollView;
}

- (LLRecommandHeadBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[LLRecommandHeadBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

#pragma mark - XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{
    NSString * linkURL = self.linkArrays[index];
    if (self.clickBlock) {
        if (index<self.imageArrays.count) {
            self.clickBlock(clickTypeScro, linkURL);
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(headViewClickWithType:linkURL:)]) {
            [self.delegate headViewClickWithType:clickTypeScro linkURL:linkURL];
        }
    }
}

#pragma mark - LLRecommandHeadBottomViewActionDelegate
- (void)recommandHeadBottomClickButtonType:(eventType)type {
    if (self.clickBlock) {
        self.clickBlock((clickType)type, @"");
    }else{
        if ([self.delegate respondsToSelector:@selector(headViewClickWithType:linkURL:)]) {
            [self.delegate headViewClickWithType:clickTypeScro linkURL:@""];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
