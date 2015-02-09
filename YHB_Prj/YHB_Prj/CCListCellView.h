//
//  CCListCellView.h
//  YHB_Prj
//
//  Created by yato_kami on 15/2/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCListCellDelegate <NSObject>

- (void)touchListCellWithRow:(long)row;

@end

@interface CCListCellView : UIView

@property (weak, nonatomic) id<CCListCellDelegate> delegate;

- (instancetype)initWithTitleArray: (NSArray *)titleArray;
- (void)showWithPoint:(CGPoint)point Animate:(BOOL)animate;

@end
