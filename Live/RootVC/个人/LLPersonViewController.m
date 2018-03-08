//
//  LLPersonViewController.m
//  Live
//
//  Created by YellowBoy on 2017/7/29.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLPersonViewController.h"
#import "LLPersonHeaderView.h"
#import "LLPersonSectionManager.h"
#import "LLPersonCellView.h"

@interface LLPersonViewController ()<LLPersonHeaderViewDelegate,UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView        * tableView;
@property (nonatomic, strong) LLPersonHeaderView * headerView;
@property (nonatomic, strong) NSMutableArray     * sections;
@end

#define H_H 300 //(header height)
#define S_H_C [UIColor clearColor]

static NSString * const cellIdentifying = @"llIdentifider";

@implementation LLPersonViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenNavigationBarStatus:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self hiddenNavigationBarStatus:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.automaticallyAdjustsScrollViewInsets = false; //添加这一行UITableViewWrapperView 与 TableView frame保持一致
    NSArray * array = [LLPersonSectionManager shareManager].sections;
    self.sections = [NSMutableArray arrayWithArray:array];
    [self setUI];
}

- (void)setUI{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(-TabBar);
    }];
    self.tableView.mj_header = [ZKRefreshGifHeader headerWithRefreshingBlock:^{
        [self refleshUserInfomation];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)refleshUserInfomation{ //刷新个人信息
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        self.tableView.tableHeaderView = self.headerView;
    });
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!self.sections.count) {
        return 0;
    }
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * rows = [self.sections objectAtIndex:section];
    if (!rows) {
        return 0;
    }
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLPersonNormalRow * item = self.sections[indexPath.section][indexPath.row];
    LLPersonCellView * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifying forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.item = item;
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

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - lazy init
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = MainColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLPersonCellView class] forCellReuseIdentifier:cellIdentifying];
    }
    return _tableView;
}

- (LLPersonHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [LLPersonHeaderView headerWithFrame:CGRectMake(0, 0, D_WIDTH, H_H) andDelegate:self];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

#pragma mark - LLPersonHeaderViewDelegate
- (void)didClickHeaderTopViewWithType:(topViewType)type{
    switch (type) {
        case topViewTypeIcon:{
        
        }
            break;
        case topViewTypeLogin:{
        
        }
            break;
        case topViewTypeRegister:{
        
        }
            break;
        default:
            break;
    }
}

- (void)didClickHeaderBottonViewWithTag:(NSInteger)tag{

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

@end
