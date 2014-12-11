//
//  YHBShopMallCell.h
//  YHB_Prj
//
//  Created by yato_kami on 14/11/19.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kcellHeight kMainScreenWidth *443/(1080)

@protocol ShopMallCellDelegate <NSObject>
/**
 *  返回点击某个产品/店铺的代理方法
 *
 *  @param indexPath 当前cell的indexpath
 *  @param part      0，1，2 同一cell中 代表左中右三个产品/店铺
 */
- (void)selectCellPartWithIndexPath : (NSIndexPath*)indexPath part:(NSInteger)part;

@end

@interface YHBShopMallCell : UITableViewCell
//0,1,2 左中右相同的三个part
@property (strong, nonatomic) NSMutableArray *titleLabelArray;
@property (strong, nonatomic) NSMutableArray *priceLabelArray;
@property (strong, nonatomic) NSMutableArray *dateLabelArray;
@property (strong, nonatomic) NSMutableArray *imageViewArray;
@property (strong, nonatomic) NSIndexPath* cellIndexPath;// 必须设置
@property (weak, nonatomic) id<ShopMallCellDelegate> delegate;

- (void)clearCellContentParts;//重置数据，part：左中右三部分-》0,1,2

@end
