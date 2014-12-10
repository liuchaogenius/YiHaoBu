//
//  YHBShoppingCartTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/10.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBShopCartCartlist.h"

@interface YHBShoppingCartTableViewCell : UITableViewCell
{
    UIImageView *shopImgView;
    UILabel *priceLabel;
    UILabel *countLabel;
    UILabel *titleLabel;
    UILabel *catLabel;
}

@property (nonatomic, assign) BOOL isSelected;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setCellWithModel:(YHBShopCartCartlist *)aModel;
@end
