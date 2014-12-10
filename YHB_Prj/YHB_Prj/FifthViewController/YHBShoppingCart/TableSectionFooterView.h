//
//  TableSectionFooterView.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/10.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBShopCartRslist.h"
#import "YHBShopCartCartlist.h"

@interface TableSectionFooterView : UIView
{
    UILabel *priceLabel;
    UILabel *itemCountLabel;
}
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setViewWith:(YHBShopCartRslist *)aModel;
@end
