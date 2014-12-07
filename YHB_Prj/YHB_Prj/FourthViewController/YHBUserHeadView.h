//
//  YHBUserHeadView.h
//  YHB_Prj
//
//  Created by yato_kami on 14/11/12.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserHeadDelegate <NSObject>

- (void)touchHeadLoginBtn;

@end

@interface YHBUserHeadView : UIView

@property (weak, nonatomic) id<UserHeadDelegate> delegate;

- (void)refreshViewWithIslogin:(BOOL)isLogin vcompany:(int)vcompany sell:(NSInteger)sell buy:(NSInteger)buy name:(NSString *)name avator:(NSString *)avator;//刷新view

@end
