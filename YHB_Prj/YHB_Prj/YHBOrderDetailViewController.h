//
//  YHBOrderDetailViewController.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/19.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"


@interface YHBOrderDetailViewController : BaseViewController

@property (assign, nonatomic) BOOL isPopToRoot;
- (instancetype)initWithItemId:(NSInteger)itemID;

@end
