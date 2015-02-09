//
//  YHBBuyDetailViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHBBuyDetailViewController : BaseViewController

- (instancetype)initWithItemId:(int)aItemId andIsMine:(BOOL)aIsMine isModal:(BOOL)aIsModal;
- (instancetype)initWithItemId:(int)aItemId itemDict:(NSDictionary *)aDict uploadPhotoArray:(NSArray *)aArray isWebArray:(BOOL)aBool;
@end
