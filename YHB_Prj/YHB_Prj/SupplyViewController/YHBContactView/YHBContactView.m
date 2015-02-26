//
//  YHBContactView.m
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBContactView.h"
#import "ChatViewController.h"
#import "YHBUser.h"
#import "SVProgressHUD.h"
#import "YHBStoreViewController.h"
#import "UserinfoBaseClass.h"

typedef enum:NSUInteger{
    btnTypePhone = 12,
    btnTypeText = 13,
    btnTypeChat = 14,
    btnTypeShop
}btnType;
@implementation YHBContactView

- (instancetype)initWithFrame:(CGRect)frame isSupply:(BOOL)aBool
{
    if (self = [super initWithFrame:frame]) {
        isSupply = aBool;
        isFromMall = NO;
        manage = [[GetUserNameManage alloc] init];
        if (aBool==YES)
        {
            self.backgroundColor = [UIColor whiteColor];
            CGFloat viewHeight = frame.size.height;
            
            redLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 3)];
            redLine.backgroundColor = KColor;
            [self addSubview:redLine];
            
    //        firstView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 94, viewHeight)];
    //        [self addSubview:firstView];
    //        
    //        phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, redLine.bottom+10, 94, 18)];
    //        phoneLabel.font = kFont15;
    //        phoneLabel.textAlignment = NSTextAlignmentCenter;
    ////        phoneLabel.text = @"12345678910";
    //        [firstView addSubview:phoneLabel];
    //        
    //        storeLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLabel.left, phoneLabel.bottom+6, 94, 18)];
    //        storeLabel.font = kFont15;
    //        storeLabel.textAlignment = NSTextAlignmentCenter;
    ////        storeLabel.text = @"某某店铺";
    //        [firstView addSubview:storeLabel];
    ////        CGSize size = [@"在线" sizeWithFont:kFont15];
            
            CGFloat interval = (kMainScreenWidth-60*4)/5.0;
            
            secondView = [[UIButton alloc] initWithFrame:CGRectMake(interval, 0, 60, viewHeight)];
            secondView.tag=btnTypePhone;
            [secondView addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:secondView];
            
            UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(18, 10, 24, 24)];
            imgView2.image = [UIImage imageNamed:@"phoneImg"];
            [secondView addSubview:imgView2];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView2.bottom+3, 60, 18)];
            label2.font = kFont15;
            label2.text = @"拨打电话";
            [secondView addSubview:label2];
            
            thirdView = [[UIButton alloc] initWithFrame:CGRectMake(secondView.right+interval, 0, 60, viewHeight)];
            thirdView.tag=btnTypeText;
            [thirdView addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:thirdView];
            
            UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(18, 10, 24, 24)];
            imgView3.image = [UIImage imageNamed:@"textImg"];
            [thirdView addSubview:imgView3];
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView3.bottom+3, 60, 18)];
            label3.font = kFont15;
            label3.text = @"发送短信";
            [thirdView addSubview:label3];
            
            fourthView = [[UIButton alloc] initWithFrame:CGRectMake(thirdView.right+interval, 0, 60, viewHeight)];
            fourthView.tag=btnTypeChat;
            [fourthView addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:fourthView];
            
            UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 23)];
            imgView4.image = [UIImage imageNamed:@"chatImg"];
            [fourthView addSubview:imgView4];
            
            UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView4.bottom+4, 60, 18)];
            label4.font = kFont15;
            label4.text = @"在线沟通";
            [fourthView addSubview:label4];
            
            firstView1 = [[UIButton alloc] initWithFrame:CGRectMake(fourthView.right+interval, 0, 60, viewHeight)];
            firstView1.tag=btnTypeShop;
            [firstView1 addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:firstView1];
            
            UIImageView *imgView11 = [[UIImageView alloc] initWithFrame:CGRectMake((60-24)/2, 10, 25, 23)];
            imgView11.image = [UIImage imageNamed:@"scanshop"];
            [firstView1 addSubview:imgView11];
            
            UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView3.bottom+3, 60, 18)];
            label11.font = kFont15;
            label11.text = @"浏览商城";
            [firstView1 addSubview:label11];
        }
        else
        {
            self.backgroundColor = [UIColor whiteColor];
            CGFloat viewHeight = frame.size.height;
            
            redLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 3)];
            redLine.backgroundColor = KColor;
            [self addSubview:redLine];
            
            firstView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 94, viewHeight)];
            [self addSubview:firstView];
            
            phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, redLine.bottom+10, 94, 18)];
            phoneLabel.font = kFont15;
            phoneLabel.textAlignment = NSTextAlignmentCenter;
            //        phoneLabel.text = @"12345678910";
            [firstView addSubview:phoneLabel];
            
            storeLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLabel.left, phoneLabel.bottom+6, 94, 18)];
            storeLabel.font = kFont15;
            storeLabel.textAlignment = NSTextAlignmentCenter;
            //        storeLabel.text = @"某某店铺";
            [firstView addSubview:storeLabel];
            //        CGSize size = [@"在线" sizeWithFont:kFont15];
            
            CGFloat interval = (kMainScreenWidth-firstView.right-15-60*3)/3.0;
            
            secondView = [[UIButton alloc] initWithFrame:CGRectMake(firstView.right+interval, 0, 60, viewHeight)];
            secondView.tag=btnTypePhone;
            [secondView addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:secondView];
            
            UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(18, 10, 24, 24)];
            imgView2.image = [UIImage imageNamed:@"phoneImg"];
            [secondView addSubview:imgView2];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView2.bottom+3, 60, 18)];
            label2.font = kFont15;
            label2.text = @"电话";
            label2.textAlignment = NSTextAlignmentCenter;
            [secondView addSubview:label2];
            
            thirdView = [[UIButton alloc] initWithFrame:CGRectMake(secondView.right+interval, 0, 60, viewHeight)];
            thirdView.tag=btnTypeText;
            [thirdView addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:thirdView];
            
            UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(18, 10, 24, 24)];
            imgView3.image = [UIImage imageNamed:@"textImg"];
            [thirdView addSubview:imgView3];
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView3.bottom+3, 60, 18)];
            label3.font = kFont15;
            label3.textAlignment = NSTextAlignmentCenter;
            label3.text = @"短信";
            [thirdView addSubview:label3];
            
            fourthView = [[UIButton alloc] initWithFrame:CGRectMake(thirdView.right+interval, 0, 60, viewHeight)];
            fourthView.tag=btnTypeChat;
            [fourthView addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:fourthView];
            
            UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 23)];
            imgView4.image = [UIImage imageNamed:@"chatImg"];
            [fourthView addSubview:imgView4];
            
            UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView4.bottom+4, 60, 18)];
            label4.font = kFont15;
            label4.text = @"在线沟通";
            [fourthView addSubview:label4];
        }

    }
    return self;
}

- (void)setPhoneNumber:(NSString *)aNumber storeName:(NSString *)aName itemId:(int)aItemId userid:(int)aUserid
{
    phoneLabel.text = aNumber;
    storeLabel.text = aName;
    phoneNumber = aNumber;
    itemId=aItemId;
    redLine.hidden = YES;
}

- (void)setViewForCompanyWithPhoneNumber:(NSString *)aNumber andType:(NSString *)aType userid:(int)aUserid avator:(NSString *)avatorStr truename:(NSString *)name isFromMall: (BOOL)isFrom
{
    [self setPhoneNumber:aNumber storeName:@"" itemId:0 isVip:0 imgUrl:@"" Title:@"" andType:aType userid:(int)aUserid smsText:@""];
    isFromMall = isFrom;
    avator = avatorStr;
    trueName = name;
}

- (void)setPhoneNumber:(NSString *)aNumber storeName:(NSString *)aName itemId:(int)aItemId isVip:(int)aisVip imgUrl:(NSString *)aImgUrl Title:(NSString *)aTitle andType:(NSString *)aType userid:(int)aUserid smsText:(NSString *)text
{
    if (aisVip==1)
    {
        UIImageView *vipImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        vipImgView.image = [UIImage imageNamed:@"vipLeftImg"];
        [self addSubview:vipImgView];
        
        if (isSupply)
        {
            secondView.right += 15;
            thirdView.right += 10;
            fourthView.right += 5;
        }
        else
        {
            firstView.right += 15;
            secondView.right += 10;
            thirdView.right += 7;
            fourthView.right+=5;
        }
    }
    phoneLabel.text = aNumber;
    storeLabel.text = aName;
    storeName = aName;
    phoneNumber = aNumber;
    itemId=aItemId;
    myImgUrl = aImgUrl;
    myTitle = aTitle;
    myType = aType;
    userid = aUserid;
    smstext = text;
}

- (void)touchBtn:(UIButton *)aBtn
{
    if (aBtn.tag==btnTypePhone)
    {
        if (phoneNumber)
        {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.superview addSubview:callWebview];
        }else
            [SVProgressHUD showErrorWithStatus:@"该用户没有留下手机号" cover:YES offsetY:0];

    }
    else if(aBtn.tag==btnTypeText)
    {
        if (phoneNumber) {
            NSString *body = smstext ? :@"";
            [self showMessageView:body];
        }else {
            [SVProgressHUD showErrorWithStatus:@"该用户没有留下手机号" cover:YES offsetY:0];
        }
        /*
        if (phoneNumber)
        {
           // NSString *myPhoneNumber = [YHBUser sharedYHBUser].userInfo.telephone;
            
         
            if ([myType isEqualToString:@"supply"] )
            {
                body = [NSString stringWithFormat:@"您好，%@，我对您在快布发布的“%@”比较感兴趣，请联系%@。", storeLabel.text, myTitle, myPhoneNumber];
            }
            else if ([myType isEqualToString:@"mall"])
            {
                body = @"";
            }
            else
            {
                NSString *company = [YHBUser sharedYHBUser].userInfo.company;
                if (company)
                {
                    body = [NSString stringWithFormat:@"您好，%@，我对您在快布发布的“%@”比较感兴趣，请在线联系或联系%@，我在快布的店铺名为“%@“。", storeLabel.text, myTitle, myPhoneNumber, company];
                }
                else
                {
                    body = [NSString stringWithFormat:@"您好，%@，我对您在快布发布的“%@”比较感兴趣，请在线联系或联系%@。", storeLabel.text, myTitle, myPhoneNumber];
                }
                
            }
        }*/
    }
    else if(aBtn.tag==btnTypeChat)
    {
        if ([self userLoginConfirm])
        {
            MLOG(@"在线沟通");
//            EMError *error = nil;
//            BOOL isSuccess = [[EaseMob sharedInstance].chatManager registerNewAccount:@"8001" password:@"111111" error:&error];
//            if (isSuccess && !isSuccess) {
//                NSLog(@"注册成功");
//            }
//            NSDictionary *loginInfo = [[EaseMob sharedInstance].chatManager loginWithUsername:@"8001" password:@"111111" error:&error];
//            if (!error && loginInfo) {
//                NSLog(@"登陆成功");
//            }
            if ([myType isEqualToString:@"mall"]) {
                ChatViewController *vc = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%d",userid] isGroup:NO andChatterAvatar:avator];
                vc.title = trueName;
                [[self viewController].navigationController pushViewController:vc animated:YES];
            }else{
                NSString *useridStr = [NSString stringWithFormat:@"%d",userid];
                NSMutableArray *temArray = [NSMutableArray new];
                [temArray addObject:useridStr];
                [manage getUserNameUseridArray:temArray succBlock:^(NSMutableArray *aMuArray) {
                    NSString *userName = storeName;
                    UserinfoBaseClass *model = [aMuArray objectAtIndex:0];
                    ChatViewController *vc = [[ChatViewController alloc] initWithChatter:useridStr userid:userid itemid:itemId ImageUrl:myImgUrl Title:myTitle andType:myType andChatterAvatar:model.avatar];
                    vc.title = userName;
                    [[self viewController].navigationController pushViewController:vc animated:YES];
                } failBlock:^(NSString *aStr) {
                    
                }];
            }
        }
    }
    else if(aBtn.tag==btnTypeShop)
    {
        if (isFromMall) {
            [[self viewController].navigationController popViewControllerAnimated:YES];
        }else{
            YHBStoreViewController *vc = [[YHBStoreViewController alloc] initWithShopID:userid];
            [[self viewController].navigationController pushViewController:vc animated:YES];
        }
    }
}

//获取viewcontroller
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", phoneNumber]]];
    }
}

#pragma mark - 登陆状态校验
- (BOOL)userLoginConfirm
{
    if ([YHBUser sharedYHBUser].isLogin) {
        return YES;
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginForUserMessage object:[NSNumber numberWithBool:NO]];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessItem) name:kLoginSuccessMessae object:nil];
        return NO;
    }
}

- (void)showMessageView:(NSString *)aMessageBody
{
    if( [MFMessageComposeViewController canSendText] )// 判断设备能不能发送短信
    {
        MFMessageComposeViewController*picker = [[MFMessageComposeViewController alloc] init];
        // 设置委托
        picker.messageComposeDelegate= self;
        // 默认信息内容
        picker.body = aMessageBody;
        // 默认收件人(可多个)
        picker.recipients = [NSArray arrayWithObject:phoneNumber];
        [[self viewController] presentViewController:picker animated:YES completion:^{
            
        }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
    }
}



#pragma mark -
#pragma mark MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
    switch (result){
        case MessageComposeResultCancelled:
            NSLog(@"取消发送");
            [SVProgressHUD showErrorWithStatus:@"取消发送" cover:YES offsetY:kMainScreenHeight/2.0];
            break;
        case MessageComposeResultFailed:
            [SVProgressHUD showErrorWithStatus:@"发送失败" cover:YES offsetY:kMainScreenHeight/2.0];
            NSLog(@"发送失败");
            break;
        case MessageComposeResultSent:
            [SVProgressHUD showSuccessWithStatus:@"发送成功" cover:YES offsetY:kMainScreenHeight/2.0];
            NSLog(@"发送成功");
            break;
            
        default:
            break;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
