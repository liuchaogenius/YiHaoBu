//
//  PushPriceManage.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushPriceManage : NSObject

- (void)pushPriceManageWithItemId:(int)aItemId price:(float)aPrice content:(NSString *)aContent typeid:(int)aTypeid succBlock:(void (^)(void))aSuccBlock andFailBlock:(void (^)(void))aFailBlock;
@end
