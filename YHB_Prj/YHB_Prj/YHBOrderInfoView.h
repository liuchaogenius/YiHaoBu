//
//  YHBOrderInfoView.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/18.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kInfoViewHeight 75
@interface YHBOrderInfoView : UIView

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *numberLabel;

@end
