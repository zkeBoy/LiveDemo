//
//  LLFunPlayHeadView.m
//  Live
//
//  Created by MliBo on 2017/9/15.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLFunPlayHeadView.h"
#import "LLFunPlayItemCell.h"
@interface LLFunPlayHeadView ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
@property (nonatomic, copy)   clickBlock _block;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UIPageControl    * pageControl;
@property (nonatomic, strong) NSArray          * itemsArray;
@end

#define C_W D_WIDTH/4
static NSString * const cellIdentifying = @"funPlayCell";

@implementation LLFunPlayHeadView
+ (instancetype)headWithFrame:(CGRect)frame click:(clickBlock)block{
    LLFunPlayHeadView * headView = [[LLFunPlayHeadView alloc] initWithFrame:frame];
    block = headView._block;
    return headView;
}

+ (instancetype)headWithFrame:(CGRect)frame andItems:(NSArray *)array click:(clickBlock)block{
    LLFunPlayHeadView * headView = [[LLFunPlayHeadView alloc] initWithFrame:frame];
    block = headView._block;
    headView.itemsArray = array;
    return headView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self).offset(scale(-20));
    }];
    
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.collectionView.mas_bottom).offset(0);
        make.bottom.equalTo(self);
        make.width.equalTo(self);
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8*2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LLFunPlayItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifying forIndexPath:indexPath];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / D_WIDTH;
    self.pageControl.currentPage = page;
}

#pragma mark - lazy init
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * FlowLayout = [[UICollectionViewFlowLayout alloc] init];
        FlowLayout.minimumLineSpacing = 0;        //列最小间距
        FlowLayout.minimumInteritemSpacing = 0;   //行最小间距
        FlowLayout.itemSize = CGSizeMake(C_W, C_W);//item 尺寸
        FlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//内边距
        FlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //横向滑动
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:FlowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;   //隐藏活动条
        _collectionView.showsHorizontalScrollIndicator = NO; //隐藏活动条
        _collectionView.allowsMultipleSelection=YES;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LLFunPlayItemCell class]) bundle:nil] forCellWithReuseIdentifier:cellIdentifying];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 2;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    return _pageControl;
}

#pragma mark - Outline Method
- (void)reloadData:(NSArray *)items{

}

#pragma mark - Private Method
- (void)cleanCacheMemory{
    if (self.itemsArray) {
        self.itemsArray = nil;
    }
}

- (void)dealloc {
    [self cleanCacheMemory];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
