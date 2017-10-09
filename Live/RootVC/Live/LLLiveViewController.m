//
//  LLLiveViewController.m
//  Live
//
//  Created by YellowBoy on 2017/7/29.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLLiveViewController.h"

@interface LLLiveViewController ()
@property (nonatomic, strong) UIButton * closeButton;
@end

@implementation LLLiveViewController
    
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenNavigationBarStatus:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setUI];
}

- (void)setUI{
    [self.view addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(scale(-22));
        make.width.height.mas_equalTo(scale(24));
    }];
}
    
#pragma mark - lazy init
- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton addTarget:self action:@selector(closeLiveController) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"talk_close_40x40_"] forState:UIControlStateNormal];
    }
    return _closeButton;
}
    
#pragma mark - Private Method
- (void)closeLiveController{
    [self dismissViewControllerAnimated:YES completion:nil];
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
