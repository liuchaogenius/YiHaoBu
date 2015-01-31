//
//  YHBSupplyDetailViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "BaseViewController.h"

@interface YHBSupplyDetailViewController : BaseViewController

//- (instancetype)initWithItemId:(int)aItemId andIsMine:(BOOL)aIsMine;
- (instancetype)initWithItemId:(int)aItemId andIsMine:(BOOL)aIsMine isModal:(BOOL)aIsModal;
- (instancetype)initWithItemId:(int)aItemId itemDict:(NSDictionary *)aDict uploadPhotoArray:(NSArray *)aArray;
@end
