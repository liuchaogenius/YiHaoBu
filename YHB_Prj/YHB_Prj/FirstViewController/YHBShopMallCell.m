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

#define kTitlefont 11
#define kPricefont 13
#define kDateFont 10

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


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.frame = CGRectMake(0, 0, kMainScreenWidth, kcellHeight);
    self.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i<3; i++) {
        [self.contentView addSubview:[self customViewWithNum:i]];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (UIView *)customViewWithNum:(int)num
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(num*kCViewWidth, 0, kCViewWidth, kcellHeight)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSpaceWidth, 10, kImageWidth, kImageHeight)];
    self.imageViewArray[num] = imageView;
    [view addSubview:imageView];
    if (isTest) imageView.backgroundColor = [UIColor blueColor];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kSpaceWidth, imageView.bottom+5, kImageWidth*2/3, 18)];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.font = [UIFont systemFontOfSize:kTitlefont];
    self.titleLabelArray[num] = titleLable;
    [view addSubview:titleLable];
    if(isTest) titleLable.text = @"寻地龙力步";
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right-2*kImageWidth/3.0f,imageView.bottom + 5, 2*kImageWidth/3.0, kPricefont)];
    priceLabel.centerY = titleLable.centerY;
    priceLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:priceLabel];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:kPricefont];
    self.priceLabelArray[num] = priceLabel;
    if(isTest) priceLabel.text = @"￥200";
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left, titleLable.bottom+2, kImageWidth, kDateFont)];
    dateLabel.textColor = [UIColor lightGrayColor];
    dateLabel.font = [UIFont systemFontOfSize:kDateFont];
    [view addSubview:dateLabel];
    self.dateLabelArray[num] = dateLabel;
    if(isTest) dateLabel.text = @"2014-10-27";
    
    UITapGestureRecognizer *taprz = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCellPart:)];
    [view addGestureRecognizer:taprz];
    
    view.tag = num;
    return view;
}

- (void)clearCellContentParts
{
    for (int i = 0; i < 3; i++) {
        ((UILabel *)self.priceLabelArray[i]).text = @"";
        ((UILabel *)self.dateLabelArray[i]).text = @"";
        ((UILabel *)self.titleLabelArray[i]).text = @"";
        ((UIImageView *)self.imageViewArray[i]).image = nil;
    }
}

- (void)touchCellPart : (UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    //MLOG(@"%d,%d",self.cellIndexPath.section,self.cellIndexPath.row);
    NSInteger tag = view.tag;
    if ([self.delegate respondsToSelector:@selector(selectCellPartWithIndexPath:part:)]) {
        [self.delegate selectCellPartWithIndexPath:self.cellIndexPath part:tag];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
