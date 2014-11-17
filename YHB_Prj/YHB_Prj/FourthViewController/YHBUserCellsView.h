//
//  YHBUserCellsView.h
//  YHB_Prj
//
//  Created by yato_kami on 14/11/12.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KcellHeight 40
enum cellsTag
{
    Cell_shopInfo = 0, //店铺信息
    Cell_certification,//我的认证
    Cell_private,//我的收藏
    Cell_aboutUs,//关于我们
    Cell_clause,//服务条款
    Cell_tips//使用帮助
};

@protocol userCellsDelegate <NSObject>
//点击cell
- (void)touchCellWithTag:(NSInteger)tag;
@end

@interface YHBUserCellsView : UIView

@property (nonatomic,weak) id<userCellsDelegate> delegate;

@end
