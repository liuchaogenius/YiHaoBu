//
//  DAСontextMenuCell.h
//  DAContextMenuTableViewControllerDemo
//
//  Created by Daria Kopaliani on 7/24/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBSupplyModel.h"


@class DAContextMenuCell;

@protocol DAContextMenuCellDelegate <NSObject>

- (void)contextMenuCellDidSelectMoreOption:(DAContextMenuCell *)cell;
- (void)contextMenuDidHideInCell:(DAContextMenuCell *)cell;
- (void)contextMenuDidShowInCell:(DAContextMenuCell *)cell;
- (void)contextMenuWillHideInCell:(DAContextMenuCell *)cell;
- (void)contextMenuWillShowInCell:(DAContextMenuCell *)cell;
- (BOOL)shouldShowMenuOptionsViewInCell:(DAContextMenuCell *)cell;
@optional
- (void)contextMenuCellDidSelectDeleteOption:(DAContextMenuCell *)cell;

@end


@interface DAContextMenuCell : UITableViewCell

//@property (strong, nonatomic) IBOutlet UIView *actualContentView;
@property(strong, nonatomic) UIView *actualContentView;

@property (readonly, assign, nonatomic, getter = isContextMenuHidden) BOOL contextMenuHidden;
@property (strong, nonatomic) NSString *deleteButtonTitle;
@property (assign, nonatomic) BOOL editable;
@property (assign, nonatomic) CGFloat menuOptionButtonTitlePadding;
@property (assign, nonatomic) CGFloat menuOptionsAnimationDuration;
@property (assign, nonatomic) CGFloat bounceValue;
@property (strong, nonatomic) NSString *moreOptionsButtonTitle;
@property (nonatomic, assign) int row;

@property (weak, nonatomic) id<DAContextMenuCellDelegate> delegate;


@property(nonatomic, strong) UIImageView *goodImgView;
@property(nonatomic, strong) UILabel *goodTitleLabel;
@property(nonatomic, strong) UILabel *goodCatNameLabel;
@property(nonatomic, strong) UILabel *goodTypeNameLabel;
@property(nonatomic, strong) UILabel *goodEditTimeLabel;
@property(nonatomic, strong) UILabel *goodCatDetailLabel;
@property(nonatomic, strong) UIImageView *vipImgView;
@property(nonatomic, strong) UILabel *goodTodayLabel;
@property(nonatomic, strong) UILabel *goodAmountLabel;

- (CGFloat)contextMenuWidth;
- (void)setMenuOptionsViewHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler;
+ (CGFloat)returnCellHeight;
- (void)setCellWithModel:(YHBSupplyModel *)aModel;
@end
