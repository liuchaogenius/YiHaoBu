//
//  YHBShopIndexManager.h
//  YHB_Prj
//
//  Created by yato_kami on 14/12/17.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHBFirstPageIndex;
@interface YHBShopIndexManager : NSObject

//- (void)getShopIndexWithSuccess:(void(^)(YHBShopIndex *shopModel))sBlock failure:(void(^)())fBlock;
//获取首页数据
- (void)getFirstPageIndexWithSuccess:(void(^)(YHBFirstPageIndex *model))sBlock failure:(void(^)(int result,NSString *errorString))fBlock;

@end
