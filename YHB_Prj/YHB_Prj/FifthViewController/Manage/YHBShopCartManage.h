//
//  YHBShopCartManage.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/10.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBShopCartManage : NSObject

- (void)getShopCartArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock;
- (void)getNextShopCartArray:(void (^)(NSMutableArray *aArray))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock;
- (void)changeShopCartWithArray:(NSArray *)aArray andSuccBlock:(void (^)(void))aSuccBlock failBlock:(void (^)(NSString *aStr))aFailBlock;
- (void)deleteShopCartWithArray:(NSArray *)aArray andSuccBlock:(void (^)(void))aSuccBlock failBlock:(void (^)(NSString *aStr))aFailBlock;
@end
