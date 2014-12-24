//
//  YHBShopMallHeadView.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/19.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShopMallHeadView.h"
#define kfont 14
#define kImageHeight 26
@interface YHBShopMallHeadView()

@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UILabel *rightLabel;

@end

@implementation YHBShopMallHeadView

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLable.text = title;
}

- (void)setRightTitle:(NSString *)rightTitle
{
    _rightTitle = rightTitle;
    self.rightLabel.text = _rightTitle;
}


- (instancetype)init
{
    self = [super init];
    self.frame = CGRectMake(0, 0, kMainScreenWidth, kHeadViewHeight);
    self.backgroundColor = [UIColor whiteColor];
    //self.layer.borderWidth = 0.6;
    //self.layer.borderColor = [kLineColor CGColor];
    
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, (kHeadViewHeight-kfont)/2.0f, 100, kfont)];
    [self addSubview:self.titleLable];
    self.titleLable.font = [UIFont systemFontOfSize:kfont];
    self.title = @"";
    self.titleLable.text = self.title;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (kHeadViewHeight-kImageHeight)/2.0, kImageHeight, kImageHeight)];
    [self addSubview:self.imageView];
    
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+5+kImageHeight,(kHeadViewHeight-kfont)/2.0f, 100, kfont)];
    self.rightLabel.font = [UIFont systemFontOfSize:kfont];
    self.rightLabel.textColor = KColor;
    [self addSubview:self.rightLabel];
    
    return self;
}

@end
