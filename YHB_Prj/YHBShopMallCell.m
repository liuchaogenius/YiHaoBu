//
//  YHBShopMallCell.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/19.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShopMallCell.h"
#define isTest 1
#define kSpaceWidth 5
#define kCViewWidth kMainScreenWidth/3.0
#define kImageWidth (kCViewWidth-2*kSpaceWidth)
#define kImageHeight (kImageWidth*292/340.0f)

#define kTitlefont 12
#define kPricefont 16
#define kDateFont 11

@interface YHBShopMallCell()

@property (strong, nonatomic) UIImageView *aImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel; //需自加前缀￥
@property (strong, nonatomic) UILabel *dateLable;

@end

@implementation YHBShopMallCell

#pragma mark - getter and setter
- (NSMutableArray *)titleLabelArray
{
    if (!_titleLabelArray) {
        _titleLabelArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _titleLabelArray;
}

- (NSMutableArray *)priceLabelArray
{
    if (!_priceLabelArray) {
        _priceLabelArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _priceLabelArray;
}

- (NSMutableArray *)dateLabelArray
{
    if (!_dateLabelArray) {
        _dateLabelArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _dateLabelArray;
}

- (NSMutableArray *)imageViewArray
{
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _imageViewArray;
}

- (void)awakeFromNib {
    self.frame = CGRectMake(0, 0, kMainScreenWidth, kcellHeight);
    self.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i<3; i++) {
        [self.contentView addSubview:[self customViewWithNum:i]];
    }
}

- (UIView *)customViewWithNum:(int)num
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(num*kCViewWidth, 0, kCViewWidth, kcellHeight)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSpaceWidth, 10, kImageWidth, kImageHeight)];
    self.imageViewArray[num] = imageView;
    [view addSubview:imageView];
    if (isTest) imageView.backgroundColor = [UIColor blueColor];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kSpaceWidth, imageView.bottom+10, kImageWidth*2/3, 18)];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.font = [UIFont systemFontOfSize:kTitlefont];
    _titleLabel = titleLable;
    self.titleLabelArray[num] = titleLable;
    [view addSubview:titleLable];
    if(isTest) titleLable.text = @"寻地龙力步";
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right-kImageWidth/3.0f, 5, kImageWidth/3.0, kPricefont)];
    priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel = priceLabel;
    [view addSubview:priceLabel];
    self.priceLabelArray[num] = priceLabel;
    if(isTest) priceLabel.text = @"￥200";
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left, titleLable.bottom+10, kImageWidth, kDateFont)];
    dateLabel.textColor = [UIColor lightGrayColor];
    dateLabel.font = [UIFont systemFontOfSize:kDateFont];
    _dateLable = dateLabel;
    [view addSubview:dateLabel];
    self.dateLabelArray[num] = dateLabel;
    if(isTest) dateLabel.text = @"2014-10-27";
    
    return view;
}

- (void)clearCellContentPart:(int)part
{
    for (int i = 0; i < 3; i++) {
        ((UILabel *)self.priceLabelArray[i]).text = @"";
        ((UILabel *)self.dateLabelArray[i]).text = @"";
        ((UILabel *)self.titleLabelArray[i]).text = @"";
        ((UIImageView *)self.imageViewArray[i]).image = nil;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
