//
//  YHBContactView.h
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "GetUserNameManage.h"

@interface YHBContactView : UIView<UIAlertViewDelegate, MFMessageComposeViewControllerDelegate>
{
    UILabel *phoneLabel;
    UILabel *storeLabel;
    UIView *firstView;
    UIButton *firstView1;
    UIButton *secondView;
    UIButton *thirdView;
    UIButton *fourthView;
    NSString *phoneNumber;
    int itemId;
    UIView *redLine;
    NSString *myImgUrl;
    NSString *myTitle;
    NSString *myType;
    NSString *storeName;
    NSString *trueName;
    NSString *avator;
    int userid;
    BOOL isSupply;
    BOOL isFromMall;
    GetUserNameManage *manage;
}

- (instancetype)initWithFrame:(CGRect)frame isSupply:(BOOL)aBool;
- (void)setPhoneNumber:(NSString *)aNumber storeName:(NSString *)aName itemId:(int)aItemId isVip:(int)aisVip imgUrl:(NSString *)aImgUrl Title:(NSString *)aTitle andType:(NSString *)aType userid:(int)aUserid;
//商城详情页用
- (void)setViewForCompanyWithPhoneNumber:(NSString *)aNumber andType:(NSString *)aType userid:(int)aUserid avator:(NSString *)avatorStr truename:(NSString *)name isFromMall: (BOOL)isFrom;

@end
