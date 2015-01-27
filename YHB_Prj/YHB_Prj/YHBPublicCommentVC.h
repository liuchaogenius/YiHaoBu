//
//  YHBPublicCommentVC.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^Success_handler)(void);
@class YHBOrderDetail;
@interface YHBPublicCommentVC : BaseViewController

- (instancetype)initWithOrderDetailModel:(YHBOrderDetail *)model;

- (void)setPublishSuccessHandler:(Success_handler)handel;

@end
