//
//  YHBOrderConfirmVC.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"

@interface YHBOrderConfirmVC : BaseViewController

/**
 *  实例化方法
 *
 *  @param source 来源,mall产品页面,cart购物车
 *  @param rArray 内容数组，
      由一组dic组成，一个dic代表一个产品,
        dic组成
        { "itemid": 1,
          "number": "1",
           "skuid": 1
        }
 *
 *  @return 实例
 */
- (instancetype)initWithSource:(NSString *)source requestArray:(NSArray *)rArray;

@end
