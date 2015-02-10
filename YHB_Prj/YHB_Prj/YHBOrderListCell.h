//
//  YHBOrderListCell.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/18.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kpriceHeight 30
#define kBtnViewHeight 40
@protocol YHBOrderListCellDelegte<NSObject>

- (void)touchActionButtonWithItemID:(NSInteger)itemid actionStr:(NSString *)action;

@end
@interface YHBOrderListCell : UITableViewCell

@property (weak, nonatomic) id<YHBOrderListCellDelegte> delegate;

- (void)setUIWithStatus:(NSInteger)status Title:(NSString *)title price:(NSString *)price number:(NSString *)num amount:(NSString *)amount itemID:(NSInteger)itemid NextAction:(NSArray *)naction shopID:(NSInteger)shopID;

@end
