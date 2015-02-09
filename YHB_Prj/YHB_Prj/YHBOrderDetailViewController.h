//
//  YHBOrderDetailViewController.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/19.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^TouchPayHandle)();

@interface YHBOrderDetailViewController : BaseViewController

@property (assign, nonatomic) BOOL isPopToRoot;
- (instancetype)initWithItemId:(NSInteger)itemID;
- (void)setDidTouchedPayButtonHandle:(TouchPayHandle)handle;//用户点击支付按钮追加操作

@end
