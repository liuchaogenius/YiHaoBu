//
//  YHBMySupplyManage.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/26.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBMySupplyManage : NSObject

-(void)getSupplyArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock isSupply:(BOOL)aBool isFind:(BOOL)aFindBool;
-(void)getNextSupplyArray:(void (^)(NSMutableArray *aArray))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock;
@end
