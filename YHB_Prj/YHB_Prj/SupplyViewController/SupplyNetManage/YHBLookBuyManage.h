//
//  YHBLookBuyManage.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBLookBuyManage : NSObject

- (void)getBuyArray:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(void))aFailBlock isVip:(BOOL)aBool;
- (void)getNextBuyArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(void))aFailBlock;
@end
