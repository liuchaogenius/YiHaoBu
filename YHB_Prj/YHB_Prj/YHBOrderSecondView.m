//
//  YHBOrderSecondView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/20.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderSecondView.h"
#import "UIImageView+WebCache.h"
#define kShopCellHeight 30
#define kProHeight 80
#define kTitleFont 14
#define kHightBtnWidth 65
#define kSmallFont 12
#define kPriceHeight 50
#define kCommHeight 75
@interface YHBOrderSecondView()
{
    UIImageView *_iconView;
    UILabel *_shopTitle;
    UILabel *_productTitle;
    UIImageView *_productImageView;
    UILabel *_numberLabel;
    UILabel *_priceLabel;//单价
    UILabel *_feeLabel;//运费
    UILabel *_totalPriceLabel;//总价
    UILabel *_smallShopTitle;
    UIButton *_actionButton;
}
@property (strong, nonatomic) UIView *shopInfoCell;
@property (strong, nonatomic) UIView *productInfoCell;
@property (strong, nonatomic) UIView *priceCell;
@property (strong, nonatomic) UIView *communicateCell;

@end

@implementation YHBOrderSecondView
#pragma mark - getter and setter
- (UIView *)communicateCell
{
    if (!_communicateCell) {
        _communicateCell = [[UIView alloc] initWithFrame:CGRectMake(0, self.priceCell.bottom, kMainScreenWidth, kCommHeight)];
        _communicateCell.backgroundColor = [UIColor whiteColor];
        //_feeLabel = [self getTitleLabelWithText:@"" Y:10 isLeft:YES isHighColor:NO];
        //[_communicateCell addSubview:_feeLabel];
        _smallShopTitle = [self getTitleLabelWithText:@"" Y:10 isLeft:YES isHighColor:NO];
        [_communicateCell addSubview:_smallShopTitle];
        //95 26
        CGFloat blankWidth = (kMainScreenWidth-20-3*95)/2.0;
        for (int i = 0; i < 3; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10+(95+blankWidth)*i, _smallShopTitle.bottom+10, 95, 26);
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"comBtn_%d",i+1]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(touchCommuBtn:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            [_communicateCell addSubview:button];
        }
        
    }
    return _communicateCell;
}

- (UIView *)priceCell
{
    if (!_priceCell) {
        _priceCell = [[UIView alloc] initWithFrame:CGRectMake(0, self.productInfoCell.bottom, kMainScreenWidth, kPriceHeight)];
        _priceCell.backgroundColor = [UIColor whiteColor];
        [_priceCell addSubview:[self getTitleLabelWithText:@"运费：" Y:10 isLeft:YES isHighColor:NO]];
        [_priceCell addSubview:[self getTitleLabelWithText:@"实付款(含运费)：" Y:10+kSmallFont+5 isLeft:YES isHighColor:NO]];
        _feeLabel = [self getTitleLabelWithText:@"" Y:10 isLeft:NO isHighColor:NO];
        [_priceCell addSubview:_feeLabel];
        _totalPriceLabel = [self getTitleLabelWithText:@"" Y:10+5+kSmallFont isLeft:NO isHighColor:YES];
        [_priceCell addSubview:_totalPriceLabel];
    }
    return _priceCell;
}


- (UIView *)shopInfoCell
{
    if (!_shopInfoCell) {
        _shopInfoCell= [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kShopCellHeight)];
        _shopInfoCell.backgroundColor = [UIColor whiteColor];
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (kShopCellHeight-20)/2.0, 40, 20)];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        _iconView.image = [UIImage imageNamed:@"storeTag"];
        [_iconView setContentMode:UIViewContentModeScaleAspectFit];
        [_shopInfoCell addSubview:_iconView];
        
        _shopTitle = [[UILabel alloc] initWithFrame:CGRectMake(_iconView.right+5, 0, 250, kShopCellHeight)];
        _shopTitle.backgroundColor = [UIColor clearColor];
        _shopTitle.textColor = [UIColor blackColor];
        _shopTitle.font = [UIFont systemFontOfSize:kTitleFont];
        [_shopInfoCell addSubview:_shopTitle];
        
        [_shopInfoCell addSubview:[self getArrowImageViewWithFrame:CGRectMake(kMainScreenWidth-20, (kShopCellHeight-15)/2.0, 10, 15)]];
        [_shopInfoCell addSubview:[self getLineWithX:10 AndY:_shopInfoCell.height-0.5]];
    }
    return _shopInfoCell;
}

- (UIView *)productInfoCell
{
    if (!_productInfoCell) {
        _productInfoCell = [[UIView alloc] initWithFrame:CGRectMake(0, self.shopInfoCell.bottom, kMainScreenWidth, kProHeight)];
        _productInfoCell.backgroundColor = [UIColor whiteColor];
        
        _productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, (kProHeight-20), (kProHeight-20))];
        _productImageView.layer.borderColor = [kLineColor CGColor];
        _productImageView.layer.borderWidth = 0.5;
        [_productInfoCell addSubview:_productImageView];
        
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
        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setBackgroundColor:KColor];
//        [btn setFrame:CGRectMake(kMainScreenWidth-10-kHightBtnWidth, _numberLabel.bottom+3, kHightBtnWidth, 26)];
//        [btn addTarget:self action:@selector(touchActionBtn) forControlEvents:UIControlEventTouchUpInside];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        btn.titleLabel.font = kFont14;
//        [_productInfoCell addSubview:btn];
//        _actionButton = btn;
        
        _productTitle = [[UILabel alloc] initWithFrame:CGRectMake(_productImageView.right+10, _productImageView.top, kMainScreenWidth-_productImageView.right-10-kHightBtnWidth-10, kTitleFont*2.5)];
        _productTitle.numberOfLines = 2;
        _productTitle.textColor = [UIColor blackColor];
        _productTitle.font = [UIFont systemFontOfSize:kTitleFont];
        _productTitle.backgroundColor = [UIColor clearColor];
        _productTitle.textAlignment = NSTextAlignmentNatural;
        [_productInfoCell addSubview:_productTitle];
        
        [_productInfoCell addSubview:[self getLineWithX:10 AndY:_productInfoCell.height-0.5]];
    }
    return _productInfoCell;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kShopCellHeight+kProHeight+kPriceHeight+kCommHeight)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shopInfoCell];
        [self addSubview:self.productInfoCell];
        [self addSubview:self.priceCell];
        [self addSubview:self.communicateCell];
    }
    return self;
}

- (void)setUIWithSellCom:(NSString *)sellCom Title:(NSString *)title Price:(NSString *)price Number:(NSString *)number fee:(NSString *)fee Money:(NSString *)money thumb:(NSString *)thumb
{

    _shopTitle.text = sellCom;
    _smallShopTitle.text = [NSString stringWithFormat:@"卖家：%@",sellCom];
    _productTitle.text = title;
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:thumb]];
    _numberLabel.text = [@"x" stringByAppendingString:number];
    _priceLabel.text = [@"￥" stringByAppendingString:price];
    _feeLabel.text = [@"￥" stringByAppendingString:fee];
    _totalPriceLabel.text = [@"￥" stringByAppendingString:money];
    
}

#pragma mark - Action

- (void)touchCommuBtn : (UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(touchCommunicateBtnWithTag:)]) {
        [self.delegate touchCommunicateBtnWithTag:sender.tag];
    }
}

- (UILabel *)getTitleLabelWithText:(NSString *)str Y:(CGFloat)y isLeft:(BOOL)isleft isHighColor:(BOOL)high
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((isleft?10:(kMainScreenWidth-10-200)), y, 200, kSmallFont)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = isleft ? NSTextAlignmentLeft : NSTextAlignmentRight;
    label.textColor = high ? KColor : [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:kSmallFont];
    label.text = str ;
    return label;
}

- (UIImageView *)getArrowImageViewWithFrame:(CGRect)frame
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    [imageview setContentMode:UIViewContentModeScaleAspectFit];
    imageview.backgroundColor = [UIColor clearColor];
    imageview.image = [UIImage imageNamed:@"rightArrow"];
    
    return imageview;
}

- (UIView *)getLineWithX:(CGFloat)x AndY:(CGFloat)y
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, y, kMainScreenWidth-2*x, 0.5)];
    line.backgroundColor = kLineColor;
    
    return line;
}

@end
