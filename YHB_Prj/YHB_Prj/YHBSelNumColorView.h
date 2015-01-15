//
//  YHBSelNumColorView.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/13.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHBProductDetail;

@protocol YHBSelViewDelegate <NSObject>

- (void)selViewShouldDismiss;

@end

@interface YHBSelNumColorView : UIView

@property (weak, nonatomic) id<YHBSelViewDelegate> delegate;
- (instancetype)initWithProductModel:(YHBProductDetail *)model;

@end
