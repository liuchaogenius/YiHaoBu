//
//  YHBSearchInputVC.h
//  YHB_Prj
//
//  Created by yato_kami on 15/2/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
#define kSegBase 700
typedef enum : NSUInteger {
    Search_buy = kSegBase, //采购
    Search_sell,//供应
    Search_mall,//店铺
    Search_product//产品
} SearchType;

typedef void (^SearchHandle)(SearchType sType,NSString *searchText);
typedef void (^CancelHandle)();

@interface YHBSearchInputVC : BaseViewController

- (instancetype)initWithSearchType:(SearchType)type SearchHandle:(SearchHandle)sHandle cancelHandle:(CancelHandle)cHandel;
- (void)showWithAnimate:(BOOL)animate;

@end
