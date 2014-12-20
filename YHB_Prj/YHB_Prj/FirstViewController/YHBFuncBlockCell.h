//
//  YHBFuncBlockCell.h
//  YHB_Prj
//
//  Created by yato_kami on 14/12/20.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define fcBTagBase 20
enum FuncBlockButton_Tag
{
    button_shopMall = fcBTagBase,//商城
    button_findWeave,//找步
    button_sellWeave,//卖步
};

@protocol YHBFuncBlockCellDelegate <NSObject>

- (void)touchFuncBlockWithTag:(NSInteger)tag;

@end

@interface YHBFuncBlockCell : UITableViewCell

@property (weak, nonatomic) id<YHBFuncBlockCellDelegate> delegate;

@end
