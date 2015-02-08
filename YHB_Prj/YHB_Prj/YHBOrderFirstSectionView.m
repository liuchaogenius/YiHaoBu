//
//  YHBOrderFirstSectionView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/19.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderFirstSectionView.h"
#define kTitleFont 15
#define kSmallFont 12
@interface YHBOrderFirstSectionView ()
{
    UILabel *_statusLabel;
    UILabel *_mountPriceLabel;
    UILabel *_transPriceLabel;
    
    UILabel *_nameLabel;
    UILabel *_phoneLabel;
    UILabel *_addressLabel;
}
@property (strong, nonatomic) UIView *orderStausView;//订单信息
@property (strong, nonatomic) UIView *addressView;//地址
@property (strong, nonatomic) UIView *logistView;//快递

@end

@implementation YHBOrderFirstSectionView

- (UIView *)orderStausView
{
    if (!_orderStausView) {
        _orderStausView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 80)];
        _orderStausView.backgroundColor = RGBCOLOR(3, 152, 26);
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 27, 33)];
        icon.image = [UIImage imageNamed:@"statusIcon"];
        [icon setContentMode:UIViewContentModeScaleAspectFit];
        [_orderStausView addSubview:icon];
        
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, icon.top, 250, kTitleFont)];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.font = [UIFont systemFontOfSize:kTitleFont];
        [_orderStausView addSubview:_statusLabel];
        
        _mountPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_statusLabel.left, _statusLabel.bottom+5, 200, kSmallFont)];
        _mountPriceLabel.backgroundColor = [UIColor clearColor];
        _mountPriceLabel.textColor = [UIColor whiteColor];
        _mountPriceLabel.font = [UIFont systemFontOfSize:kSmallFont];
        [_orderStausView addSubview:_mountPriceLabel];
        
        _transPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_mountPriceLabel.left, _mountPriceLabel.bottom+2, 200, kSmallFont)];
        _transPriceLabel.backgroundColor = [UIColor clearColor];
        _transPriceLabel.textColor = [UIColor whiteColor];
        _transPriceLabel.font = [UIFont systemFontOfSize:kSmallFont];
        [_orderStausView addSubview:_transPriceLabel];
    }
    return _orderStausView;
}

- (UIView *)addressView
{
    if (!_addressView) {
        _addressView = [[UIView alloc] initWithFrame:CGRectMake(0, self.orderStausView.bottom, kMainScreenWidth, 80)];
        _addressView.backgroundColor = [UIColor whiteColor];
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 26, 30)];
        icon.image = [UIImage imageNamed:@"AddressIcon"];
        [icon setContentMode:UIViewContentModeScaleAspectFit];
        [_addressView addSubview:icon];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, icon.top, 150, kTitleFont)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:kTitleFont];
        [_addressView addSubview:_nameLabel];
        
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-10-150, 10, 150, kTitleFont)];
        _phoneLabel.backgroundColor = [UIColor clearColor];
        _phoneLabel.font = [UIFont systemFontOfSize:kTitleFont-2];
        _phoneLabel.textColor = [UIColor blackColor];
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        [_addressView addSubview:_phoneLabel];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+5, kMainScreenWidth-10-_nameLabel.left, kSmallFont *2.5)];
        _addressLabel.numberOfLines = 2;
        _addressLabel.textColor = [UIColor blackColor];
        _addressLabel.backgroundColor = [UIColor clearColor];
        _addressLabel.font = [UIFont systemFontOfSize:kSmallFont];
        [_addressView addSubview:_addressLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _addressView.height-0.5, kMainScreenWidth, 0.5)];
        line.backgroundColor = kLineColor;
        [_addressView addSubview:line];
    }
    return _addressView;
}

- (UIView *)logistView
{
    if (!_logistView) {
        _logistView = [[UIView alloc] initWithFrame:CGRectMake(0,self.addressView.bottom, kMainScreenWidth, kOrderFSHeight-self.addressView.height-self.orderStausView.height)];
        _logistView.backgroundColor = [UIColor whiteColor];
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
        icon.image = [UIImage imageNamed:@"logicIcon"];
        [icon setContentMode:UIViewContentModeScaleAspectFit];
        [_logistView addSubview:icon];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, kMainScreenWidth, _logistView.height)];
        title.textColor = [UIColor blackColor];
        title.font = [UIFont systemFontOfSize:kSmallFont];
        title.backgroundColor = [UIColor clearColor];
        title.text = @"物流信息";
        [_logistView addSubview:title];
        
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-10-17, _logistView.height/2.0 - 12.5, 15, 25)];
        [arrow setContentMode:UIViewContentModeScaleAspectFit];
        arrow.backgroundColor = [UIColor clearColor];
        arrow.image = [UIImage imageNamed:@"rightArrow"];
        [_logistView addSubview:arrow];
        
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchLogicView)];
        [_logistView addGestureRecognizer:gr];
    }
    return _logistView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, kMainScreenWidth, kOrderFSHeight);
        [self addSubview:self.orderStausView];
        [self addSubview:self.addressView];
        [self addSubview:self.logistView];
    }
    return self;
}



- (void)touchLogicView
{
    if ([self.delegate respondsToSelector:@selector(touchLogicCell)]) {
        [self.delegate touchLogicCell];
    }
}

- (void)setUIWithBuyer:(NSString *)buyer address:(NSString *)address moble:(NSString *)mobil statusDes:(NSString *)des isNeedLogicView:(BOOL)isNeed amount:(NSString *)money fee:(NSString *)fee
{
    _statusLabel.text = des;
    _transPriceLabel.text = [NSString stringWithFormat:@"运费金额：￥%@",fee];
    _mountPriceLabel.text = [NSString stringWithFormat:@"订单金额（含运费）￥%@",money];
    _nameLabel.text = [NSString stringWithFormat:@"收货人：%@",buyer];
    _addressLabel.text = [NSString stringWithFormat:@"收货地址：%@",address];
    _phoneLabel.text = mobil;
    self.height = isNeed ? kOrderFSHeight : kOrderFSHeight-self.logistView.height;
    self.logistView.hidden = isNeed ? NO : YES;
}

@end
