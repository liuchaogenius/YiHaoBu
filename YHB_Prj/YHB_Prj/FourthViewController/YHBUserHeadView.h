//
//  YHBUserHeadView.h
//  YHB_Prj
//
//  Created by yato_kami on 14/11/12.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kHeadHeight 135

@protocol UserHeadDelegate <NSObject>

- (void)touchHeadLoginBtn;
- (void)touchPrivateBtn;

@end

@interface YHBUserHeadView : UIView

@property (weak, nonatomic) id<UserHeadDelegate> delegate;

//显示的是自己时，刷新方法
- (void)refreshSelfHeadWithIsLogin:(BOOL)isLogin name:(NSString *)name avator:(NSString *)avator thumb:(NSString *)thumb group:(NSInteger)group company:(NSString *)company;

//显示他人时，刷新方法
- (void)refreshViewWithIslogin:(BOOL)isLogin group:(NSInteger)group name:(NSString *)name avator:(NSString *)avator thumb:(NSString *)thumb company:(NSString *)company friend:(NSInteger)firend;

@end
