//
//  YHBOrderManager.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/19.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHBOrderList;
@class YHBOrderDetail;
@interface YHBOrderManager : NSObject

+ (YHBOrderManager *)sharedManager;
//获取订单列表
- (void)getOrderListWithToken:(NSString *)token PageID:(NSInteger)pageid PageSize:(NSInteger)pageSize Success:(void(^)(YHBOrderList *listModel))sBlock failure:(void(^)())fBlock;

//获取订单详情
- (void)getOrderDetailWithToken:(NSString *)token ItemID:(NSInteger)itemID Success:(void (^)(YHBOrderDetail *model))sBlock failure:(void (^)())fBlock;

//更改订单状态
- (void)changeOrderStatusWithToken:(NSString *)token ItemID:(NSInteger)itemID Action:(NSString *)action Success:(void(^)())sBlock failure:(void(^)())fBlock;
@end
