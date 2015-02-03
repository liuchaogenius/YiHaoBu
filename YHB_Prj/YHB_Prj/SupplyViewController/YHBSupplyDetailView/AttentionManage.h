//
//  AttentionManage.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
//sell:供应 buy:求购 mall:产品 company:店铺
@interface AttentionManage : NSObject

- (void)changeLikeStatusAction:(NSString *)aAction itemid:(int)aId SuccBlock:(void (^)(void))aSuccBlock andFailBlock:(void (^)(NSString *aStr))aFailBlock;

@end
