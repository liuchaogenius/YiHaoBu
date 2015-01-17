//
//  CategoryViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 15/1/15.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController

+ (CategoryViewController *)sharedInstancetype;
- (void)setBlock:(void(^)(NSArray *aArray))aBlock;
- (void)cleanAll;
- (void)deleteItemWithItemID:(int)aCatid;

@end
