//
//  YHBPdtInfoView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBPdtInfoView.h"

#define kPrice 16
#define ktext 12
#define kBtnWidth 35
@interface YHBPdtInfoView()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *cateLabel;

@end

@implementation YHBPdtInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainScreenWidth, kProductInfoViewHeight);
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void)creatUI
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kMainScreenWidth-30-kBtnWidth, kTitlefont*3)];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:kTitlefont];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.numberOfLines = 2;
    
    [self addSubview:self.titleLabel];
    //self.titleLabel.text = @"xxxxsdfsdfsgdfgdfgdsdfasdfasdfasdfgdxxx电视机";
    
    self.privateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.privateButton.frame = CGRectMake(kMainScreenWidth-kBtnWidth-20, 10, kBtnWidth,kBtnWidth*109/105.0);
    [self.privateButton setBackgroundImage:[UIImage imageNamed:@"privateImg"] forState:UIControlStateNormal];
    [self.privateButton setBackgroundImage:[UIImage imageNamed:@"privateHighImg"] forState:UIControlStateSelected];
    self.privateButton.selected = NO;
    //[self.privateButton addTarget:self action:@selector(touchPrivateButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.privateButton];
    
    UILabel *priceTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.bottom+5, kTitlefont*3, kTitlefont)];
    [priceTitle setFont:[UIFont systemFontOfSize:kTitlefont]];
    [priceTitle setTextColor:[UIColor lightGrayColor]];
    priceTitle.text = @"价格：";
    [self addSubview:priceTitle];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceTitle.right+10, 0, 100, kPrice)];
    self.priceLabel.textColor = KColor;
    //self.priceLabel.text = @"￥403";
    self.priceLabel.bottom = priceTitle.bottom;
    [self addSubview:self.priceLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.priceLabel.bottom+10, kMainScreenWidth, 0.5)];
    line.backgroundColor = kLineColor;
    [self addSubview:line];
    
    UILabel *cateTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, line.bottom+10, kTitlefont*3, kTitlefont)];
    [cateTitle setFont:[UIFont systemFontOfSize:kTitlefont]];
    [cateTitle setTextColor:[UIColor lightGrayColor]];
    cateTitle.text = @"分类：";
    [self addSubview:cateTitle];
    
    self.cateLabel = [[UILabel alloc] initWithFrame:CGRectMake(cateTitle.right+10, line.bottom+10, kMainScreenWidth-cateTitle.right-20, kTitlefont)];
    [self.cateLabel setFont:[UIFont systemFontOfSize:kTitlefont]];
    [self.cateLabel setTextColor:[UIColor lightGrayColor]];
    //self.cateLabel.text = @"印花，丝绸，窗帘";
    [self addSubview:self.cateLabel];
}

- (void)setTitle:(NSString *)title price:(NSString *)price cate:(NSString *)cateStr favorite:(int)favt
{
    self.titleLabel.text = title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",price];
    self.cateLabel.text = cateStr;
    self.privateButton.selected = favt ? true : false;
}

@end
