//
//  YHBInfoListManager.h
//  YHB_Prj
//
//  Created by yato_kami on 14/12/25.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//  处理产品信息列表，供应信息列表，求购等各类物品信息列表的manager，包括搜索

#import <Foundation/Foundation.h>
@class YHBPage;
@interface YHBInfoListManager : NSObject

//获取产品&样板信息列表
- (void)getProductListWithUserID:(NSInteger)userID typeID:(NSInteger)typeID pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)())fBlock;

//获取供应信息列表
- (void)getSellListWithUserID:(NSInteger)userID pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)())fBlock;

@end
