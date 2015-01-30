//
//  RecommendTableViewCell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "RecommendTableViewCell.h"

@interface RecommendTableViewCell()
{
    UIImageView *imgView;
    UIView *lineView;
    UILabel *timeLabel;
    UILabel *detailLabel;
}
@end

@implementation RecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 45, 45)];
        [self addSubview:imgView];

        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-80, 37, 80, 16)];
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
        detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 7, kMainScreenWidth-80-65, 45)];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.font = [UIFont systemFontOfSize:15];
        detailLabel.textColor = [UIColor lightGrayColor];
        detailLabel.numberOfLines = 2;
        [self addSubview:detailLabel];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 1)];
        lineView.backgroundColor = RGBACOLOR(207, 210, 213, 0.7);
        [self addSubview:lineView];
    }
    return self;
}

- (void)setCellWithModel:(NSString *)aModel
{
    
}

+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
