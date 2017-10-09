//
//  LLNearViewController.m
//  Live
//
//  Created by YellowBoy on 2017/7/29.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLNearViewController.h"

@interface LLNearViewController ()

@end

@implementation LLNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"LLNearViewController dealloc !!!!!!");
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
