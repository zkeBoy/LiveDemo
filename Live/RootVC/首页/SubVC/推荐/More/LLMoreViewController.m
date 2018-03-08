//
//  LLMoreViewController.m
//  Live
//
//  Created by MliBo on 2017/9/5.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLMoreViewController.h"
#import "ZKRefreshGifHeader.h"
#import "LLLivePersonManager.h"
#import "LLMoreViewCell.h"
#import "LLLivePlayViewController.h"

static NSString * const cellIdentifier = @"LLMoreViewCell";

@interface LLMoreViewController ()
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray * liveArray;
@end

@implementation LLMoreViewController

- (void)viewWillAppear:(BOOL)animated {
    //改变NavigationBar 应该放在viewWillAppear
    [super viewWillAppear:animated];
    [self setNavigationBarBackgroundColor:[UIColor whiteColor]];
    [self setNavigationBarSeparateLineColor:[UIColor purpleColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    self.liveArray = [NSMutableArray array];
    [self setNavBarItem];
    [self setUI];
}

- (void)setNavBarItem{
    UIButton * left = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 21)];
    [left setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [left setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 18)];
    [left addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UILabel * titleLabel = [UILabel initWithFrame:CGRectMake(0, 0, 60, 21)
                                             text:@"更多精彩"
                                    textAlignment:NSTextAlignmentCenter
                                        textColor:[UIColor orangeColor]
                                             font:[UIFont systemFontOfSize:16]];
    self.navigationItem.titleView = titleLabel;
}

- (void)setUI{
    
    self.tableView.mj_header = [ZKRefreshGifHeader headerWithRefreshingBlock:^{
        [self refleashHeader];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage ++;
        [self refleashFooter];
    }];
    [self.tableView registerClass:[LLMoreViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    //设置分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /*
    self.tableView.separatorColor = [UIColor redColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;*/
}

- (void)refleashHeader{
    self.currentPage = 1;
    NSString * liveURL = [NSString stringWithFormat:@"%@%ld",MiaoXingLiveURL,self.currentPage];
    [[LLLivePersonManager livePersonManager] requestMiaoXingLivesWithURL:liveURL response:^(NSArray * arr) {
        if (arr.count) {
            [self.liveArray removeAllObjects];
            [self.liveArray addObjectsFromArray:arr];
            [self.tableView reloadData];
        }else{
            self.currentPage --;
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)refleashFooter{
    NSString * liveURL = [NSString stringWithFormat:@"%@%ld",MiaoXingLiveURL,self.currentPage];
    [[LLLivePersonManager livePersonManager] requestMiaoXingLivesWithURL:liveURL response:^(NSArray * arr) {
        if (arr.count) {
            [self.liveArray addObjectsFromArray:arr];
            //[self.tableView reloadData];
            NSMutableArray * indexPaths = [[NSMutableArray alloc] init];
            for (int index=0; index<arr.count; index++) {
                NSIndexPath * indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                [indexPaths addObject:indexPath];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView performWithoutAnimation:^{
                    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                }];
            });
            
        }else{
            self.currentPage --;
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.liveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLMoreViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.liveModel = self.liveArray[indexPath.row];
    return cell;
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LLMoreLiveModel * liveModel = self.liveArray[indexPath.row];
    NSString * linkString = liveModel.flv;
    LLLivePlayViewController * livePlayVC = [[LLLivePlayViewController alloc] initWithLiveString:linkString];
    [self presentViewController:livePlayVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //每个cell高度
    return N_C_H*2+40+10;
}

#pragma mark - Private Method
- (void)backAction{
    [self cleanCacheMemory];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self cleanCacheMemory];
    [self.tableView reloadData];
}

- (void)cleanCacheMemory{
    [self.liveArray removeAllObjects];
    self.liveArray = nil;
}

- (void)dealloc {
    NSLog(@"%@",@"LLMoreViewController dealloc !!!!!!");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
