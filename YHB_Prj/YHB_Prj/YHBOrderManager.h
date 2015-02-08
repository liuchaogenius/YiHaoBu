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
@class YHBOConfirmModel;
@interface YHBOrderManager : NSObject

+ (YHBOrderManager *)sharedManager;

//获取总价
- (void)getOrderTotalPriceWithPostDic:(NSDictionary *)postDic Success:(void(^)(NSString *totalPriceStr))sBlock failure:(void(^)(NSString *error))fBlock;

//提交订单， info：支付宝相关字段
- (void)postOrderWithPostDic:(NSDictionary *)postDic Success:(void(^)(NSString *info,NSArray *itemArray))sBlock failure:(void(^)(NSString *error))fBlock;

//获取订单列表
- (void)getOrderListWithToken:(NSString *)token PageID:(NSInteger)pageid PageSize:(NSInteger)pageSize Success:(void(^)(YHBOrderList *listModel))sBlock failure:(void(^)(NSString *error))fBlock;

//获取订单详情
- (void)getOrderDetailWithToken:(NSString *)token ItemID:(NSInteger)itemID Success:(void (^)(YHBOrderDetail *model))sBlock failure:(void (^)(NSString *error))fBlock;

//更改订单状态
- (void)changeOrderStatusWithToken:(NSString *)token ItemID:(NSInteger)itemID Action:(NSString *)action Success:(void(^)())sBlock failure:(void(^)(NSString *error))fBlock;

//获取确认订单信息
- (void)getOrderConfirmWithToken:(NSString *)token source:(NSString *)source ListArray:(NSArray *)listArray Success:(void (^)(YHBOConfirmModel *model))sBlock failure:(void (^)(NSInteger result,NSString *error))fBlock;

//通过订单id 获取支付宝字符串
- (void)getPayInfoWithToken:(NSString *)token ItemID: (NSInteger)itemID Success: (void(^)(NSString *info))sBlock failure: (void(^)(NSString *error))fBlock;

@end
