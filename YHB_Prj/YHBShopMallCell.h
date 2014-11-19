//
//  YHBShopMallCell.h
//  YHB_Prj
//
//  Created by yato_kami on 14/11/19.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kcellHeight kMainScreenWidth *443/(1080)

@interface YHBShopMallCell : UITableViewCell
//0,1,2 左中右相同的三个part
@property (strong, nonatomic) NSMutableArray *titleLabelArray;
@property (strong, nonatomic) NSMutableArray *priceLabelArray;
@property (strong, nonatomic) NSMutableArray *dateLabelArray;
@property (strong, nonatomic) NSMutableArray *imageViewArray;

- (void)clearCellContentPart:(int)part;//重置数据，part：左中右三部分-》0,1,2

@end
