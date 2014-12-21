//
//  GoodsTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 12/12/6.
//  Copyright (c) 2012年 striveliu. All rights reserved.
//

#import "GoodsTableViewCell.h"
#import "UIImageView+WebCache.h"

#define cellHeight 80
@implementation GoodsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.goodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        
//        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 0.25)];
//        topLineView.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:topLineView];
        
        self.goodTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodImgView.right+10, self.goodImgView.top, kMainScreenWidth-self.goodImgView.right-10, 17)];
        self.goodTitleLabel.font = kFont16;
        
        self.vipImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.goodTitleLabel.right, self.goodTitleLabel.top, 24, 17)];
        self.vipImgView.image = [UIImage imageNamed:@"vipImg"];
        self.vipImgView.hidden = YES;
        
        self.goodTypeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-90, self.goodTitleLabel.bottom+10, 80, 17)];
        self.goodTypeNameLabel.textColor = [UIColor redColor];
        self.goodTypeNameLabel.textAlignment = NSTextAlignmentRight;
        self.goodTypeNameLabel.font = kFont14;
        
        self.goodCatNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodTitleLabel.left, self.goodTypeNameLabel.top, 41, 17)];
        self.goodCatNameLabel.text = @"分类 : ";
        self.goodCatNameLabel.font = kFont14;
        
        self.goodCatDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodCatNameLabel.right, self.goodCatNameLabel.top, self.goodTypeNameLabel.left-self.goodCatNameLabel.right, 34)];
        self.goodCatDetailLabel.numberOfLines = 2;
        self.goodCatDetailLabel.textColor = [UIColor lightGrayColor];
        self.goodCatDetailLabel.font = kFont14;
        
        self.goodEditTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodTypeNameLabel.left, self.goodTypeNameLabel.bottom+5, 80, 15)];
        self.goodEditTimeLabel.font = kFont12;
        self.goodEditTimeLabel.textAlignment = NSTextAlignmentRight;
        self.goodEditTimeLabel.textColor = [UIColor lightGrayColor];
        
//        self.goodSkimCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 68, 80, 15)];
//        self.goodSkimCountLabel.font = kFont12;
//        self.goodSkimCountLabel.textColor = [UIColor lightGrayColor];
//        
//        self.goodPaidView = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-60, 10, 40, 40)];
//        self.goodPaidView.backgroundColor = KColor;
        
//        UILabel *paidLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
//        paidLabel.textAlignment = NSTextAlignmentCenter;
//        paidLabel.font = kFont14;
//        paidLabel.text = @"偿";
//        paidLabel.textColor = [UIColor whiteColor];
//        [self.goodPaidView addSubview:paidLabel];
        
//        self.goodPaidPriceView = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 40, 20)];
//        self.goodPaidPriceView.textAlignment = NSTextAlignmentCenter;
//        self.goodPaidPriceView.font = kFont14;
//        self.goodPaidPriceView.textColor = [UIColor whiteColor];
//        [self.goodPaidView addSubview:self.goodPaidPriceView];
        
        
        [self addSubview:self.goodImgView];
        [self addSubview:self.goodTitleLabel];
        [self addSubview:self.goodCatNameLabel];
        [self addSubview:self.goodTypeNameLabel];
        [self addSubview:self.goodEditTimeLabel];
        [self addSubview:self.goodCatDetailLabel];
        [self addSubview:self.vipImgView];
//        [self addSubview:self.goodSkimCountLabel];
//        [self addSubview:self.goodPaidView];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-0.3, kMainScreenWidth, 0.3)];
        bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomLineView];
    }
    return self;
}

-(void)setCellWithGoodImage:(NSString *)aImageUrl title:(NSString *)aTitle catName:(NSString *)aCatName typeName:(NSString *)aTypeName editTime:(NSString *)aEditTime isVip:(BOOL)aIsVip
{
    [self setCellWithGoodImage:aImageUrl title:aTitle catName:aCatName typeName:aTypeName editTime:aEditTime skimCount:0 paidPrice:0 isVip:aIsVip];
}

- (void)setCellWithGoodImage:(NSString *)aImageUrl title:(NSString *)aTitle catName:(NSString *)aCatName typeName:(NSString *)aTypeName editTime:(NSString *)aEditTime skimCount:(int)aSkimCount paidPrice:(int)aPrice isVip:(BOOL)aIsVip
{
//    self.goodPaidView.hidden = YES;
    if (aImageUrl)
    {
        [self.goodImgView sd_setImageWithURL:[NSURL URLWithString:aImageUrl]];
    }
    
    if (aTitle)
    {
        self.goodTitleLabel.text = aTitle;
        CGSize strSize = [aTitle sizeWithFont:kFont16];
        CGRect temFrame = self.goodTitleLabel.frame;
        if (strSize.width+temFrame.origin.x>kMainScreenWidth-50)
        {
            strSize.width = kMainScreenWidth-50-temFrame.origin.x;
        }
        temFrame.size.width = strSize.width;
        self.goodTitleLabel.frame = temFrame;
        CGRect vipFrame = self.vipImgView.frame;
        vipFrame.origin.x = self.goodTitleLabel.right+3;
        self.vipImgView.frame = vipFrame;
    }
    else
    {
        self.goodTitleLabel.text = @"未命名";
    }
    
    
    if (aTypeName)
    {
        self.goodTypeNameLabel.text = [NSString stringWithFormat:@"状态 : %@", aTypeName];
    }
    else
    {
        self.goodTypeNameLabel.text = @"";
    }
    
    CGRect typeNameFrame = CGRectMake(kMainScreenWidth-90, self.goodTitleLabel.bottom+10, 80, 15);
    self.goodTypeNameLabel.frame = typeNameFrame;
    
    CGRect catNameFrame = CGRectMake(self.goodCatNameLabel.right, self.goodCatNameLabel.top, self.goodTypeNameLabel.left-self.goodCatNameLabel.right, 17);
    self.goodCatDetailLabel.frame = catNameFrame;
    
    CGSize typeSize = [self.goodTypeNameLabel.text sizeWithFont:kFont14];
    if (typeSize.width>80)
    {
        CGRect temTypeFrame = self.goodTypeNameLabel.frame;
        temTypeFrame.size.width = typeSize.width;
        temTypeFrame.origin.x = kMainScreenWidth-10-typeSize.width;
        self.goodTypeNameLabel.frame = temTypeFrame;
        
        CGRect temCatFrame = self.goodCatDetailLabel.frame;
        temCatFrame.size.width -= typeSize.width-80;
        self.goodCatDetailLabel.frame = temCatFrame;
    }
    
    self.goodCatDetailLabel.numberOfLines=1;
    if (aCatName)
    {
        self.goodCatDetailLabel.text = aCatName;
        CGSize strSize = [aCatName sizeWithFont:kFont14];
        if (strSize.width>self.goodTypeNameLabel.left-self.goodCatNameLabel.right) {
            self.goodCatDetailLabel.numberOfLines = 2;
            CGRect temFrame = self.goodCatDetailLabel.frame;
            temFrame.size.height = 34;
            self.goodCatDetailLabel.frame = temFrame;
        }
    }
    else
    {
        self.goodCatNameLabel.text = @"";
    }
    
    if (aEditTime)
    {
        self.goodEditTimeLabel.text = aEditTime;
    }
    else
    {
        self.goodEditTimeLabel.text = @"";
    }
    
    if (aIsVip==1)
    {
        self.vipImgView.hidden=NO;
    }
    else
    {
        self.vipImgView.hidden=YES;
    }
    
//    if (aSkimCount)
//    {
//        self.goodSkimCountLabel.text = [NSString stringWithFormat:@"浏览 : %d", aSkimCount];
//    }
//    else
//    {
//        self.goodSkimCountLabel.text = @"浏览 : 0";
//    }
    
//    if (aPrice && aPrice>0)
//    {
//        self.goodPaidView.hidden = 0;
//        self.goodPaidPriceView.text = [NSString stringWithFormat:@"￥%d", aPrice];
//    }
//    else
//    {
//        self.goodPaidView.hidden = YES;
//    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
