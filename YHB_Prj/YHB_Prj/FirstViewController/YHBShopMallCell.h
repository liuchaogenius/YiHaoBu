//
//  YHBShopMallCell.h
//  YHB_Prj
//
//  Created by yato_kami on 14/11/19.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kcellHeight kMainScreenWidth *485/(1080)
enum shopMallPart
{
    left_part = 0,
    mid_part,
    right_part
};

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
@property (strong, nonatomic) NSMutableArray *totalViewArray;//浏览量label array
@property (strong, nonatomic) NSMutableArray *imageViewArray;
@property (strong, nonatomic) NSIndexPath* cellIndexPath;// 必须设置
@property (weak, nonatomic) id<ShopMallCellDelegate> delegate;

//type 0:类产品推荐cell，下方有价格   type 1:类商机推荐类cell，下方是日期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andType:(NSInteger)type;

//type0的cell 设置UI
- (void)setImage:(NSString *)imgurl title:(NSString *)title price:(NSString *)price part:(int)part;
//type1的cell 设置UI
- (void)setImage:(NSString *)imgurl title:(NSString *)title time:(NSString *)time hits:(int)hits part:(int)part;

//重置数据，part：左中右三部分-》0,1,2
- (void)clearCellContentParts;

//中、右部分无数据处理
- (void)setBlankWithPart:(int)part;

@end
