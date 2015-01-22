//
//  PriceDetailTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/1/22.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceDetailRslist.h"

@interface PriceDetailTableViewCell : UITableViewCell

@property(nonatomic, strong) UIImageView *goodImgView;
@property(nonatomic, strong) UILabel *goodTitleLabel;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *goodEditTimeLabel;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *typeLabel;
@property(nonatomic, strong) UIView *bottomLineView;
@property(nonatomic, strong) UIView *noteView;
@property(nonatomic, strong) UILabel *noteLabel;

- (void)setCellWithModel:(PriceDetailRslist *)aModel;
@end
