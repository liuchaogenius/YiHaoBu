//
//  YHBShoppingCartTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/10.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShoppingCartTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ChangeCountView.h"
#define cellHeight 80
@implementation YHBShoppingCartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        CGFloat line = kMainScreenWidth-75;
        self.chooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, (cellHeight-25)/2, 25, 25)];
        [self.chooseBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
//        self.chooseBtn.layer.borderColor = [[UIColor blackColor] CGColor];
//        self.chooseBtn.layer.borderWidth = 0.5;
        [self.chooseBtn setImage:[UIImage imageNamed:@"shopNotChooseImg"] forState:UIControlStateNormal];
        [self addSubview:self.chooseBtn];
        
        shopImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.chooseBtn.right+10, 10, 60, 60)];
        shopImgView.backgroundColor = KColor;
        [self addSubview:shopImgView];
        
        float labelX = shopImgView.right+10;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, shopImgView.top, line-labelX-5, 36)];
        titleLabel.numberOfLines = 2;
        titleLabel.font = kFont15;
//        titleLabel.text = @"素色 夏季薄麻布";
        [self addSubview:titleLabel];
        
        catLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom+5, line-labelX-5, 18)];
        catLabel.textColor = [UIColor lightGrayColor];
        catLabel.font = kFont15;
//        catLabel.text = @"类别 : 纯色亚麻布";
        [self addSubview:catLabel];
        
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(line, catLabel.top-23, 75, 18)];
        priceLabel.font = kFont15;
        priceLabel.textAlignment = NSTextAlignmentCenter;
        //        priceLabel.text = @"￥260.00";
        priceLabel.textColor = KColor;
        [self addSubview:priceLabel];
        
        countLabel = [[UILabel alloc] initWithFrame:CGRectMake(line, catLabel.top, 75, 20)];
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.font = kFont15;
        //        countLabel.text = @"×1";
        [self addSubview:countLabel];
        
        changeView = [[ChangeCountView alloc] initWithFrame:CGRectMake(line, catLabel.top, 65, 20)];
        [self addSubview:changeView];
        
        UIView *bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-0.3, kMainScreenWidth, 0.3)];
        bottomline.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomline];
    }
    return self;
}

- (void)isEdit:(BOOL)aBool
{
    if (aBool)
    {
        changeView.hidden = NO;
        countLabel.hidden = YES;
    }
    else
    {
        changeView.hidden = YES;
        countLabel.hidden = NO;
    }
}

- (void)chooseBtn:(UIButton *)aBtn
{
    if (_isSelected==NO)
    {
        [self.chooseBtn setImage:[UIImage imageNamed:@"shopChooseImg"] forState:UIControlStateNormal];
    }
    else
    {
        [self.chooseBtn setImage:[UIImage imageNamed:@"shopNotChooseImg"] forState:UIControlStateNormal];
    }
    [self.delegate touchCell:self WithSection:_section row:_row];
    _isSelected = !_isSelected;
}

- (void)selectedBtnNo
{
    [self.chooseBtn setImage:[UIImage imageNamed:@"shopNotChooseImg"] forState:UIControlStateNormal];
    _isSelected=NO;
}

- (void)selectedBtnYes
{
    [self.chooseBtn setImage:[UIImage imageNamed:@"shopChooseImg"] forState:UIControlStateNormal];
    _isSelected=YES;
}

- (void)setCellWithModel:(YHBShopCartCartlist *)aModel
{
    [shopImgView sd_setImageWithURL:[NSURL URLWithString:aModel.thumb]];
    countLabel.text = [NSString stringWithFormat:@"×%@", aModel.number];
    [changeView setCountLabel:[aModel.number floatValue]];
    titleLabel.text = aModel.title;
    priceLabel.text = [NSString stringWithFormat:@"￥%@",aModel.price];
    if (aModel.catname)
    {
        catLabel.text = [NSString stringWithFormat:@"类别 : %@", aModel.catname];
    }
    else
    {
        catLabel.text = @"";
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
