//
//  YHBUserHeadView.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/12.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//
#define isTest 1
#import "YHBUserHeadView.h"
#define kImageWith 60
#define kTitleFont 15
@interface YHBUserHeadView()

@property (strong, nonatomic) UIView *loginedView;
@property (strong, nonatomic) UIView *notLoginedView;

@property (strong, nonatomic) UIImageView *userImageView;
@property (strong, nonatomic) UILabel *userName;
//企供求
@property (strong, nonatomic) UIImageView *comTag;
@property (strong, nonatomic) UIImageView *selTag;
@property (strong, nonatomic) UIImageView *buyTag;
@end

@implementation YHBUserHeadView
#pragma mark - getter and setter
- (UIView *)loginedView
{
    if (!_loginedView) {
        _loginedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, kImageWith, kImageWith)];
        _userImageView.backgroundColor = [UIColor whiteColor];
        [_loginedView addSubview:_userImageView];
        
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(self.userImageView.right + 15, self.userImageView.top+5, 100, kTitleFont)];
        _userName.textColor = [UIColor whiteColor];
        _userName.font = [UIFont systemFontOfSize:kTitleFont];
        [_loginedView addSubview:_userName];
        if(isTest) _userName.text = @"名字";
        
        //企 供 求 等标签待写
        UIImageView *comTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comTag"]];
        UIImageView *selTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selTag"]];
        UIImageView *buyTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buyTag"]];
        comTag.frame = CGRectMake(_userName.left, _userImageView.bottom-45, 40, 45);
        selTag.frame = CGRectMake(comTag.right+10, _userImageView.bottom-45, 40, 45);
        buyTag.frame = CGRectMake(selTag.right+10, _userImageView.bottom-45, 40, 45);
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
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.frame = CGRectMake((kMainScreenWidth-100)/2.0, (self.height-30)/2.0, 100, 30);
        [loginButton setTitle:@"点击登陆" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_notLoginedView addSubview:loginButton];
        [loginButton addTarget:self action:@selector(touchLoginButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _notLoginedView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    self.backgroundColor = RGBCOLOR(58, 155, 9);
    [self refreshViewWithIslogin:NO vcompany:0 sell:0 buy:0];
    
    return self;
}


#pragma mark - action
- (void)refreshViewWithIslogin:(BOOL)isLogin vcompany:(int)vcompany sell:(NSInteger)sell buy:(NSInteger)buy
{
    if (isLogin) {
        [self addSubview:self.loginedView];
        [self.notLoginedView removeFromSuperview];
        self.comTag.hidden = vcompany ? NO : YES;
        self.selTag.hidden = sell ? NO : YES;
        self.buyTag.hidden = buy ? NO : YES;
        
    }else{
        [self addSubview:self.notLoginedView];
        [self.loginedView removeFromSuperview];
    }
}

- (void)touchLoginButton
{
    
}

@end
