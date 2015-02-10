//
//  YHBMySupplyViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/26.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHBMySupplyViewController : BaseViewController

@property (assign, nonatomic) BOOL shouldDisableUserInteractionWhileEditing;

- (instancetype)initWithIsSupply:(BOOL)aIsSupply;

- (instancetype)initWithUserid:(int)aUserid;
@end
