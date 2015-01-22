//
//  YHBOrderAddressView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderAddressView.h"
#define kIconWidth 22
#define kTitleFont 14
#define kSmallFont 12
@interface YHBOrderAddressView()

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *phoneLabel;
@property (strong, nonatomic) UILabel *addressLabel;

@end

@implementation YHBOrderAddressView

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+kIconWidth+5, 10, 140, kTitleFont)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _phoneLabel.font = [UIFont systemFontOfSize:kTitleFont];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2.0+30, _nameLabel.top, kMainScreenWidth/2.0-40, kTitleFont)];
        _phoneLabel.backgroundColor = [UIColor clearColor];
        _phoneLabel.textColor = [UIColor whiteColor];
        _phoneLabel.font = [UIFont systemFontOfSize:kTitleFont];
    }
    return _phoneLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+kIconWidth+5, _phoneLabel.bottom+15, kMainScreenWidth-20-5-kIconWidth-25, kTitleFont*3)];
        _addressLabel.backgroundColor = [UIColor clearColor];
        _addressLabel.textColor = [UIColor whiteColor];
        _addressLabel.font = [UIFont systemFontOfSize:kTitleFont];
        _addressLabel.numberOfLines = 2;
    }
    return _addressLabel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainScreenWidth, kAddressHeight);
        self.backgroundColor = RGBCOLOR(3, 152, 26);
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.addressLabel];
        [self addSubview:[self getArrowImageViewWithFrame:CGRectMake(kMainScreenWidth-10-15, (self.height-25)/2.0, 15, 25)]];
        [self addSubview:[self getAddIconWithFrame:CGRectMake(10, self.height/2.0, 22, 28)]];
    }
    return self;
}

- (void)setUIWithName:(NSString *)name Address:(NSString *)address Phone:(NSString *)phone
{
    self.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@",address];
    self.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",name];
    self.phoneLabel.text = phone;
}

- (UIImageView *)getAddIconWithFrame:(CGRect)frame
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    [imageview setContentMode:UIViewContentModeScaleAspectFit];
    imageview.backgroundColor = [UIColor clearColor];
    imageview.image = [UIImage imageNamed:@"Address"];
    
    return imageview;
}

- (UIImageView *)getArrowImageViewWithFrame:(CGRect)frame
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    [imageview setContentMode:UIViewContentModeScaleAspectFit];
    imageview.backgroundColor = [UIColor clearColor];
    imageview.image = [UIImage imageNamed:@"rightArrow"];
    
    return imageview;
}

@end
