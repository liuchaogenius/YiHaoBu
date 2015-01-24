//
//  YHBAdressListViewController.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/23.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"

@class YHBAddressModel;

@protocol YHBAddressListDelegate <NSObject>

//用户选择了一个地址
- (void)choosedAddressModel:(YHBAddressModel *)model;

@end

@interface YHBAdressListViewController : BaseViewController

@property (weak, nonatomic) id<YHBAddressListDelegate> delegate;

//判别是否来自订单确认页
@property (assign, nonatomic) BOOL isfromOrder;

@end
