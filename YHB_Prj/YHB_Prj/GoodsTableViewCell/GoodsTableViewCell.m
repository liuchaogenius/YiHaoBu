//
//  GoodsTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 12/12/6.
//  Copyright (c) 2012年 striveliu. All rights reserved.
//

#import "GoodsTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation GoodsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.goodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 5, 80, 80)];
        self.layer.borderWidth=0.25;
        self.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        
        self.goodTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 8, kMainScreenWidth-85, 15)];
        self.goodTitleLabel.font = kFont15;
        
        self.goodCatNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 28, kMainScreenWidth-85, 15)];
        self.goodCatNameLabel.font = kFont12;
        
        self.goodTypeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 48, kMainScreenWidth-85, 15)];
        self.goodTypeNameLabel.textColor = [UIColor redColor];
        self.goodTypeNameLabel.font = kFont12;
        
        self.goodEditTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 68, 80, 15)];
        self.goodEditTimeLabel.font = kFont12;
        self.goodEditTimeLabel.textColor = [UIColor lightGrayColor];
        
        self.goodSkimCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 68, 80, 15)];
        self.goodSkimCountLabel.font = kFont12;
        self.goodSkimCountLabel.textColor = [UIColor lightGrayColor];
        
        self.goodPaidView = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-60, 10, 40, 40)];
        self.goodPaidView.backgroundColor = KColor;
        
        UILabel *paidLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        paidLabel.textAlignment = NSTextAlignmentCenter;
        paidLabel.font = kFont14;
        paidLabel.text = @"偿";
        paidLabel.textColor = [UIColor whiteColor];
        [self.goodPaidView addSubview:paidLabel];
        
        self.goodPaidPriceView = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 40, 20)];
        self.goodPaidPriceView.textAlignment = NSTextAlignmentCenter;
        self.goodPaidPriceView.font = kFont14;
        self.goodPaidPriceView.textColor = [UIColor whiteColor];
        [self.goodPaidView addSubview:self.goodPaidPriceView];
        
        
        [self addSubview:self.goodImgView];
        [self addSubview:self.goodTitleLabel];
        [self addSubview:self.goodCatNameLabel];
        [self addSubview:self.goodTypeNameLabel];
        [self addSubview:self.goodEditTimeLabel];
        [self addSubview:self.goodSkimCountLabel];
        [self addSubview:self.goodPaidView];
    }
    return self;
}

- (void)setCellWithGoodImage:(NSString *)aImageUrl title:(NSString *)aTitle catName:(NSString *)aCatName typeName:(NSString *)aTypeName editTime:(NSString *)aEditTime skimCount:(int)aSkimCount paidPrice:(int)aPrice
{
    self.goodPaidView.hidden = YES;
    if (aImageUrl)
    {
        [self.goodImgView sd_setImageWithURL:[NSURL URLWithString:aImageUrl]];
    }
    
    if (aTitle)
    {
        self.goodTitleLabel.text = aTitle;
    }
    else
    {
        self.goodTitleLabel.text = @"未命名";
    }
    
    if (aCatName)
    {
        self.goodCatNameLabel.text = [NSString stringWithFormat:@"面料分类 : %@", aCatName];
    }
    else
    {
        self.goodCatNameLabel.text = @"面料分类 : ";
    }
    
    if (aTypeName)
    {
        self.goodTypeNameLabel.text = [NSString stringWithFormat:@"状态 : %@", aTypeName];
    }
    else
    {
        self.goodTypeNameLabel.text = @"状态 : %@";
    }
    
    if (aEditTime)
    {
        self.goodEditTimeLabel.text = aEditTime;
    }
    else
    {
        self.goodEditTimeLabel.text = @"";
    }
    
    if (aSkimCount)
    {
        self.goodSkimCountLabel.text = [NSString stringWithFormat:@"浏览 : %d", aSkimCount];
    }
    else
    {
        self.goodSkimCountLabel.text = @"浏览 : 0";
    }
    
    if (aPrice && aPrice>0)
    {
        self.goodPaidView.hidden = 0;
        self.goodPaidPriceView.text = [NSString stringWithFormat:@"￥%d", aPrice];
    }
    else
    {
        self.goodPaidView.hidden = YES;
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
