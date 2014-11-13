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

@property (strong, nonatomic) UIImageView *userImageView;
@property (strong, nonatomic) UILabel *userName;
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
    }
    return _loginedView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = RGBCOLOR(58, 155, 9);
    
    if(isTest) [self addSubview:self.loginedView];
    
    return self;
}

@end
