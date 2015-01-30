//
//  YHBInfoListManager.h
//  YHB_Prj
//
//  Created by yato_kami on 14/12/25.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//  处理产品信息列表，供应信息列表，求购等各类物品信息列表的manager，包括搜索

#import <Foundation/Foundation.h>
#define kAll -1

typedef enum : NSUInteger {
    Get_Sell = 0,
    Get_Buy,
    Get_Product,
    Get_Company
} GetPrivateTag;

@class YHBPage;
@interface YHBInfoListManager : NSObject

//单例
+ (instancetype)sharedManager;

//获取产品&样板信息列表
- (void)getProductListWithUserID:(NSInteger)userID typeID:(NSInteger)typeID pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock;

//搜索产品&样板信息列表 typeid:0产品，1样板  去掉字段是所有(kAll)
- (void)searchProductListWithUserID:(NSInteger)userID typeID:(NSInteger)typeID KeyWord:(NSString *)keyWord cateID:(NSString *)cateID PageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock;

//获取/搜索供应信息列表
- (void)getSellListWithUserID:(NSInteger)userID pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock;

//搜索供应信息列表
- (void)searchSellListWithUserID:(NSInteger)userID KeyWord:(NSString *)keyWord cateID:(NSString *)cateID Vip:(NSInteger)vip pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock;

//获取求购信息列表
- (void)getBuyListWithUserID:(NSInteger)userID pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock;

//搜索求购信息列表
- (void)searchBuyListWithUserID:(NSInteger)userID KeyWord:(NSString *)keyWord cateID:(NSString *)cateID pageID:(NSInteger)pageID Vip:(NSInteger)vip pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock;

//搜索商城列表
- (void)searchCompanyListWithKeyWord:(NSString *)keyWord cateID:(NSString *)cateID Vip:(int)vip pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock;

//获取我的收藏
- (void)getMyFavoriteWithToken:(NSString *)token Action:(GetPrivateTag)tag PageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock;

@end
