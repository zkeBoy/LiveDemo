//
//  LLFunPlayViewController.m
//  Live
//
//  Created by MliBo on 2017/8/11.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLFunPlayViewController.h"
#import "LLFunPlayHeadView.h"
@interface LLFunPlayViewController ()
@property (nonatomic, strong) LLFunPlayHeadView * headView;
@end


#define F_H ((D_WIDTH/4)*2+20)

@implementation LLFunPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
}

- (void)setTableView{
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [ZKRefreshGifHeader headerWithRefreshingBlock:^{
        [self refleshAction];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)refleshAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        self.tableView.tableHeaderView = self.headView;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

#pragma mark - lazy init
- (LLFunPlayHeadView *)headView {
    if (!_headView) {
        _headView = [LLFunPlayHeadView headWithFrame:CGRectMake(0, 0, D_WIDTH, F_H) click:^{
            
        }];
        _headView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableHeaderView = _headView;
    }
    return _headView;
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
