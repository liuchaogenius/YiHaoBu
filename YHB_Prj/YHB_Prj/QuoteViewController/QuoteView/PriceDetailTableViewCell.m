//
//  PriceDetailTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/22.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "PriceDetailTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation PriceDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.goodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        self.goodImgView.backgroundColor = KColor;
        [self addSubview:self.goodImgView];
        
        self.goodTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodImgView.right+10, self.goodImgView.top+5, kMainScreenWidth-self.goodImgView.right-140, 17)];
        self.goodTitleLabel.font = kFont15;
        self.goodTitleLabel.text = @"寻的龙你布";
        [self addSubview:self.goodTitleLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodImgView.right+10, self.goodTitleLabel.bottom+10, kMainScreenWidth-self.goodImgView.right-140, 15)];
        self.nameLabel.font = kFont12;
        self.nameLabel.text = @"掌柜 : 张三";
        [self addSubview:self.nameLabel];
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-40, self.goodTitleLabel.top, 30, 17)];
        self.typeLabel.font = kFont15;
        self.typeLabel.text = @"现货";
        self.typeLabel.textColor = KColor;
        [self addSubview:self.typeLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodTitleLabel.right+10, self.goodTitleLabel.top, self.typeLabel.left-self.goodTitleLabel.right-15, 17)];
        self.priceLabel.font = kFont15;
        self.priceLabel.text = @"￥11.5";
        self.priceLabel.textColor = KColor;
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.priceLabel];

        self.goodEditTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-100, self.nameLabel.top, 90, 15)];
        self.goodEditTimeLabel.font = kFont12;
        self.goodEditTimeLabel.text = @"2014-11-11";
        self.goodEditTimeLabel.textColor = [UIColor lightGrayColor];
        self.goodEditTimeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.goodEditTimeLabel];
        
        self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(10, self.goodImgView.bottom+10-0.3, kMainScreenWidth-20, 0.3)];
        self.bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.bottomLineView];
        
        self.noteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.goodImgView.bottom+10, kMainScreenWidth, 25)];
        [self addSubview:self.noteView];
        
        self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kMainScreenWidth-20, 15)];
        self.noteLabel.font = kFont12;
        self.noteLabel.text = @"备注 : 还轧空价格吧尽快吧";
        self.noteLabel.textColor = [UIColor lightGrayColor];
        [self.noteView addSubview:self.noteLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 25-0.3, kMainScreenWidth, 0.3)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.noteView addSubview:lineView];
    }
    return self;
}

- (void)setCellWithModel:(PriceDetailRslist *)aModel
{
    self.goodTitleLabel.text = aModel.company;
    [self.goodImgView sd_setImageWithURL:[NSURL URLWithString:aModel.avatar]];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", aModel.price];
    self.goodEditTimeLabel.text = aModel.adddate;
    self.typeLabel.text = aModel.typename;
    self.nameLabel.text = aModel.truename;
    if (aModel.note)
    {
        self.noteLabel.text = [NSString stringWithFormat:@"备注 : %@", aModel.note];
        self.noteView.hidden = NO;
        CGRect frame = CGRectMake(10, self.goodImgView.bottom+10-0.3, kMainScreenWidth-20, 0.3);
        self.bottomLineView.frame = frame;
    }
    else
    {
        self.noteView.hidden = YES;
        CGRect frame = CGRectMake(0, self.goodImgView.bottom+10-0.3, kMainScreenWidth, 0.3);
        self.bottomLineView.frame = frame;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
