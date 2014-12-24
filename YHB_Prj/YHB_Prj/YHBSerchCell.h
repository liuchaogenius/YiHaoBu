//
//  YHBSerchCell.h
//  YHB_Prj
//
//  Created by yato_kami on 14/12/23.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kSearchCellHeight 60

@interface YHBSerchCell : UITableViewCell

@property (strong, nonatomic) UITextField *textFiled;
@property (strong, nonatomic) UIButton *searchbutton;
@property (strong, nonatomic) NSMutableArray *hotTagbtnArray;

@end
