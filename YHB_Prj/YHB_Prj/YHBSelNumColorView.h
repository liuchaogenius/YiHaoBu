//
//  YHBSelNumColorView.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/13.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBSku.h"
@class YHBProductDetail;

@protocol YHBSelViewDelegate <NSObject>

- (void)selViewShouldPushViewController:(UIViewController *)vc;
- (void)selViewShouldDismissWithSelNum:(double)num andSelSku:(YHBSku *)sku;

@end

@interface YHBSelNumColorView : UIView

@property (weak, nonatomic) id<YHBSelViewDelegate> delegate;

- (instancetype)initWithProductModel:(YHBProductDetail *)model;

@property (assign, nonatomic) double number;//数量
@property (strong, nonatomic) YHBSku *selSku;

- (void)registerForKeyboradNotifications;

@end
