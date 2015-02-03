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

@interface YHBContactView : UIView<UIAlertViewDelegate, MFMessageComposeViewControllerDelegate>
{
    UILabel *phoneLabel;
    UILabel *storeLabel;
    UIView *firstView;
    UIButton *secondView;
    UIButton *thirdView;
    UIButton *fourthView;
    NSString *phoneNumber;
    int itemId;
    UIView *redLine;
    NSString *myImgUrl;
    NSString *myTitle;
    NSString *myType;
    int userid;
}

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setPhoneNumber:(NSString *)aNumber storeName:(NSString *)aName itemId:(int)aItemId isVip:(int)aisVip imgUrl:(NSString *)aImgUrl Title:(NSString *)aTitle andType:(NSString *)aType userid:(int)aUserid;
@end
