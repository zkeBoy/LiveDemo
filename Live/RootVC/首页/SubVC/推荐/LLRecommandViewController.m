//
//  LLRecommandViewController.m
//  Live
//
//  Created by MliBo on 2017/8/31.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLRecommandViewController.h"
#import "LLLivePersonManager.h"
#import "ZKRefreshGifHeader.h"
#import "LLRecommendHeadView.h"
#import "DMCCollectionViewLayout.h"
#import "LLRecommendCell.h"

#define H_H 208       //head height

#define C_W D_WIDTH/2-20 //item width
#define C_H 120       //item height

@interface LLRecommandViewController ()<UICollectionViewDelegateFlowLayout,LLRecommendHeadViewDelegate>
@property (nonatomic, strong) LLRecommendHeadView * headView;
@property (nonatomic, strong) NSMutableArray * lives; //直播
@end

@implementation LLRecommandViewController

static NSString * const reuseIdentifier = @"CellView";
static NSString * const headIdentifier  = @"HeaderView";

- (instancetype)init {
    return [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    [self setUI];
}

- (void)setUI{
    //注册头
    [self.collectionView registerClass:[LLRecommendHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
    //注册Cell
    [self.collectionView registerClass:[LLRecommendCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //add Refresh
    self.collectionView.mj_header = [ZKRefreshGifHeader headerWithRefreshingBlock:^{
        [self getLivePersonList];
        [self getAdList];
    }];
    [self.collectionView.mj_header beginRefreshing];
    
    UICollectionViewFlowLayout * FlowLayout = [[UICollectionViewFlowLayout alloc] init];
    FlowLayout.minimumLineSpacing = 10;//列最小间距
    FlowLayout.minimumInteritemSpacing = 20;//行最小间距
    FlowLayout.itemSize = CGSizeMake(C_W, C_H);//item 尺寸
    FlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//内边距
    FlowLayout.headerReferenceSize = CGSizeMake(D_WIDTH, H_H); //头size
    self.collectionView.collectionViewLayout = FlowLayout;
}

- (void)getLivePersonList{
    [[LLLivePersonManager livePersonManager] refleshRequestWithResponse:^(NSArray * lives) {
        [self.collectionView.mj_header endRefreshing];
        [self.lives removeAllObjects];
        [self.lives addObjectsFromArray:lives];
    }];
}

- (void)getAdList{
    [[LLLivePersonManager livePersonManager] requestAdListWithResponse:^(NSArray * ads) {
        [self.headView setAdArrays:ads];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //有几个Section 分组
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //每个Section 有几个item
    return 4;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{//定义每个Section的四边间距
    return UIEdgeInsetsMake(10, 0, 10, 0);//分别为上、左、下、右
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{//绘制头和尾
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader){
        self.headView = (LLRecommendHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier forIndexPath:indexPath];
        self.headView.delegate = self;
        reusableView = self.headView;
    }
    return reusableView;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark <LLRecommendHeadViewDelegate>
- (void)headViewClickWithType:(clickType)type linkURL:(NSString *)link{

}


@end
