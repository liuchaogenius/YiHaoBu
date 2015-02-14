//
//  YHBProductListsCell.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/17.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBProductListsCell.h"
#import "UIImageView+WebCache.h"
#define kCellHeight 80
#define kTitleFont 16
#define kPriceFont 15
#define kImageWidth (kCellHeight-20)*11/10.0

@interface YHBProductListsCell ()

@property (strong, nonatomic) UIImageView *prodImgeView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;

@end

@implementation YHBProductListsCell

- (UIImageView *)prodImgeView
{
    if (!_prodImgeView) {
        _prodImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kImageWidth, kCellHeight-20)];
        _prodImgeView.layer.borderColor = [kLineColor CGColor];
        _prodImgeView.layer.borderWidth = 0.5;
        _prodImgeView.backgroundColor = [UIColor whiteColor];
        _prodImgeView.clipsToBounds = YES;
        [_prodImgeView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _prodImgeView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.prodImgeView.right+10, self.prodImgeView.top, kMainScreenWidth-self.prodImgeView.right-10, self.prodImgeView.height*2/3.0)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:kTitleFont];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+2, self.titleLabel.width, self.prodImgeView.height/3.0)];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textColor = KColor;
        _priceLabel.font = [UIFont systemFontOfSize:kPriceFont];
    }
    return _priceLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.prodImgeView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
    }
    return self;
}

- (void)setUIWithImage:(NSString *)urlStr Title:(NSString *)title Price: (double)price
{
    [self.prodImgeView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"DefualtProduct"] options:SDWebImageCacheMemoryOnly];
    self.titleLabel.text = title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",price];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
