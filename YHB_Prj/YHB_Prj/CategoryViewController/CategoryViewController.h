//
//  CategoryViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 15/1/15.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"

@interface CategoryViewController : BaseViewController

+ (CategoryViewController *)sharedInstancetype;
@property (assign, nonatomic) BOOL isPushed;
- (void)setBlock:(void(^)(NSArray *aArray))aBlock;
- (void)cleanAll;
- (void)deleteItemWithItemID:(int)aCatid;
- (NSMutableArray *)getChooseArray;

@end
