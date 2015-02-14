//
//  YHBConnectStoreVeiw.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/4.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBConnectStoreVeiw.h"
#import "UIImageView+WebCache.h"
#define kImgwidth 30
#define kbtnwidth 55
@interface YHBConnectStoreVeiw()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *desStarlabel;
@property (strong, nonatomic) UILabel *servStarlabel;
@property (strong, nonatomic) UIButton *connectButton;

@end

@implementation YHBConnectStoreVeiw

#pragma mark getter and setter

- (UILabel *)desStarlabel
{
    if (!_desStarlabel) {
        _desStarlabel = [[UILabel alloc] init];
        _desStarlabel.textColor = KColor;
        _desStarlabel.font = kFont11;
        _desStarlabel.backgroundColor = [UIColor clearColor];
    }
    return _desStarlabel;
}

- (UILabel *)servStarlabel
{
    if (!_servStarlabel) {
        _servStarlabel = [[UILabel alloc] init];
        _servStarlabel.textColor = KColor;
        _servStarlabel.font = kFont11;
        _servStarlabel.backgroundColor = [UIColor clearColor];
    }
    return _servStarlabel;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, kImgwidth, kImgwidth)];
        _imageView.layer.cornerRadius = 2.0f;
        _imageView.layer.borderColor = [kLineColor CGColor];
        _imageView.layer.borderWidth = 0.5;
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, kImgwidth)];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = kFont14;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIButton *)connectButton
{
    if (!_connectButton) {
        _connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _connectButton.frame = CGRectMake(kMainScreenWidth-10-kbtnwidth, (self.height-40)/2.0, kbtnwidth, 40);
        [_connectButton setBackgroundImage:[UIImage imageNamed:@"connectStore"] forState:UIControlStateNormal];
        [_connectButton setContentMode:UIViewContentModeScaleAspectFit];
        [_connectButton addTarget:self action:@selector(touchConnectButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectButton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainScreenWidth, kcStoreHeight);
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void)creatUI
{
    UIView *detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kMainScreenWidth-kbtnwidth-10, kImgwidth)];
    detailView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchShopDetail)];
    [detailView addGestureRecognizer:gr];
    [self addSubview:detailView];
    
    [detailView addSubview:self.imageView];
    self.titleLabel.left = self.imageView.right+5;
    [detailView addSubview:self.titleLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(detailView.width-15, self.height/2.0 - 9.5, 12, 19)];
    arrowImageView.image = [UIImage imageNamed:@"Arrow_right"];
    [arrowImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    
    UILabel *desTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, detailView.bottom+7, 4*11, 11)];
    desTitle.text = @"描述相符";
    desTitle.textColor = [UIColor lightGrayColor];
    desTitle.font = kFont11;
    [self addSubview:desTitle];
    
    self.desStarlabel.frame = CGRectMake(desTitle.right+4, desTitle.top, 40, 11);
    [self addSubview:self.desStarlabel];
    
    UILabel *servTitle = [[UILabel alloc] initWithFrame:CGRectMake(110, desTitle.top, 4*11, 11)];
    servTitle.text = @"服务态度";
    servTitle.textColor = [UIColor lightGrayColor];
    servTitle.font = kFont11;
    [self addSubview:servTitle];
    
    self.servStarlabel.frame = CGRectMake(servTitle.right+4, servTitle.top, 40, 11);
    [self addSubview:self.servStarlabel];
    
    [self addSubview:self.connectButton];
    
    [self addSubview:arrowImageView];
}

- (void)setUIWithTitle:(NSString *)title imageUrl:(NSString *)urlstr desStar:(NSString *)star1 servStar:(NSString *)star2
{
    self.titleLabel.text = title;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    self.desStarlabel.text = star1;
    self.servStarlabel.text = star2;
}

#pragma mark - action
- (void)touchShopDetail
{
    if ([self.delegate respondsToSelector:@selector(touchShopDetailCell)]) {
        [self.delegate touchShopDetailCell];
    }
}

- (void)touchConnectButton
{
    if ([self.delegate respondsToSelector:@selector(touchConnectStoreBtn)]) {
        [self.delegate touchConnectStoreBtn];
    }
}

@end
