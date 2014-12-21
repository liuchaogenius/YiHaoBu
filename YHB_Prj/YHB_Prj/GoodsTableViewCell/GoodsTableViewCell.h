//
//  GoodsTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/6.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsTableViewCell : UITableViewCell

@property(nonatomic, strong) UIImageView *goodImgView;
@property(nonatomic, strong) UILabel *goodTitleLabel;
@property(nonatomic, strong) UILabel *goodCatNameLabel;
@property(nonatomic, strong) UILabel *goodTypeNameLabel;
@property(nonatomic, strong) UILabel *goodEditTimeLabel;
@property(nonatomic, strong) UILabel *goodCatDetailLabel;
@property(nonatomic, strong) UIImageView *vipImgView;
//@property(nonatomic, strong) UILabel *goodSkimCountLabel;

//@property(nonatomic, strong) UIView *goodPaidView;
//@property(nonatomic, strong) UILabel *goodPaidPriceView;

- (void)setCellWithGoodImage:(NSString *)aImageUrl title:(NSString *)aTitle catName:(NSString *)aCatName typeName:(NSString *)aTypeName editTime:(NSString *)aEditTime isVip:(BOOL)aIsVip;
- (void)setCellWithGoodImage:(NSString *)aImageUrl title:(NSString *)aTitle catName:(NSString *)aCatName typeName:(NSString *)aTypeName editTime:(NSString *)aEditTime skimCount:(int)aSkimCount paidPrice:(int)aPrice isVip:(BOOL)aIsVip;
@end
