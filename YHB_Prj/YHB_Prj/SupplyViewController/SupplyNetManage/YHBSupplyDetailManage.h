//
//  YHBSupplyDetailManage.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/7.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHBSupplyDetailModel.h"

@interface YHBSupplyDetailManage : NSObject

- (void)getSupllyDetailWithItemid:(int)aItemId SuccessBlock:(void(^)(YHBSupplyDetailModel *aModel))aSuccBlock andFailBlock:(void(^)(NSString *aStr))aFailBlock;
@end
