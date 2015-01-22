//
//  QuoteTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "QuoteTableViewCell.h"
#import "UIImageView+WebCache.h"

#define cellHeight 80
@implementation QuoteTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.goodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        self.goodImgView.backgroundColor = KColor;
        [self addSubview:self.goodImgView];
        
        self.goodTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodImgView.right+10, self.goodImgView.top, kMainScreenWidth-self.goodImgView.right-10, 17)];
        self.goodTitleLabel.font = kFont16;
//        self.goodTitleLabel.text = @"寻的龙你布";
        [self addSubview:self.goodTitleLabel];
        
        self.goodMountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodTitleLabel.left, self.goodTitleLabel.bottom+5, kMainScreenWidth-80-self.goodTitleLabel.left, 17)];
        self.goodMountLabel.font = kFont15;
//        self.goodMountLabel.text = @"求购数量 : 5000";
        [self addSubview:self.goodMountLabel];
        
        self.goodEditTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodTitleLabel.left, self.goodMountLabel.bottom+8, kMainScreenWidth-80-self.goodTitleLabel.left, 14)];
        self.goodEditTimeLabel.font = kFont12;
        self.goodEditTimeLabel.textColor = [UIColor lightGrayColor];
//        self.goodEditTimeLabel.text = @"2014-10-22";
        [self addSubview:self.goodEditTimeLabel];
        
        self.lookQuoteBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-70, self.goodMountLabel.top, 61, 28)];
        [self.lookQuoteBtn setImage:[UIImage imageNamed:@"LookQuote"] forState:UIControlStateNormal];
        [self addSubview:self.lookQuoteBtn];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-100, self.goodMountLabel.top, 90, 17)];
        self.priceLabel.font = kFont15;
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        self.priceLabel.textColor = KColor;
//        self.priceLabel.text = @"￥111.2";
        [self addSubview:self.priceLabel];
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-100, self.goodMountLabel.bottom+5, 90, 17)];
        self.typeLabel.font = kFont15;
        self.typeLabel.textAlignment = NSTextAlignmentRight;
        self.typeLabel.textColor = KColor;
//        self.typeLabel.text = @"预定";
        [self addSubview:self.typeLabel];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-0.3, kMainScreenWidth, 0.3)];
        bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomLineView];
    }
    return self;
}

- (void)setCellWithModelWithModel:(QuoteMeRslist *)aMeModel andModel:(QuoteRslist *)aModel isMe:(BOOL)aBool
{
    if (aBool)
    {
        self.typeLabel.hidden=NO;
        self.priceLabel.hidden=NO;
        self.lookQuoteBtn.hidden = YES;
        self.goodTitleLabel.text = aMeModel.title;
        [self.goodImgView sd_setImageWithURL:[NSURL URLWithString:aMeModel.thumb]];
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@", aMeModel.price];
        self.goodMountLabel.text = [NSString stringWithFormat:@"求购数量 : %@", aMeModel.amount];
        self.goodEditTimeLabel.text = aMeModel.adddate;
        self.typeLabel.text = aMeModel.typename;
    }
    else
    {
        self.typeLabel.hidden=YES;
        self.priceLabel.hidden=YES;
        self.lookQuoteBtn.hidden = NO;
        self.goodTitleLabel.text = aModel.title;
        [self.goodImgView sd_setImageWithURL:[NSURL URLWithString:aModel.thumb]];
        self.goodMountLabel.text = [NSString stringWithFormat:@"求购数量 : %@", aModel.amount];
        self.goodEditTimeLabel.text = aModel.adddate;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
