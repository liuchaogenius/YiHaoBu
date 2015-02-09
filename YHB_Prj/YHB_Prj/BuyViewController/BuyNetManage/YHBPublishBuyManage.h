//
//  YHBPublishBuyManage.h
//  YHB_Prj
//
//  Created by Johnny's on 15/1/4.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBPublishBuyManage : NSObject

- (void)publishBuyWithItemid:(int)aItemId title:(NSString *)aTitle catid:(NSString *)aCatId today:(NSString *)aToday content:(NSString *)aContent truename:(NSString *)aName mobile:(NSString *)aMobile unit:(NSString *)aUnit photoArray:(NSArray *)aArray andSuccBlock:(void (^)(NSDictionary *aDict))aSuccBlock failBlock:(void (^)(NSString *aStr))aFailBlock;
@end
