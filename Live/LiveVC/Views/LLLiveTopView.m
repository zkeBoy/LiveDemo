//
//  LLLiveTopView.m
//  Live
//
//  Created by MliBo on 2017/9/4.
//  Copyright © 2017年 YellowBoy. All rights reserved.
//

#import "LLLiveTopView.h"
#import "LLLiveOtherUserCell.h"
#define B_W 48
#define C_W 40
#define M_C [[UIColor blackColor] colorWithAlphaComponent:0.2]

@interface LLLiveTopView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIView           * detailView;    //详细信息
@property (nonatomic, strong) UIButton         * iconView;      //头像
@property (nonatomic, strong) UILabel          * nameLabel;     //昵称
@property (nonatomic, strong) UIButton         * followButton;  //关注
@property (nonatomic, strong) UILabel          * onlineNumber;  //在线人数
@property (nonatomic, strong) UICollectionView * otherUserView; //其他用户
@property (nonatomic, strong) UIButton         * earningsView;  //收益
@end
static NSString * cellIdentifiter = @"cellIdentifiter";
@implementation LLLiveTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        [self addNotification];
    }
    return self;
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFollowState:) name:NSNotificationFollowSomeOneKey object:nil];
}

- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUI{
    [self addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(scale(10));
        make.width.mas_equalTo(scale(220));
        make.height.mas_equalTo(scale(60));
    }];
    
    [self.detailView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.detailView).offset(scale(CellSpace));
        make.width.height.mas_equalTo(scale(B_W));
    }];
    
    [self.detailView addSubview:self.followButton];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconView.mas_centerY);
        make.right.equalTo(self.detailView).offset(-scale(CellSpace));
        make.width.height.mas_equalTo(scale(C_W));
    }];
    
    [self.detailView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailView).offset(scale(CellSpace));
        make.left.equalTo(self.iconView.mas_right).offset(scale(CellSpace));
        make.right.equalTo(self.followButton.mas_left).offset(-scale(CellSpace));
        make.height.equalTo(self.nameLabel);
    }];
    
    [self.detailView addSubview:self.onlineNumber];
    [self.onlineNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.detailView).offset(-scale(CellSpace));
        make.left.equalTo(self.iconView.mas_right).offset(scale(CellSpace));
        make.right.equalTo(self.followButton.mas_left).offset(-scale(CellSpace));
        make.height.equalTo(self.onlineNumber);
    }];
    
    [self addSubview:self.earningsView];
    [self.earningsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailView);
        make.top.equalTo(self.detailView.mas_bottom).offset(scale(10));
        make.height.mas_equalTo(scale(30));
        make.width.mas_equalTo(scale(160));
    }];
    
    [self addSubview:self.otherUserView];
    [self.otherUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailView.mas_right).offset(scale(10));
        make.centerY.equalTo(self.detailView.mas_centerY);
        make.right.equalTo(self).offset(-scale(10));
        make.height.mas_equalTo(C_W);
    }];
}

#pragma mark - lazy init
- (UIView *)detailView {
    if (!_detailView) {
        _detailView = [[UIView alloc] init];
        _detailView.backgroundColor = M_C;
        _detailView.layer.cornerRadius = 30.0f;
    }
    return _detailView;
}

- (UIButton *)iconView {
    if (!_iconView) {
        _iconView = [[UIButton alloc] init];
        UIImage * image = [UIImage imageNamed:@"placeholder_head"];
        [_iconView setImage:[image yy_imageByRoundCornerRadius:image.size.width] forState:UIControlStateNormal];
        _iconView.backgroundColor = [UIColor grayColor];
        _iconView.layer.cornerRadius = B_W/2;
        [_iconView addTarget:self action:@selector(touchUpInsideInIconView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel initWithFrame:CGRectZero
                                       text:@"好玩不过嫂子"
                              textAlignment:NSTextAlignmentLeft
                                  textColor:[UIColor whiteColor]
                                       font:[UIFont systemFontOfSize:14]];
        _nameLabel.backgroundColor = [UIColor clearColor];
    }
    return _nameLabel;
}

- (UIButton *) followButton{
    if (!_followButton) {
        _followButton = [[UIButton alloc] init];
        _followButton.layer.cornerRadius = C_W/2;
        _followButton.backgroundColor = [UIColor grayColor];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        [_followButton addTarget:self action:@selector(touchUpInsideInFollowButton:) forControlEvents:UIControlEventTouchUpInside];
        _followButton.selected = NO;
    }
    return _followButton;
}

- (UILabel *)onlineNumber {
    if (!_onlineNumber) {
        _onlineNumber = [UILabel initWithFrame:CGRectZero
                                          text:@"8888 人"
                                 textAlignment:NSTextAlignmentLeft
                                     textColor:[UIColor whiteColor]
                                          font:[UIFont systemFontOfSize:12]];
        _onlineNumber.backgroundColor = [UIColor clearColor];
    }
    return _onlineNumber;
}

- (UICollectionView *)otherUserView{
    if (!_otherUserView) {
        UICollectionViewFlowLayout * FlowLayout = [[UICollectionViewFlowLayout alloc] init];
        FlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //方向
        FlowLayout.minimumLineSpacing = CellSpace; //列最小间距
        FlowLayout.itemSize = CGSizeMake(C_W, C_W); //item 尺寸
        FlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//内边距
        _otherUserView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:FlowLayout];
        _otherUserView.showsVerticalScrollIndicator = NO;
        _otherUserView.showsHorizontalScrollIndicator = NO;
        _otherUserView.delegate = self;
        _otherUserView.dataSource = self;
        _otherUserView.backgroundColor = [UIColor clearColor];
        [_otherUserView registerClass:[LLLiveOtherUserCell class] forCellWithReuseIdentifier:cellIdentifiter];
    }
    return _otherUserView;
}

- (UIButton *)earningsView {
    if (!_earningsView) {
        _earningsView = [[UIButton alloc] init];
        _earningsView.layer.cornerRadius = 15.0f;
        _earningsView.clipsToBounds = YES;
        _earningsView.backgroundColor = M_C;
        [_earningsView setTitle:@"魅力值 6555" forState:UIControlStateNormal];
        /*
        NSString * content = @" 魅力值 6555 ";
        NSInteger length = content.length;
        NSMutableAttributedString * att = [[NSMutableAttributedString alloc] initWithString:content];
        NSTextAttachment * textAtt = [[NSTextAttachment alloc] init];
        textAtt.image = [UIImage imageNamed:@"right_arrow"];
        textAtt.bounds = CGRectMake(0, 0, 15, 15);
        NSAttributedString * string = [NSAttributedString attributedStringWithAttachment:textAtt];
        [att insertAttributedString:string atIndex:length];
        [_earningsView setAttributedText:att];
         */
    }
    return _earningsView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LLLiveOtherUserCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifiter forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - Private Method 
- (void)touchUpInsideInIconView{
    if ([self.delegate respondsToSelector:@selector(seeLiverUserInfomation)]) {
        [self.delegate seeLiverUserInfomation];
    }
}

- (void)touchUpInsideInFollowButton:(UIButton *)follow{
    self.followButton.selected = !follow.selected;
    //翻转动画
    if (self.followButton.isSelected) {
        [self.followButton setTitle:@"取消" forState:UIControlStateSelected];
    }else{
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
    }
}

- (void)changeFollowState:(NSNotification *)not{
    NSDictionary * userInfo = not.userInfo;
    BOOL follow = [[userInfo objectForKey:@"follow"] boolValue];
    self.followButton.selected = follow;
    if (follow) {
        [self.followButton setTitle:@"取消" forState:UIControlStateSelected];
    }else{
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
    }
}

- (void)dealloc {
    NSLog(@"LLLiveTopView dealloc !!!!!!");
    [self removeNotification];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
