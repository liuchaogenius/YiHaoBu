//
//  YHBOrderConfirmCell.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderConfirmCell.h"
#import "YHBNumControl.h"
#import "UIImageView+WebCache.h"
typedef enum : NSUInteger
{
    TextFiledNumber = 0,
    TextFieldMessage
}TextFieldType;
#define kProHeight 80
#define kTitleFont 14
#define kHightBtnWidth 65
#define kSmallFont 12
#define kNumCellHeight 50
#define kLogicCellheight 40
@interface YHBOrderConfirmCell()<UITextFieldDelegate,YHBNumControlDelegate>
{
    UIImageView *_productImageView;
    UILabel *_numberLabel;
    UILabel *_priceLabel;//单价
    UILabel *_skuLabel;
    UILabel *_productTitle;
    UILabel *_logicLabel;
}
@property (strong, nonatomic) UIView *productInfoCell;
@property (strong, nonatomic) UIView *numberCell;
@property (strong, nonatomic) UIView *logicCell;
@property (strong, nonatomic) UIView *messageCell;
@property (strong, nonatomic) YHBNumControl *numControl;
@property (strong, nonatomic) UITextField *messageTf;

@end

@implementation YHBOrderConfirmCell

- (UIView *)messageCell
{
    if (!_messageCell) {
        _messageCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kNumCellHeight)];
        self.messageTf = [[UITextField alloc] initWithFrame:CGRectMake(10, (kNumCellHeight-30)/2.0, kMainScreenWidth-20, 30)];
        [self.messageTf setBorderStyle:UITextBorderStyleRoundedRect];
        [self.messageTf setPlaceholder:@"给卖家留言"];
        self.messageTf.textColor = [UIColor blackColor];
        self.messageTf.font = kFont12;
        self.messageTf.tag = TextFieldMessage;
        self.messageTf.delegate = self;
        [_messageCell addSubview:_messageTf];
        
        [_messageCell addSubview:[self getLineWithX:0 AndY:_messageCell.height-1]];
    }
    return _messageCell;
}

-(UIView *)logicCell
{
    if (!_logicCell) {
        _logicCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kLogicCellheight)];
        _logicCell.backgroundColor = [UIColor whiteColor];
        UILabel *label = [self getTitleLabelWithHeight:kNumCellHeight Title:@"配送方式"];
        label.width = kMainScreenWidth - 30;
        label.height = kLogicCellheight;
        [_logicCell addSubview: label];
        _logicLabel = label;
        [_logicCell addSubview:[self getArrowImageViewWithFrame:CGRectMake(kMainScreenWidth-18-10, (kLogicCellheight-20)/2.0, 18, 20)]];
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchLogicCell)];
        [_logicCell addGestureRecognizer:gr];
        [_logicCell addSubview:[self getLineWithX:10 AndY:_logicCell.height-1]];
    }
    return _logicCell;
}

- (UIView *)numberCell
{
    if (!_numberCell) {
        _numberCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kNumCellHeight)];
        _numberCell.backgroundColor = [UIColor whiteColor];
        [_numberCell addSubview:[self getTitleLabelWithHeight:kNumCellHeight Title:@"购买数量"]];
        self.numControl = [[YHBNumControl alloc] init];
        self.numControl.numberTextfield.tag = TextFiledNumber;
        self.numControl.right = kMainScreenWidth-10;
        self.numControl.centerY = kNumCellHeight/2.0;
        self.numControl.delegate = self;
        [_numberCell addSubview:self.numControl];
        [_numberCell addSubview:[self getLineWithX:10 AndY:_numberCell.height-1]];
    }
    return _numberCell;
}

- (UIView *)productInfoCell
{
    if (!_productInfoCell) {
        _productInfoCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kProHeight)];
        _productInfoCell.backgroundColor = [UIColor whiteColor];
        
        _productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, (kProHeight-20), (kProHeight-20))];
        _productImageView.layer.borderColor = [kLineColor CGColor];
        _productImageView.layer.borderWidth = 0.5;
        [_productInfoCell addSubview:_productImageView];
        [_productImageView setContentMode:UIViewContentModeScaleAspectFill];
        _productImageView.clipsToBounds = YES;
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-100-10, _productImageView.top, 100, kTitleFont)];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.font = [UIFont systemFontOfSize:kTitleFont];
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [_productInfoCell addSubview:_priceLabel];
        
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-100, _priceLabel.bottom+5, 90, kTitleFont)];
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.font = [UIFont systemFontOfSize:kTitleFont];
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.textAlignment = NSTextAlignmentRight;
        [_productInfoCell addSubview:_numberLabel];
        
        
        _productTitle = [[UILabel alloc] initWithFrame:CGRectMake(_productImageView.right+10, _productImageView.top, kMainScreenWidth-_productImageView.right-10-kHightBtnWidth-10, kTitleFont*2.5)];
        _productTitle.numberOfLines = 2;
        _productTitle.textColor = [UIColor blackColor];
        _productTitle.font = [UIFont systemFontOfSize:kTitleFont];
        _productTitle.backgroundColor = [UIColor clearColor];
        _productTitle.textAlignment = NSTextAlignmentNatural;
        [_productInfoCell addSubview:_productTitle];
        
        _skuLabel = [[UILabel alloc] initWithFrame:CGRectMake(_productTitle.left, _productTitle.bottom+5, 200, kSmallFont)];
        _skuLabel.textColor = [UIColor lightGrayColor];
        _skuLabel.backgroundColor = [UIColor clearColor];
        _skuLabel.font = [UIFont systemFontOfSize:kSmallFont];
        [_productInfoCell addSubview:_skuLabel];
        
        [_productInfoCell addSubview:[self getLineWithX:10 AndY:_productInfoCell.height-1]];
    }
    return _productInfoCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainScreenWidth, kOrderCellHeight);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.productInfoCell];
        self.numberCell.top = self.productInfoCell.bottom;
        [self.contentView addSubview:self.numberCell];
        self.logicCell.top = self.numberCell.bottom;
        [self.contentView addSubview:self.logicCell];
        self.messageCell.top = self.logicCell.bottom;
        [self.contentView addSubview:self.messageCell];
        MLOG(@"%f",self.messageCell.bottom);
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUIWithTitle:(NSString *)title sku:(NSString *)sku price:(NSString *)price number:(NSString *)number isFloat:(BOOL)isFloat message:(NSString *)message Express:(NSString *)express exPrice:(NSString *)ePrice thumb:(NSString *)thumb
{
    _productTitle.text = title;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",price];
    _numberLabel.text = [NSString stringWithFormat:@"x%@",number];
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:[UIImage imageNamed:@"DefaultProduct"]];
    self.numControl.number = [number doubleValue];
    self.numControl.isNumFloat = isFloat;
    _skuLabel.text = [NSString stringWithFormat:@"分类:%@",sku];
    self.messageTf.text = message?:@"";
    _logicLabel.text = express ? [NSString stringWithFormat:@"配送方式 ：%@  价格：%@",express,ePrice] : @"无配送方式";
}

- (void)reSetNumber:(NSString *)number
{
    _numberLabel.text = [NSString stringWithFormat:@"x%@",number];
}

#pragma mark - Action
- (void)touchLogicCell
{
    if ((![_logicLabel.text isEqualToString:@"无配送方式"]) && [self.delegate respondsToSelector:@selector(touchExpressCellWithIndexPath:)]) {
        [self.delegate touchExpressCellWithIndexPath:self.cellIndexPath];
    }
}

- (void)numberControlValueDidChanged
{
    [self reSetNumber:self.numControl.numberTextfield.text];
    if ([self.delegate respondsToSelector:@selector(numberChangedWithValue:IndexPath:)]) {
        [self.delegate numberChangedWithValue:self.numControl.numberTextfield.text IndexPath:self.cellIndexPath];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == TextFieldMessage) {
        if([self.delegate respondsToSelector:@selector(touchMessageTextField:IndexPath:)])
           [self.delegate touchMessageTextField:textField IndexPath:self.cellIndexPath];
        return NO;
    }else{
        return YES;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)getLineWithX:(CGFloat)x AndY:(CGFloat)y
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, y, kMainScreenWidth-2*x, 0.6)];
    line.backgroundColor = kLineColor;
    
    return line;
}
- (UILabel *)getTitleLabelWithHeight:(CGFloat)height Title:(NSString *)titleStr
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 120, height)];
    title.backgroundColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:kTitleFont];
    title.textColor = [UIColor blackColor];
    title.text = titleStr;
    
    return title;
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
