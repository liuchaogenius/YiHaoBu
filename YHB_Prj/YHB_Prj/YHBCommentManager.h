//
//  YHBCommentManager.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBCommentManager : NSObject

- (void)getCommentListWithItemID:(NSInteger)itemID token:(NSString *)token Success:(void(^)(NSMutableArray *modelArray))sBlock failure:(void(^)(NSString *error))fBlock;

@end
