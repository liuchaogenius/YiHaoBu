//
//  QuoteTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuoteMeRslist.h"
#import "QuoteRslist.h"


@interface QuoteTableViewCell : UITableViewCell

@property(nonatomic, strong) UIImageView *goodImgView;
@property(nonatomic, strong) UILabel *goodTitleLabel;

@property(nonatomic, strong) UILabel *goodMountLabel;
@property(nonatomic, strong) UILabel *goodEditTimeLabel;

@property(nonatomic, strong) UIButton *lookQuoteBtn;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *typeLabel;

- (void)setCellWithModelWithModel:(QuoteMeRslist *)aMeModel andModel:(QuoteRslist *)aModel isMe:(BOOL)aBool;

@end
