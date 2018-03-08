//
//  YZMyInformationVC.m
//  yuzhuaAPP
//
//  Created by 罗达达 on 2018/3/7.
//  Copyright © 2018年 北京鱼爪网络科技有限公司. All rights reserved.
//

#import "YZMyInformationVC.h"
#import "YZMyHeaderView.h"
#import "YZMyTableViewCell.h"

#define NavH 64
#define TabH 44
#define H_H 300 //(header height)
#define S_H_C [UIColor clearColor]
#define Scr_Width [UIScreen mainScreen].bounds.size.width
#define S_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Scale(s) (s*(S_HEIGHT/736))
#define SectionColor [UIColor colorWithRed:242/255.0 green:242/255.0 blue:244/255.0 alpha:1]

static NSString * const CellIdentifider = @"CellIdentifider";

@interface YZMyInformationVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) YZMyHeaderView * headerView;
@end

@implementation YZMyInformationVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

#pragma mark - setUI
- (void)setUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Scr_Width, 0)];
    view.backgroundColor = SectionColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    //设置这个高度才有效
    if (section==1) {
        return 10;
    }
    return 5;//section底部间距
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    //section底部视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Scr_Width, 0)];
    view.backgroundColor = SectionColor;
    return view;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZMyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifider forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return Scale(118);
    }
    return Scale(40);
}

#pragma mark - lazy init
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:NSClassFromString(@"YZMyTableViewCell") forCellReuseIdentifier:CellIdentifider];
    }
    return _tableView;
}

- (YZMyHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [YZMyHeaderView initWithFrame:CGRectMake(0, 0, Scr_Width, Scale(248)) andShowToView:self.view andDelegate:self];
        //_headerView.backgroundColor = [UIColor purpleColor];
    }
    return _headerView;
}

@end
