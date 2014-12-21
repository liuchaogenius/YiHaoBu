//
//  YHBShoppingCartTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/10.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBShopCartCartlist.h"
#import "ChangeCountView.h"
@class YHBShoppingCartTableViewCell;
@protocol ShoppingCartCellDelegate <NSObject>

- (void)touchCell:(YHBShoppingCartTableViewCell *)aCell WithSection:(int)aSection row:(int)aRow;

@end


@interface YHBShoppingCartTableViewCell : UITableViewCell
{
    UIImageView *shopImgView;
    UILabel *priceLabel;
    UILabel *countLabel;
    UILabel *titleLabel;
    UILabel *catLabel;
    ChangeCountView *changeView;
}

@property (nonatomic, assign) long section;
@property (nonatomic, assign) long row;

@property(nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, assign) BOOL isSelected;
@property(nonatomic, strong) id<ShoppingCartCellDelegate>delegate;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setCellWithModel:(YHBShopCartCartlist *)aModel;
- (void)selectedBtnNo;
- (void)selectedBtnYes;
- (void)chooseBtn:(UIButton *)aBtn;
- (void)isEdit:(BOOL)aBool;
@end
