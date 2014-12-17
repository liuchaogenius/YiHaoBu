//
//  TableSectionHeaderView.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/13.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableSectionHeaderView;
@protocol TableViewHeaderViewDelegate <NSObject>

- (void)selectHeadViewWithView:(TableSectionHeaderView *)aView Index:(long)aIndex;
@end


@interface TableSectionHeaderView : UIView
{
    UILabel *nameLabel;
}
@property(nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) long index;
@property(nonatomic, strong) id<TableViewHeaderViewDelegate>headerViewDelegate;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setName:(NSString *)aName;
- (void)chooseBtnYes;
- (void)chooseBtnNo;
@end
