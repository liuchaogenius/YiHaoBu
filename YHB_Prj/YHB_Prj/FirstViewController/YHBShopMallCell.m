//
//  YHBShopMallCell.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/19.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShopMallCell.h"
#import "UIImageView+WebCache.h"
#define isTest 1

#define kSpaceWidth 5
#define kCViewWidth kMainScreenWidth/3.0
#define kImageWidth (kCViewWidth-2*kSpaceWidth)
#define kImageHeight (kImageWidth*292/340.0f)

#define kTitlefont 11
#define kPricefont 13
#define kDateFont 10
#define kIconWidth 10
#define kSeeLabelWidth 30

@interface YHBShopMallCell()

@property (strong, nonatomic) UIImageView *aImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel; //需自加前缀￥
@property (strong, nonatomic) UILabel *dateLable;
@property (strong, nonatomic) UIView *midBlankView;
@property (strong, nonatomic) UIView *rightBlankView;

@end

@implementation YHBShopMallCell

#pragma mark - getter and setter
- (NSMutableArray *)totalViewArray
{
    if (!_totalViewArray) {
        _totalViewArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _totalViewArray;
}

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

- (UIView *)midBlankView
{
    if (!_midBlankView) {
        _midBlankView = [[UIView alloc] initWithFrame:CGRectMake(1*kCViewWidth, 0, kCViewWidth, kcellHeight)];
        _midBlankView.backgroundColor = [UIColor whiteColor];
    }
    return _midBlankView;
}

- (UIView *)rightBlankView
{
    if (!_rightBlankView) {
        _rightBlankView = [[UIView alloc] initWithFrame:CGRectMake(2*kCViewWidth, 0, kCViewWidth, kcellHeight)];
        _rightBlankView.backgroundColor = [UIColor whiteColor];
    }
    return _rightBlankView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andType:(NSInteger)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.frame = CGRectMake(0, 0, kMainScreenWidth, kcellHeight);
    self.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i<3; i++) {
        [self.contentView addSubview:[self customViewWithNum:i andType:type]];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setBlankWithPart:(int)part
{
    part == right_part ? [self addSubview:self.rightBlankView] : [self addSubview:self.midBlankView];
}

- (void)clearCellContentParts
{
    int i;
    for (i = 0; i < self.titleLabelArray.count; i++) {
        ((UILabel *)self.titleLabelArray[i]).text = @"";
    }
    for (i = 0; i < self.priceLabelArray.count; i++) {
        ((UILabel *)self.priceLabelArray[i]).text = @"";
    }
    for (i = 0; i < self.dateLabelArray.count; i++) {
        ((UILabel *)self.dateLabelArray[i]).text = @"";
    }
    for (i = 0; i < self.totalViewArray.count; i++) {
        ((UILabel *)self.totalViewArray[i]).text = @"";
    }
    for (i = 0; i < self.totalViewArray.count; i++) {
        ((UIImageView *)self.imageViewArray[i]).image = nil;
    }
    if(_midBlankView && [_midBlankView superview]) [_midBlankView removeFromSuperview];
    if(_rightBlankView && [_rightBlankView superview]) [_rightBlankView removeFromSuperview];
}

#pragma mark - refreshUI
- (void)setImage:(NSString *)imgurl title:(NSString *)title price:(NSString *)price part:(int)part
{
    UILabel *titleLabel = self.titleLabelArray[part];
    titleLabel.text = title;
    UILabel *priceLabel = self.priceLabelArray[part];
    priceLabel.text = price.length ? [NSString stringWithFormat:@"￥%@",price] : @"";
    UIImageView *imageView = self.imageViewArray[part];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"DefualtProduct"]];
}

- (void)setImage:(NSString *)imgurl title:(NSString *)title time:(NSString *)time hits:(int)hits part:(int)part
{
    UILabel *titleLabel = self.titleLabelArray[part];
    titleLabel.text = title;
    UIImageView *imageView = self.imageViewArray[part];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"DefualtProduct"]];
    UILabel *datelabel = self.dateLabelArray[part];
    datelabel.text = time;
    UILabel *hitsLabel = self.totalViewArray[part];
    hitsLabel.text = [NSString stringWithFormat:@"%d",hits];
}

#pragma mark - touch action
- (void)touchCellPart : (UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    //MLOG(@"%d,%d",self.cellIndexPath.section,self.cellIndexPath.row);
    NSInteger tag = view.tag;
    if ([self.delegate respondsToSelector:@selector(selectCellPartWithIndexPath:part:)]) {
        [self.delegate selectCellPartWithIndexPath:self.cellIndexPath part:tag];
    }
    
}

- (UIView *)customViewWithNum:(int)num andType:(NSInteger)type
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(num*kCViewWidth, 0, kCViewWidth, kcellHeight)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSpaceWidth, 10, kImageWidth, kImageHeight)];
    self.imageViewArray[num] = imageView;
    [view addSubview:imageView];
    if (isTest) imageView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(kSpaceWidth, imageView.bottom+5, kImageWidth, kTitlefont*2+5)];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.textColor = [UIColor lightGrayColor];
    titleLable.numberOfLines = 2;
    titleLable.font = [UIFont systemFontOfSize:kTitlefont];
    self.titleLabelArray[num] = titleLable;
    [view addSubview:titleLable];
    if(isTest) titleLable.text = @"寻地龙力步寻地龙力步寻地龙力步寻地龙力步寻地龙力步";
    
    if (type == 0) {
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left,titleLable.bottom + 2, kImageWidth, kPricefont)];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:priceLabel];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.font = [UIFont systemFontOfSize:kPricefont];
        self.priceLabelArray[num] = priceLabel;
        if(isTest) priceLabel.text = @"￥200";
    }else{
        UIImageView *timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.left, titleLable.bottom+2, kIconWidth,kIconWidth)];
        timeIcon.image = [UIImage imageNamed:@"icon_time"];
        [timeIcon setContentMode:UIViewContentModeScaleAspectFit];
        [view addSubview:timeIcon];
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeIcon.right+2, titleLable.bottom+2, kImageWidth*1.5/3, kDateFont)];
        dateLabel.centerY = timeIcon.centerY;
        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.textColor = [UIColor lightGrayColor];
        dateLabel.font = [UIFont systemFontOfSize:kDateFont];
        [view addSubview:dateLabel];
        self.dateLabelArray[num] = dateLabel;
        if(isTest) dateLabel.text = @"10-27";
        
        UILabel *seeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.width*2/3.0f, titleLable.bottom+2, kImageWidth/3, kDateFont)];
        seeLabel.centerY = timeIcon.centerY;
        seeLabel.textColor = [UIColor lightGrayColor];
        seeLabel.font = [UIFont systemFontOfSize:kDateFont];
        seeLabel.textAlignment = NSTextAlignmentRight;
        [view addSubview:seeLabel];
        //self.totalViewArray[num] = seeLabel;
        self.totalViewArray[num] = seeLabel;
        if(isTest) seeLabel.text = @"100";
        
        UIImageView *seeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.right-53, titleLable.bottom+2, kIconWidth+30,kIconWidth)];
        seeIcon.image = [UIImage imageNamed:@"icon_eye"];
        [seeIcon setContentMode:UIViewContentModeScaleAspectFit];
        seeIcon.centerY = timeIcon.centerY;
        [view addSubview:seeIcon];
    }
    
    UITapGestureRecognizer *taprz = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCellPart:)];
    [view addGestureRecognizer:taprz];
    
    view.tag = num;
    return view;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
