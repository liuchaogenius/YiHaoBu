//
//  TitleTagManage.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/18.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleTagManage : NSObject

- (void)getTitleTag:(void(^)(NSArray *aArray))aSuccBlock andFailBlock:(void(^)(void))aFailBlock;
@end
