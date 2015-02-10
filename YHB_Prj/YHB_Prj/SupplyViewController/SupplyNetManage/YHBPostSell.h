//
//  YHBPostSell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/2/10.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBPostSell : NSObject

- (void)deleteItemWithItemid:(int)aItemid andIsSupply:(BOOL)aBool succBlock:(void(^)(void))aSuccBlock failBlock:(void(^)(NSString *aStr))aFailBlock;
- (void)postItemid:(int)aItemid action:(NSString *)aAction typeid:(int)aTypeid succBlock:(void(^)(void))aSuccBlock failBlock:(void(^)(NSString *aStr))aFailBlock;
@end
