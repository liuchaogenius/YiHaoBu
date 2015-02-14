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

#define kSpaceWidth 10
#define kCViewWidth (kMainScreenWidth- 4*kSpaceWidth)/3.0
#define kImageWidth (kMainScreenWidth- 4*kSpaceWidth)/3.0
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

@property (strong, nonatomic) NSMutableArray *blackInfoArray;

@end

@implementation YHBShopMallCell

#pragma mark - getter and setter
- (NSMutableArray *)blackInfoArray
{
    if (!_blackInfoArray) {
        _blackInfoArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _blackInfoArray;
}

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
        _midBlankView = [[UIView alloc] initWithFrame:CGRectMake(10+(kCViewWidth+10), 0, kCViewWidth+10, self.height)];
        _midBlankView.backgroundColor = [UIColor whiteColor];
    }
    return _midBlankView;
}

- (UIView *)rightBlankView
{
    if (!_rightBlankView) {
        _rightBlankView = [[UIView alloc] initWithFrame:CGRectMake(10+2*(kCViewWidth+10), 0, kCViewWidth+10, self.height)];
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
    self.height = kcell2Height;
    UILabel *titleLabel = self.titleLabelArray[part];
    titleLabel.text = title;
    UIImageView *imageView = self.imageViewArray[part];
    MLOG(@"%@",imgurl);
    if (imgurl.length) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"DefualtProduct"]];
    }
    
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10+num*(kCViewWidth+10), 0, kCViewWidth, kcellHeight)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, kImageWidth, kImageHeight)];
    imageView.image = [UIImage imageNamed:@"DefaultProduct"];
    self.imageViewArray[num] = imageView;
    [view addSubview:imageView];

    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom+5, kImageWidth, kTitlefont*2+5)];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.textColor = RGBCOLOR(153, 153, 153);
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
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(imageView.left, imageView.bottom-kIconWidth-4, kImageWidth, kIconWidth+4)];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.7;
        self.blackInfoArray[num] = blackView;
        [view addSubview:blackView];
        
        UIImageView *timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.left, blackView.top+2, kIconWidth,kIconWidth)];
        timeIcon.image = [UIImage imageNamed:@"icon_time"];
        [timeIcon setContentMode:UIViewContentModeScaleAspectFit];
        [view addSubview:timeIcon];
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeIcon.right+2, timeIcon.top, kImageWidth*1.5/3, kDateFont)];
        dateLabel.centerY = timeIcon.centerY;
        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.font = [UIFont systemFontOfSize:kDateFont];
        [view addSubview:dateLabel];
        self.dateLabelArray[num] = dateLabel;

        
        UILabel *seeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.width*2/3.0f, blackView.top, kImageWidth/3, kDateFont)];
        seeLabel.centerY = timeIcon.centerY;
        seeLabel.textColor = [UIColor whiteColor];
        seeLabel.font = [UIFont systemFontOfSize:kDateFont];
        seeLabel.textAlignment = NSTextAlignmentRight;
        [view addSubview:seeLabel];
        //self.totalViewArray[num] = seeLabel;
        self.totalViewArray[num] = seeLabel;
        
        UIImageView *seeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.right-53, blackView.top, kIconWidth+30,kIconWidth)];
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
