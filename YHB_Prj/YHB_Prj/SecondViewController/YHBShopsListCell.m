//
//  YHBShopsListCell.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/17.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBShopsListCell.h"
#import "UIImageView+WebCache.h"
#define kCellHeight 80
#define kTitleFont 16
#define kSmallFont 13
#define kImageWidth (kCellHeight-20)*11/10.0

@interface YHBShopsListCell ()

@property (strong, nonatomic) UIImageView *shopImageView;
@property (strong, nonatomic) UIImageView *storeTag;
@property (strong, nonatomic) UIImageView *mallTag;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *star1Label;
@property (strong, nonatomic) UILabel *star2Label;

@end

@implementation YHBShopsListCell



- (UILabel *)star2Label
{
    if (!_star2Label) {
        _star2Label = [[UILabel alloc] initWithFrame:self.star1Label.frame];
        _star2Label.left = self.star1Label.right+10;
        _star2Label.backgroundColor = [UIColor clearColor];
        _star2Label.font = [UIFont systemFontOfSize:kSmallFont];
        _star2Label.textColor = [UIColor lightGrayColor];
    }
    return _star2Label;
}

- (UILabel *)star1Label
{
    if (!_star1Label) {
        _star1Label = [[UILabel alloc] initWithFrame:CGRectMake(self.shopImageView.right+10, self.nameLabel.bottom+10, 90, kSmallFont)];
        _star1Label.backgroundColor = [UIColor clearColor];
        _star1Label.textColor = [UIColor lightGrayColor];
        _star1Label.font = [UIFont systemFontOfSize:kSmallFont];
    }
    return _star1Label;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shopImageView.right+10, self.storeTag.bottom+10, 180, kSmallFont)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:kSmallFont];
    }
    return _nameLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.storeTag.right+10, 10, kMainScreenWidth-self.storeTag.right-20, self.storeTag.height)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel setFont:[UIFont systemFontOfSize:kTitleFont]];
        [_titleLabel setTextColor:[UIColor blackColor]];
    }
    return _titleLabel;
}

- (UIImageView *)storeTag
{
    if (!_storeTag) {
        _storeTag = [[UIImageView alloc] initWithFrame:CGRectMake(self.shopImageView.right+10, 10, 34, 15)];
        [_storeTag setImage:[UIImage imageNamed:@"storeTag"]];
        [_storeTag setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _storeTag;
}

- (UIImageView *)mallTag
{
    if (!_mallTag) {
        _mallTag = [[UIImageView alloc] initWithFrame:self.storeTag.frame];
        [_mallTag setImage:[UIImage imageNamed:@"mallTag"]];
        [_mallTag setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _mallTag;
}

- (UIImageView *)shopImageView
{
    if (!_shopImageView) {
        _shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kImageWidth, kCellHeight-20)];
        _shopImageView.layer.borderColor = [kLineColor CGColor];
        _shopImageView.layer.borderWidth = 0.5;
        _shopImageView.backgroundColor = [UIColor whiteColor];
        _shopImageView.clipsToBounds = YES;
        [_shopImageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _shopImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.shopImageView];
        [self.contentView addSubview:self.mallTag];
        [self.contentView addSubview:self.storeTag];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.star1Label];
        [self.contentView addSubview:self.star2Label];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUIWithImage:(NSString *)urlStr title:(NSString *)title Name:(NSString *)name Star1:(NSString *)star1 Star2:(NSString *)star2 GroupID:(int)groupID
{
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"DefualtProduct"]options:SDWebImageCacheMemoryOnly];
    self.nameLabel.text = [NSString stringWithFormat:@"掌柜：%@",name];
    self.titleLabel.text = title;
    self.star1Label.text = [NSString stringWithFormat:@"服务态度：%@",star1];
    self.star2Label.text = [NSString stringWithFormat:@"描述相符：%@",star2];
    self.mallTag.hidden =  groupID > 6 ? NO : YES ;
    self.storeTag.hidden = groupID > 6 ? YES : NO;
}

- (void)setUIWithImage:(NSString *)urlStr title:(NSString *)title Name:(NSString *)name GroupID:(int)groupID
{
    self.star1Label.hidden = YES;
    self.star2Label.hidden = YES;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"DefualtProduct"]options:SDWebImageCacheMemoryOnly];
    self.nameLabel.text = [NSString stringWithFormat:@"掌柜：%@",name];
    self.titleLabel.text = title;
    self.mallTag.hidden =  groupID > 6 ? NO : YES ;
    self.storeTag.hidden = groupID > 6 ? YES : NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
