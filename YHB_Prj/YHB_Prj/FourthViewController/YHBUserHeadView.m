//
//  YHBUserHeadView.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/12.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//
#define isTest 0
#import "YHBUserHeadView.h"
#import "UIImageView+WebCache.h"
#define kImageWith 55
#define kTitleFont 15
#define kSmallFont 11
@interface YHBUserHeadView()

@property (strong, nonatomic) UIView *loginedView;
@property (strong, nonatomic) UIView *notLoginedView;

@property (strong, nonatomic) UILabel *companylabel;

@property (strong, nonatomic) UILabel *userName;
//企供求
@property (strong, nonatomic) UIImageView *comTag;
@property (strong, nonatomic) UIImageView *selTag;
@property (strong, nonatomic) UIImageView *buyTag;

@property (strong, nonatomic) UIImageView *vipImageView;
//@property (strong, nonatomic) UIButton *privateButton; //关注按钮

//@property (strong, nonatomic) UILabel *creditLabel;
@property (strong, nonatomic) UILabel *priceLabel;

@end

@implementation YHBUserHeadView
#pragma mark - getter and setter
- (UIImageView *)vipImageView
{
    if (!_vipImageView) {
        _vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-36-15, 20, 35, 26)];
        _vipImageView.contentMode = UIViewContentModeScaleAspectFill;
        _vipImageView.image = [UIImage imageNamed:@"VipCrow"];
    }
    return _vipImageView;
}
//- (UILabel *)creditLabel
//{
//    if (!_creditLabel) {
//        _creditLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-10-150, self.companylabel.top+4, 150, kSmallFont)];
//        _creditLabel.textColor = [UIColor whiteColor];
//        _creditLabel.font = [UIFont systemFontOfSize:kSmallFont];
//        _creditLabel.textAlignment = NSTextAlignmentRight;
//    }
//    return _creditLabel;
//}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.bottom - kSmallFont-10, kMainScreenWidth-20, kSmallFont)];
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.font = [UIFont systemFontOfSize:kSmallFont];
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

//- (UIButton *)privateButton
//{
//    if (!_privateButton) {
//        _privateButton = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-65, 50, 55, 20)];
//        [_privateButton setBackgroundImage:[UIImage imageNamed:@"privateBtn"] forState:UIControlStateNormal];
//        [_privateButton setBackgroundImage:[UIImage imageNamed:@"privateHighBtn"] forState:UIControlStateSelected];
//        [_privateButton addTarget:self action:@selector(touchPrivateButton:) forControlEvents:UIControlEventTouchUpInside];
//        _privateButton.selected = NO;
//    }
//    return _privateButton;
//}

- (UIView *)loginedView
{
    if (!_loginedView) {
        _loginedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, kImageWith, kImageWith)];
        _userImageView.backgroundColor = [UIColor whiteColor];
        _userImageView.layer.borderWidth = 1.0;
        _userImageView.layer.borderColor = [kLineColor CGColor];
        _userImageView.layer.cornerRadius = 4.0;
        _userImageView.clipsToBounds = YES;
        [_loginedView addSubview:_userImageView];
        
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = _userImageView.frame;
        [imageButton setBackgroundColor:[UIColor clearColor]];
        [imageButton addTarget:self action:@selector(touchHeadImageView) forControlEvents:UIControlEventTouchUpInside];
        [_loginedView addSubview:imageButton];
//        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchHeadImageView)];
//        [_userImageView addGestureRecognizer:gr];
        
        
        _companylabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userImageView.right+15, self.userImageView.top+5, 200, kTitleFont)];
        _companylabel.backgroundColor = [UIColor clearColor];
        _companylabel.textColor = [UIColor whiteColor];
        _companylabel.font = [UIFont systemFontOfSize:kTitleFont];
        [_loginedView addSubview:_companylabel];
        
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(self.companylabel.left, self.companylabel.bottom+15, 30, kTitleFont-4)];
        _userName.textColor = [UIColor whiteColor];
        _userName.backgroundColor = [UIColor clearColor];
        _userName.font = [UIFont systemFontOfSize:kTitleFont];
        [_loginedView addSubview:_userName];
        
        //标签
        UIImageView *comTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comTag"]];
        UIImageView *selTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selTag"]];
        UIImageView *buyTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buyTag"]];
        buyTag.frame = CGRectMake(_userName.right+10, self.userName.top, 40/2.5, 45/2.5);
        selTag.frame = CGRectMake(buyTag.right+5, self.userName.top, 40/2.5, 45/2.5);
        comTag.frame = CGRectMake(selTag.right+5, self.userName.top, 40/2.5, 45/2.5);
        
        _comTag = comTag;
        _selTag = selTag;
        _buyTag = buyTag;
        [_loginedView addSubview:comTag];
        [_loginedView addSubview:selTag];
        [_loginedView addSubview:buyTag];
        
        
    }
    return _loginedView;
}

- (UIView *)notLoginedView
{
    if (!_notLoginedView) {
        _notLoginedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((kMainScreenWidth-120)/2.0, 40, 120, 20)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:kTitleFont];
        titleLabel.text = @"你还没有登陆哦~";
        [_notLoginedView addSubview:titleLabel];
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.frame = CGRectMake((kMainScreenWidth-60)/2.0, titleLabel.bottom+10, 60, 20);
        [loginButton setBackgroundImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_notLoginedView addSubview:loginButton];
        [loginButton addTarget:self action:@selector(touchLoginButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _notLoginedView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.bannerImageView = [[UIImageView alloc] initWithFrame:self.frame];
    self.bannerImageView.image = [UIImage imageNamed:@"userBannerDefault"];
    [self.bannerImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.bannerImageView.clipsToBounds = YES;
    //self.backgroundColor = RGBCOLOR(58, 155, 9);
    [self addSubview:self.bannerImageView];
    self.backgroundColor = [UIColor lightGrayColor];
    [self refreshSelfHeadWithIsLogin:NO name:nil avator:nil thumb:nil group:0 company:nil money:nil lock:nil credit:nil];
    //[self refreshViewWithIslogin:NO vcompany:0 sell:0 buy:0 name:@"" avator:nil];
    
    return self;
}


#pragma mark - action
- (void)refreshSelfHeadWithIsLogin:(BOOL)isLogin name:(NSString *)name avator:(NSString *)avator thumb:(NSString *)thumb group:(NSInteger)group company:(NSString *)company money:(NSString *)money lock:(NSString *)lock credit:(NSString *)credit
{
    MLOG(@"%@",avator);
    if (isLogin) {
        [self addSubview:self.loginedView];
        //if([self.privateButton superview]) [self.privateButton removeFromSuperview];
        [self.notLoginedView removeFromSuperview];
        self.companylabel.text = company;
        
        CGSize size = CGSizeMake(kMainScreenWidth-self.userName.left-10-70, self.userName.height);
        CGSize newSize = [name sizeWithFont:self.userName.font constrainedToSize:size];
        self.userName.frame = CGRectMake(self.userName.left, self.userName.top, newSize.width, newSize.height);
        _buyTag.frame = CGRectMake(_userName.right+10, self.userName.top, 40/2.5, 45/2.5);
        _selTag.frame = CGRectMake(_buyTag.right+5, self.userName.top, 40/2.5, 45/2.5);
        _comTag.frame = CGRectMake(_selTag.right+5, self.userName.top, 40/2.5, 45/2.5);
//        self.comTag.left = self.userName.right;
//        self.selTag.left = self.comTag.right + 5;
//        self.buyTag.left = self.selTag.right + 5;
        
        self.userName.text = name;
        self.comTag.hidden = group >= 7 ? NO : YES;
        self.selTag.hidden = group >= 6 ? NO : YES;
        self.buyTag.hidden = group >= 5 ? NO : YES;
        self.userName.text = name ? name : @"";
        
        if(avator)
            [self.userImageView sd_setImageWithURL:[NSURL URLWithString:avator] placeholderImage:
                    [UIImage imageNamed:@"DefualtUser"] options:SDWebImageCacheMemoryOnly];
        if(thumb)
            [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:[UIImage imageNamed:@"userBannerDefault"] options:SDWebImageCacheMemoryOnly];
        MLOG(@"thumb:---->%@   avator------>????:%@",thumb,avator);
//        if (credit && !self.creditLabel.superview) {
//            [self.loginedView addSubview:self.creditLabel];
//        }
//        self.creditLabel.text = [NSString stringWithFormat:@"积分:%@分",credit];
        if (money && !self.priceLabel.superview) {
            [self.loginedView addSubview:self.priceLabel];
        }
        self.priceLabel.text = [NSString stringWithFormat:@"资金:%@元[%@元]  积分:%@分",money,lock,credit];
        
        if (group == 7) {
            [self.loginedView addSubview:self.vipImageView];
        }else {
            [_vipImageView removeFromSuperview];
        }
    }else{
        [self addSubview:self.notLoginedView];
        self.bannerImageView.image = [UIImage imageNamed:@"userBannerDefault"];
        [self.loginedView removeFromSuperview];
//        if (_creditLabel) {
//            [_creditLabel removeFromSuperview];
//        }
        if (_priceLabel) {
            [_priceLabel removeFromSuperview];
        }
    }
}

- (void)refreshViewWithIslogin:(BOOL)isLogin group:(NSInteger)group name:(NSString *)name avator:(NSString *)avator thumb:(NSString *)thumb company:(NSString *)company friend:(NSInteger)firend
{
    MLOG(@"%@",thumb);
    [self refreshSelfHeadWithIsLogin:YES name:name avator:avator thumb:thumb group:group company:company  money:nil lock:nil credit:nil];
//    if (![self.privateButton superview]) {
//        [self addSubview:self.privateButton];
//        self.privateButton.selected = firend ? YES : NO;
//    }
}


#pragma mark 点击登录按钮
- (void)touchLoginButton
{
    if ([self.delegate respondsToSelector:@selector(touchHeadLoginBtn)]) {
        [self.delegate touchHeadLoginBtn];
    }
}

#pragma mark touch private 收藏
//- (void)touchPrivateButton : (UIButton *)sender
//{
//    if ([self.delegate respondsToSelector:@selector(touchPrivateBtn:)]) {
//        [self.delegate touchPrivateBtn:sender];
//    }
//}

#pragma mark touch 头像
- (void)touchHeadImageView
{
    if ([self.delegate respondsToSelector:@selector(touchHeadImagBtn)]) {
        [self.delegate touchHeadImagBtn];
    }
}

@end
