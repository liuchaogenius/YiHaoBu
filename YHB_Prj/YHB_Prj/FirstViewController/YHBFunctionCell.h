//
//  YHBFunctionView.h
//  YHB_Prj
//
//  Created by yato_kami on 14/12/20.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define fcViewTagBase 10
enum Button_Tag
{
    button_message = fcViewTagBase,
    button_orders,
    button_sell,
    button_buy
};

@protocol YHBFunctionCellDelegate <NSObject>

- (void)touchedFunctionButtonWithTag:(NSInteger)tag;

@end

@interface YHBFunctionCell : UITableViewCell

@property (weak, nonatomic) id<YHBFunctionCellDelegate> delegate;

@end
