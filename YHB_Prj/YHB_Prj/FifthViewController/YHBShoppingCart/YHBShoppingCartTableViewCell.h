//
//  YHBShoppingCartTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/10.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBShopCartCartlist.h"
#import "YHBNumControl.h"
@class YHBShoppingCartTableViewCell;
@protocol ShoppingCartCellDelegate <NSObject>

- (void)touchCell:(YHBShoppingCartTableViewCell *)aCell WithSection:(int)aSection row:(int)aRow;
- (void)changeCountWithItemId:(NSString *)aItemid andCount:(float)aCount WithSection:(int)aSection row:(int)aRow isStay:(BOOL)aBool;
- (void)changeCellCount:(YHBShoppingCartTableViewCell *)aCell keyBoardHeight:(CGFloat)aHeight;
- (void)overChangeCellCount;

@end


@interface YHBShoppingCartTableViewCell : UITableViewCell<YHBNumControlDelegate, UITextFieldDelegate>
{
    UIImageView *shopImgView;
    UILabel *priceLabel;
    UILabel *countLabel;
    UILabel *titleLabel;
    UILabel *catLabel;
    YHBNumControl *changeView;
    YHBShopCartCartlist *myModel;
}

@property (nonatomic, assign) int section;
@property (nonatomic, assign) int row;

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
