//
//  YHBBuyDetailManage.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHBBuyDetailData.h"

@interface YHBBuyDetailManage : NSObject

- (void)getBuyDetailWithItemid:(int)aItemId SuccessBlock:(void(^)(YHBBuyDetailData *aModel))aSuccBlock andFailBlock:(void(^)(void))aFailBlock;
@end
