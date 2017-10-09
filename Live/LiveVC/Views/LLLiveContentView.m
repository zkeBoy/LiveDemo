//
//  LLLiveContentView.m
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLLiveContentView.h"
#import "LLLiveBottomView.h"
#import "LLLiveTopView.h"

#define B_H 70  //(Botton Height)
#define T_H 120 //(TopView Height)

@interface LLLiveContentView ()<LLLiveBottomViewSelectDelegate,LLLiveTopViewDelegate,LLLivePersonDetailViewDelegate>
@property (nonatomic, strong) LLLiveBottomView       * bottomView; //最下面工具栏
@property (nonatomic, strong) LLLiveTopView          * topView;    //顶部工具栏
@property (nonatomic, strong) LLLivePersonDetailView * userInfoView; //用户详细信息
@end

@implementation LLLiveContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self).offset(0);
        make.height.mas_equalTo(scale(B_H));
    }];
    
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(20);
        make.height.mas_offset(scale(T_H));
    }];
    
    [self addSubview:self.userInfoView];
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - lazy init
- (LLLiveBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[LLLiveBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (LLLiveTopView *)topView {
    if (!_topView) {
        _topView = [[LLLiveTopView alloc] init];
        _topView.backgroundColor = [UIColor clearColor];
        _topView.delegate = self;
    }
    return _topView;
}

- (LLLivePersonDetailView *)userInfoView {
    if (!_userInfoView) {
        _userInfoView = [[LLLivePersonDetailView alloc] initWithType:showTypeDefault];
        _userInfoView.delegate = self;
    }
    return _userInfoView;
}

#pragma mark - LLLiveBottomViewSelectDelegate
- (void)didSelectItemWithTag:(NSInteger)tag {
    if (tag == selectTagClose) { //关闭按钮
        if ([self.delegate respondsToSelector:@selector(touchUpInsideXXXViewWithCloseLiveRoom)]) {
            [self.delegate touchUpInsideXXXViewWithCloseLiveRoom];
        }
    }else if (tag == selectTagMessage){ //发送消息
        if ([self.delegate respondsToSelector:@selector(touchUpInsideXXXViewWithPostMessage)]) {
            [self.delegate touchUpInsideXXXViewWithPostMessage];
        }
    }else if (tag == selectTagShare){ //点击分享
        if ([self.delegate respondsToSelector:@selector(touchUpInsideXXXViewWithShareStation)]) {
            [self.delegate touchUpInsideXXXViewWithShareStation];
        }
    }else if (tag == selectTagGift){ //发送礼物
        if ([self.delegate respondsToSelector:@selector(touchUpInsideXXXViewWithSendGift)]) {
            [self.delegate touchUpInsideXXXViewWithSendGift];
        }
    }
}

#pragma mark - <LLLiveTopViewDelegate>
- (void)seeUserInfomation:(id)info{
    
}

- (void)seeLiverUserInfomation{
    [self.userInfoView show];
}

#pragma mark - <LLLivePersonDetailViewDelegate>
- (void)selectHeaderBottomItemWithTag:(NSInteger)tag{
    if ([self.delegate respondsToSelector:@selector(didSelectHeaderBottomViewWithTag:)]) {
        [self.delegate didSelectHeaderBottomViewWithTag:tag];
    }
}

- (void)dealloc {
    NSLog(@"LLLiveContentView dealloc !!!!!!");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
