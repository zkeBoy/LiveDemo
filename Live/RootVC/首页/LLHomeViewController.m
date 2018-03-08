//
//  LLHomeViewController.m
//  Live
//
//  Created by YellowBoy on 2017/7/29.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLHomeViewController.h"
#import "LLHomeTopView.h"
#import "LLLivePersonManager.h"
#import "LLRecommendViewController.h"

#define T_H 40

@interface LLHomeViewController ()<UIScrollViewDelegate,LLHomeTopViewDelegate>
@property (nonatomic, strong) LLHomeTopView * topView;
@property (nonatomic, strong) UIScrollView  * scrollView;

@property (nonatomic, strong) NSArray       * dataArray;
@end

@implementation LLHomeViewController
- (void)requestNetwork{
    [self showloadingHUB:nil toView:self.view];
    [[LLLivePersonManager livePersonManager] refleshRequestWithResponse:^(id arr) {
        if (arr) {
            [self hiddenloadingHUB];
            self.dataArray = arr;
            [self addScrollViewSubViews];
        }else{
            NSDictionary * title = @{@"Color":[UIColor orangeColor],
                                     @"Font":[UIFont systemFontOfSize:14],
                                     @"String":NSLocalizedString(@"糟糕,加载失败～", nil)};
            
            NSDictionary * message = @{@"Color":[UIColor lightGrayColor],
                                       @"Font":[UIFont systemFontOfSize:12],
                                       @"String":NSLocalizedString(@"缺少网络,请检查是否连接网络!", nil)};
            
            [self showloadErrorImage:[UIImage imageNamed:@""]
                               title:title
                             message:message
                         addSelector:@selector(reloadAction)
                              toView:self.view];
        }
    }];
}

- (void)reloadAction{
    [self hiddenloadingHUB];
    [self requestNetwork];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    //[self requestNetwork];
    [self addScrollViewSubViews];
}

- (void)setUI{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(0);
        make.width.equalTo(@(D_WIDTH));
        make.height.equalTo(@scale(T_H));
    }];
}

- (void)addScrollViewSubViews{
    NSArray * classNames = @[@"LLRecommendViewController",
                             @"LLFunPlayViewController",
                             @"LLEntertainMentViewController",
                             @"LLPhoneGameViewController",
                             @"LLNomalGameViewController"];
    for (NSInteger index = 0; index < classNames.count; index++) {
        if (index==0) {
            LLRecommendViewController * recommend = [[LLRecommendViewController alloc] initWithData:self.dataArray];
            recommend.view.frame = CGRectMake(D_WIDTH*index, 0, D_WIDTH, self.scrollView.height);
            [self.scrollView addSubview:recommend.view];
        }else{
            NSString * className = classNames[index];
            UIViewController * contentVC = (UIViewController *)[[NSClassFromString(className) alloc] init];
            contentVC.view.frame = CGRectMake(D_WIDTH*index, 0, D_WIDTH, self.scrollView.height);
            [self.scrollView addSubview:contentVC.view];
        }
    }
}

#pragma mark - lazy init
- (LLHomeTopView *)topView{
    if (!_topView) {
        _topView = [[LLHomeTopView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.delegate = self;
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, T_H, D_WIDTH,
                                                                     self.view.height-T_H-TabBar)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(D_WIDTH*5, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO; //设置弹簧效果
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark - LLHomeTopViewDelegate
- (void)selectButtonWithIndex:(selectButtonIndex)index{
    CGFloat offset = index - 10;
    [self.scrollView setContentOffset:CGPointMake(D_WIDTH*offset, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = 0.0;
    offset = scrollView.contentOffset.x/D_WIDTH*(D_WIDTH/5)+15+2;
    self.topView.lineView.x = offset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / D_WIDTH;
    [self.topView setlineViewOffsetx:page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"LLHomeViewController dealloc!!!!!!");
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
