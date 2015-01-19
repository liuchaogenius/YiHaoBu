//
//  YHBOrderInfoView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/18.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderInfoView.h"
#define kTitleFont 16
#define kSmallFont 12
@interface YHBOrderInfoView ()

@end

@implementation YHBOrderInfoView

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kInfoViewHeight-25, kInfoViewHeight-20)];
        _headImageView.layer.borderColor = [kLineColor CGColor];
        _headImageView.layer.borderWidth = 0.5;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.backgroundColor = [UIColor whiteColor];
    }
    return _headImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.right+10, self.headImageView.top, kMainScreenWidth-self.headImageView.right-20, 40)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:kTitleFont];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.right+10, self.titleLabel.bottom+3, 120, kSmallFont)];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textColor = [UIColor lightGrayColor];
        _priceLabel.font = [UIFont systemFontOfSize:kSmallFont];
    }
    return _priceLabel;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLabel.right+5, self.priceLabel.top, kMainScreenWidth-self.priceLabel.right-10, kSmallFont)];
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.textColor = [UIColor lightGrayColor];
        _numberLabel.font = [UIFont systemFontOfSize:kSmallFont];
    }
    return _numberLabel;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kInfoViewHeight)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.numberLabel];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, self.bottom-1, kMainScreenWidth-10, 0.5)];
        line.backgroundColor = kLineColor;
        [self addSubview:line];
    }
    return self;
}


@end
