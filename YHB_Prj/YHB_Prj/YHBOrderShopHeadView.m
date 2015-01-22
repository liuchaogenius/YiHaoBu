//
//  YHBOrderShopHeadView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderShopHeadView.h"

@interface YHBOrderShopHeadView()
{
    UILabel *_shopTitle;
}
@property (strong, nonatomic) UIView *shopInfoCell;

@end

@implementation YHBOrderShopHeadView

- (UIView *)shopInfoCell
{
    if (!_shopInfoCell) {
        _shopInfoCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kShopHeadHeight)];
        _shopTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 250, kShopHeadHeight)];
        _shopTitle.backgroundColor = [UIColor clearColor];
        _shopTitle.textColor = [UIColor blackColor];
        _shopTitle.font = [UIFont systemFontOfSize:14];
        [_shopInfoCell addSubview:_shopTitle];
        
       // [_shopInfoCell addSubview:[self getArrowImageViewWithFrame:CGRectMake(kMainScreenWidth-20, (kShopCellHeight-15)/2.0, 10, 15)]];
        //[_shopInfoCell addSubview:[self getLineWithX:10 AndY:_shopInfoCell.height-0.5]];
        _shopInfoCell.layer.borderColor = [kLineColor CGColor];
        _shopInfoCell.layer.borderWidth = 0.5;
    }
    return _shopInfoCell;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.shopInfoCell];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.frame = self.shopInfoCell.frame;
    }
    return self;
}

- (void)setUIWithTitle:(NSString *)title
{
    _shopTitle.text = title ? :@"";
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
