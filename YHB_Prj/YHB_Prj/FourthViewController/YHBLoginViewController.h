//
//  YHBLoginViewController.h
//  YHB_Prj
//
//  Created by yato_kami on 14/11/13.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(int, loginType)
{
    eLoginSucc,//登陆成功
    eLoginFail,//登陆失败
    eLoginBack//点击返回按钮
};
@interface YHBLoginViewController : BaseViewController

@property (nonatomic, assign)loginType type;
- (void)clearText;

@end
