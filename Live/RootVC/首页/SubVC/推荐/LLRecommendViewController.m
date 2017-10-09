//
//  LLRecommendViewController.m
//  Live
//
//  Created by MliBo on 2017/8/11.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLRecommendViewController.h"
#import "LLLivePersonManager.h"
#import "LLRecommendHeadView.h"
#import "LLRecommendCell.h"
#import "LLLoadViewCell.h"

#define S_H_C [UIColor clearColor] //(Section Header color)
#define T_H 208
static NSString * cellIdentifider = @"LLRecommendCell";

@interface LLRecommendViewController ()
@property (nonatomic, strong) NSMutableArray      * sections; //直播
@property (nonatomic, strong) LLRecommendHeadView * headView;
@property (nonatomic, strong) NSArray             * dataArray;
@end

@implementation LLRecommendViewController
- (instancetype)initWithData:(NSArray *)dataArray{
    self = [super init];
    if (self) {
        self.sections = [NSMutableArray arrayWithArray:dataArray];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    self.view.backgroundColor = MainColor;
}

- (void)setUI{
    self.tableView.mj_header = [ZKRefreshGifHeader headerWithRefreshingBlock:^{
        [self getLivePersonList];
        [self getAdList];
    }];
    [self.tableView registerClass:[LLRecommendCell class] forCellReuseIdentifier:cellIdentifider];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)getLivePersonList{
    [[LLLivePersonManager livePersonManager] refleshRequestWithResponse:^(NSArray * lives) {
        [self.tableView.mj_header endRefreshing];
        [self.sections removeAllObjects];
        [self.sections addObjectsFromArray:lives];
        [self.tableView reloadData];
    }];
}

- (void)getAdList{
    [[LLLivePersonManager livePersonManager] requestAdListWithResponse:^(NSArray * ads) {
        [self.headView setAdArrays:ads];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { //有几个分组
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //每个分组有几个cell
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //每个cell高度
    return N_C_H*2+S_H;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifider forIndexPath:indexPath];
    NSArray * rows = self.sections[indexPath.section];
    if (!cell.load) {
        cell.items = rows; //
    }else{
        [cell reloadData:rows]; //更新数据
    }
    return cell;
}


#pragma mark - <UITableView SectionHeadView & FooterView>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //设置这个才有效
    if (section==0) {
        return 10;
    }
    return 5;//section头部高度
}
 
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, D_WIDTH, 0)];
    view.backgroundColor = S_H_C;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    //设置这个高度才有效
    if (section==self.sections.count-1) {
        return 10;
    }
    return 5;//section底部间距
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    //section底部视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, D_WIDTH, 0)];
    view.backgroundColor = S_H_C;
    return view;
}

#pragma mark  <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - lazy init 
- (LLRecommendHeadView *)headView {
    if (!_headView) {
        _headView = [LLRecommendHeadView headwithFrame:CGRectMake(0, 0, D_WIDTH, T_H) andClickBlock:^(clickType type, NSString *linkURL) {
            if (type==clickTypeScro) {
                NSLog(@"跳转链接:%@",linkURL);
            }else{
                NSLog(@"点击了第%ld个Button",type);
            }
        }];
        self.tableView.tableHeaderView = _headView;
    }
    return _headView;
}

#pragma mark - clearCache
- (void)clearRecommendMemory{
    [self.sections removeAllObjects];
    self.sections = nil;
}

- (void)dealloc {
    [self clearRecommendMemory];
    NSLog(@"LLRecommendViewController dealloc !!!!!!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
