//
//  LLLoginViewController.m
//  Live
//
//  Created by YellowBoy on 2017/8/9.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLLoginViewController.h"
#import "LLMainViewController.h"
#import "LLLoginTypeView.h"
@interface LLLoginViewController ()
@property (nonatomic, strong) UIView                     * preView;       //预览层
@property (nonatomic, strong) UIImageView                * backgroundView;//背景层
@property (nonatomic, strong) LLLoginTypeView            * typeView;      //第三发登陆
@property (nonatomic, strong) IJKFFMoviePlayerController * player;        //播放器
@end

@implementation LLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotificationForIJKMoviePlayer];
    [self setUI];
}

- (void)setUI{
    [self.view insertSubview:self.backgroundView atIndex:0];
    [self.view insertSubview:self.typeView atIndex:2];

    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-scale(80));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(scale(400)));
        make.height.equalTo(@(scale(80)));
    }];
    
    BOOL isFirst = [LLLoginManager isFirstInsatll];
    if (!isFirst) {
        [LLLoginManager firstInstall];
        [self.view insertSubview:self.preView atIndex:1];
        [self.preView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

- (void)addNotificationForIJKMoviePlayer{
    //监听网络环境，监听缓冲方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerLoadStateDidChange)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:nil];
    
    //监听直播完成的回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerPlaybackDidFinish)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}

#pragma mark - Notification Action
- (void)moviePlayerLoadStateDidChange{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.player.isPlaying) {
            [self.player play];
        }
    }
}

- (void)moviePlayerPlaybackDidFinish{
    if (self.player.isPlaying == NO) {
        //播放结束
        [self.player shutdown];
        self.player = nil;
        [self.preView removeFromSuperview];
        self.preView = nil;
    }
}

#pragma mark - Lazy init
- (UIImageView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
        _backgroundView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backgroundView;
}

- (UIView *)preView{
    if (!_preView) {
        _preView = [[UIView alloc] init];
        _preView.backgroundColor = [UIColor purpleColor];
        UIView * playView = [self.player view];
        playView.frame = self.view.bounds;
        playView.backgroundColor = [UIColor whiteColor];
        [_preView addSubview:playView];
    }
    return _preView;
}

- (IJKFFMoviePlayerController *)player{
    if (!_player) {
        NSString * index = arc4random_uniform(10)%2 ? @"login_video": @"login_movie";
        NSString * path = [[NSBundle mainBundle] pathForResource:index ofType:@"mp4"];
        IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:path withOptions:[IJKFFOptions optionsByDefault]];
        player.scalingMode = IJKMPMovieScalingModeAspectFill;
        player.shouldAutoplay = NO; //自动播放
        [player prepareToPlay];     //准备播放
        _player = player;
    }
    return _player;
}

- (LLLoginTypeView *)typeView{
    if (!_typeView) {
        __weak typeof(self)weakSelf = self;
        _typeView = [[LLLoginTypeView alloc] init];
        _typeView.clickActionBlock = ^(loginType type) {
            [weakSelf thirdLoginType:type];
        };
        _typeView.backgroundColor = [UIColor clearColor];
    }
    return _typeView;
}

#pragma mark - Private Method
- (void)thirdLoginType:(loginType)type{
    if (type == loginTypeWeiChat) {
        
    }else if (type == loginTypeQQ) {
        [self loginSuccess];
    }else if (type == loginTypeWeiBo) {
    
    }
}

- (void)loginSuccess{
    if (![LLLoginManager isFirstInsatll]) {
        [self moviePlayerPlaybackDidFinish];
    }
    LLMainViewController * mainVC = [[LLMainViewController alloc] init];
    [self presentViewController:mainVC animated:YES completion:nil];
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
