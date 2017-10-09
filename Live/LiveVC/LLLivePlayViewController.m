//
//  LLLivePlayViewController.m
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLLivePlayViewController.h"
#import "LLLiveContentView.h"

@interface LLLivePlayViewController ()<LLLiveContentViewDelegate>
@property (nonatomic, copy)   NSString                   * liveString; //直播地址
@property (nonatomic, strong) UIView                     * previewView;//预览层
@property (nonatomic, strong) UIImageView                * backgroundView;
@property (nonatomic, strong) LLLiveContentView          * contentView;//内容层
@property (nonatomic, strong) IJKFFMoviePlayerController * player; //

@property (nonatomic, strong) UIScrollView               * pageScrollView; //翻页隐藏飘窗
@end

@implementation LLLivePlayViewController

- (instancetype)initWithLiveString:(NSString *)liveString {
    self = [super init];
    if (self) {
        self.liveString = liveString;
        [self addNotificationAboutPlayer];
    }
    return self;
}

- (instancetype)initWithLiveModel:(id)model{
    if (self) {
        self.liveModel = model;
        [self addNotificationAboutPlayer];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.player prepareToPlay];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self removeNotifications];
    [self playerDidFinishPlay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    [self.view addSubview:self.previewView];
    [self showloadingHUB:nil toView:self.previewView];
    self.bgView.backgroundColor = [UIColor clearColor]; //默认是白色的
    
    [self.view addSubview:self.pageScrollView];
    [self.pageScrollView addSubview:self.contentView];
    
    //进度加载
    
    [self.previewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.contentView setFrame:CGRectMake(D_WIDTH, 0, D_WIDTH, D_HEIGHT)];
}

- (void)addNotificationAboutPlayer{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStateChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:nil];
    
    //监听直播完成的回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerDidFinishPlay)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:self.player];
}

- (void)playerStateChange:(NSNotification *)not{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hiddenloadingHUB];
        });
        if (!self.player.isPlaying) {
            [self.player play];
        }
    }else if (self.player.loadState & IJKMPMovieLoadStateStalled){ //网络不佳
        [self showloadingHUB:nil toView:self.previewView];
        self.bgView.backgroundColor = [UIColor clearColor]; //默认是白色的
    }
}

- (void)playerDidFinishPlay{
    if (self.player.isPlaying) {
        [self.player shutdown];
        self.player = nil;
        [self.previewView removeFromSuperview];
        self.previewView = nil;
    }
}

#pragma mark - lazy init 
- (UIView *)previewView {
    if (!_previewView) {
        _previewView = [[UIView alloc] init];
        _previewView.backgroundColor = [UIColor clearColor];
        UIView * playView = [self.player view];
        playView.bounds = self.view.bounds;
        [_previewView insertSubview:playView atIndex:0];
    }
    return _previewView;
}

- (IJKFFMoviePlayerController *)player{
    if (!_player) {
        NSString * path = [self.liveString mutableCopy];
        IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:path withOptions:[IJKFFOptions optionsByDefault]];
        player.scalingMode = IJKMPMovieScalingModeAspectFill;
        player.shouldAutoplay = NO; //自动播放
        //[player prepareToPlay];     //准备播放
        _player = player;
    }
    return _player;
}

- (LLLiveContentView *)contentView {
    if (!_contentView) {
        _contentView = [[LLLiveContentView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.userInteractionEnabled = YES;
        _contentView.delegate = self;
    }
    return _contentView;
}

- (UIScrollView *)pageScrollView{
    if (!_pageScrollView) {
        _pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, D_WIDTH, D_HEIGHT)];
        _pageScrollView.backgroundColor = [UIColor clearColor];
        _pageScrollView.showsVerticalScrollIndicator = NO;
        _pageScrollView.showsHorizontalScrollIndicator = NO;
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.bounces = NO;
        _pageScrollView.contentSize = CGSizeMake(D_WIDTH*2, 0);
        _pageScrollView.contentOffset = CGPointMake(D_WIDTH, 0);
    }
    return _pageScrollView;
}

#pragma mark - LLLiveContentViewDelegate
- (void)touchUpInsideXXXViewWithCloseLiveRoom { //关闭直播
    [self playerDidFinishPlay];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchUpInsideXXXViewWithPostMessage{ //发送消息

}

- (void)touchUpInsideXXXViewWithSendGift{ //发送礼物

}

- (void)touchUpInsideXXXViewWithShareStation{ //分享平台

}

- (void)didSelectHeaderBottomViewWithTag:(btnTagType)type{
    if (type==btnTagTypeFollow) {
        
    }else if(type==btnTagTypePChat){
    
    }else if (type==btnTagTypeLianMai){
    
    }else if (type==btnTagTypeHomePage){
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"LLLivePlayViewController dealloc !!!!!!");
}

- (void)removeNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
}

#pragma mark -

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
