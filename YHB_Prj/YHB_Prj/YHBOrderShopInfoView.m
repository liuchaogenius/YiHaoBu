//
//  YHBOrderShopInfoView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/19.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderShopInfoView.h"
#define kTitleFont 15

@interface YHBOrderShopInfoView ()

@property (strong, nonatomic) UILabel *shopTitleLabel;
@property (strong, nonatomic) UILabel *orderStatusLabel;

@end

@implementation YHBOrderShopInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainScreenWidth, kShopHeight);
        self.contentView.backgroundColor = [UIColor whiteColor];
        UILabel *shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, kShopHeight)];
        shopLabel.backgroundColor = [UIColor clearColor];
        shopLabel.textColor = [UIColor blackColor];
        shopLabel.font = [UIFont systemFontOfSize:kTitleFont];
        [self.contentView addSubview:shopLabel];
        _shopTitleLabel = shopLabel;
        
        UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-110, 0, 100, kShopHeight)];
        status.backgroundColor = [UIColor clearColor];
        status.textColor = KColor;
        status.font = kFont12;
        status.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:status];
        _orderStatusLabel = status;
        
        [self.contentView addSubview:[self getArrowImageViewWithFrame:CGRectMake(_shopTitleLabel.right+2, (kShopHeight-15)/2.0, 7, 15)]];
        
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchStoreInfoView:)];
        [self addGestureRecognizer:gr];
    }
    return self;
}

- (void)setUIWithCompany:(NSString *)com statusDes:(NSString *)des ItemID:(NSInteger)itemID
{
    self.tag = itemID;
    self.shopTitleLabel.text = com;
    self.orderStatusLabel.text = des;
}

- (void)touchStoreInfoView : (UITapGestureRecognizer *)gr
{
    if ([self.delegate respondsToSelector:@selector(touchShopWithItemID:)]) {
        [self.delegate touchShopWithItemID:self.tag];
    }
    
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
