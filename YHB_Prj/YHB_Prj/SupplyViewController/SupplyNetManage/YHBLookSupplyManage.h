//
//  YHBLookSupplyManage.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/6.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBLookSupplyManage : NSObject

- (void)getSupplyArray:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(void))aFailBlock isVip:(BOOL)aBool;
- (void)getNextSupplyArray:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(void))aFailBlock;
@end
