//
//  YHBShoppingCartTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/10.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShoppingCartTableViewCell.h"
#import "UIImageView+WebCache.h"
#define cellHeight 100
@implementation YHBShoppingCartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        CGFloat line = kMainScreenWidth-75;
        UIView *chooseView = [[UIView alloc] initWithFrame:CGRectMake(5, (cellHeight-30)/2, 30, 30)];
        chooseView.backgroundColor = KColor;
        [self addSubview:chooseView];
        
        shopImgView = [[UIImageView alloc] initWithFrame:CGRectMake(chooseView.right+5, (cellHeight-80)/2, 80, 80)];
        shopImgView.backgroundColor = KColor;
        [self addSubview:shopImgView];
        
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(line, 25, 75, 15)];
        priceLabel.font = kFont14;
        priceLabel.textAlignment = NSTextAlignmentCenter;
//        priceLabel.text = @"￥260.00";
        priceLabel.textColor = KColor;
        [self addSubview:priceLabel];
        
        countLabel = [[UILabel alloc] initWithFrame:CGRectMake(line, 45, 75, 15)];
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.font = kFont14;
//        countLabel.text = @"×1";
        [self addSubview:countLabel];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 20, line-125-5, 20)];
        titleLabel.font = kFont14;
//        titleLabel.text = @"素色 夏季薄麻布";
        [self addSubview:titleLabel];
        
        catLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, titleLabel.bottom+10, line-125-5, 20)];
        catLabel.textColor = [UIColor lightGrayColor];
        catLabel.font = kFont14;
//        catLabel.text = @"类别 : 纯色亚麻布";
        [self addSubview:catLabel];
    }
    return self;
}

- (void)setCellWithModel:(YHBShopCartCartlist *)aModel
{
    [shopImgView sd_setImageWithURL:[NSURL URLWithString:aModel.thumb]];
    countLabel.text = [NSString stringWithFormat:@"×%@", aModel.number];
    titleLabel.text = aModel.title;
    priceLabel.text = [NSString stringWithFormat:@"￥%@",aModel.price];
    catLabel.text = aModel.catname;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
