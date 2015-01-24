//
//  AddressEditViewController.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/23.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^success_Handle)();

@class YHBAddressModel;
@interface YHBAddressEditViewController : BaseViewController

- (instancetype)initWithAddressModel:(YHBAddressModel *)model isNew:(BOOL)isnew SuccessHandle:(success_Handle)handel;

@end
