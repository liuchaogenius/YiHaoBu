//
//  YHBMySupplyManage.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/26.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBMySupplyManage : NSObject

- (void)getSupplyArray:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(void))aFailBlock isSupply:(BOOL)aBool;
- (void)getNextSupplyArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(void))aFailBlock;
@end
