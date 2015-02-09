//
//  GetUserNameManage.h
//  YHB_Prj
//
//  Created by Johnny's on 15/2/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetUserNameManage : NSObject

- (void)getUserNameUseridArray:(NSMutableArray *)aArray succBlock:(void(^)(NSMutableArray *aMuArray))aSuccBlock failBlock:(void(^)(NSString *aStr))aFailBlock;

@end
