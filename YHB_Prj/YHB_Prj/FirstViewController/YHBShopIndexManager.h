//
//  YHBShopIndexManager.h
//  YHB_Prj
//
//  Created by yato_kami on 14/12/17.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHBFirstPageIndex;
@class YHBCompanyIndex;
@interface YHBShopIndexManager : NSObject

//获取首页数据
- (void)getFirstPageIndexWithSuccess:(void(^)(YHBFirstPageIndex *model))sBlock failure:(void(^)(int result,NSString *errorString))fBlock;
//获取商城首页信息
- (void)getCompanyIndexWithSuccess:(void(^)(YHBCompanyIndex *model))sBlock failure:(void(^)(int result,NSString *errorString))fBlock;

@end
