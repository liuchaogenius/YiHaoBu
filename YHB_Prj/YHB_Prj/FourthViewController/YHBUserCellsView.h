//
//  YHBUserCellsView.h
//  YHB_Prj
//
//  Created by yato_kami on 14/11/12.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KcellHeight 40
#define kBlankHeight 10
enum cellsTag
{
    Cell_shopInfo = 0, //店铺信息
    Cell_certification,//我的认证
    Cell_myOrder,//我的订单
    Cell_address,//收货地址
    Cell_private,//我的收藏
    Cell_aboutUs,//关于我们
    Cell_clause,//服务条款
    Cell_tips,//使用帮助
    Cell_share//分享给好友
};

@protocol userCellsDelegate <NSObject>
//点击cell
- (void)touchCellWithTag:(NSInteger)tag;
@end

@interface YHBUserCellsView : UIView

@property (nonatomic,weak) id<userCellsDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data;

@end
