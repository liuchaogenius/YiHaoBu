//
//  jubaoManage.h
//  YHB_Prj
//
//  Created by Johnny's on 15/2/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jubaoManage : NSObject

- (void)jubaoModuleid:(int)aModuleid itemid:(int)aItemid typeid:(int)aTypeid andintroduce:(NSString *)aIntroduce succBlock:(void(^)(void))aSuccBlock failBlock:(void(^)(NSString *aStr))aFailBlock;
@end
