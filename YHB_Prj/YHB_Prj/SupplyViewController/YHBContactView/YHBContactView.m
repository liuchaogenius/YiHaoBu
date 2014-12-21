//
//  YHBContactView.m
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBContactView.h"
typedef enum:NSUInteger{
    btnTypePhone = 12,
    btnTypeText = 13,
    btnTypeChat = 14
}btnType;
@implementation YHBContactView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat viewHeight = frame.size.height;
        
        UIView *redLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 3)];
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
        
        CGFloat interval = (kMainScreenWidth-firstView.right-15-60-30*2)/3.0;
        
        secondView = [[UIButton alloc] initWithFrame:CGRectMake(firstView.right+interval, 0, 30, viewHeight)];
        secondView.tag=btnTypePhone;
        [secondView addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:secondView];
        
        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(3, 10, 24, 24)];
        imgView2.image = [UIImage imageNamed:@"phoneImg"];
        [secondView addSubview:imgView2];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView2.bottom+3, 30, 18)];
        label2.font = kFont15;
        label2.text = @"电话";
        [secondView addSubview:label2];
        
        thirdView = [[UIButton alloc] initWithFrame:CGRectMake(secondView.right+interval, 0, 30, viewHeight)];
        thirdView.tag=btnTypeText;
        [thirdView addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:thirdView];
        
        UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(3, 10, 24, 24)];
        imgView3.image = [UIImage imageNamed:@"textImg"];
        [thirdView addSubview:imgView3];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView3.bottom+3, 30, 18)];
        label3.font = kFont15;
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
    return self;
}

- (void)setPhoneNumber:(NSString *)aNumber storeName:(NSString *)aName itemId:(int)aItemId isVip:(int)aisVip
{
    if (aisVip==1)
    {
        UIImageView *vipImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        vipImgView.image = [UIImage imageNamed:@"vipLeftImg"];
        [self addSubview:vipImgView];
        firstView.right += 20;
        secondView.right += 10;
        thirdView.right += 5;
    }
    phoneLabel.text = aNumber;
    storeLabel.text = aName;
    phoneNumber = aNumber;
    itemId=aItemId;
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
        }

    }
    else if(aBtn.tag==btnTypeText)
    {
        if (phoneNumber)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"是否发短信给%@", phoneNumber] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发送", nil];
            [alertView show];
        }
    }
    else if(aBtn.tag==btnTypeChat)
    {
        MLOG(@"在线沟通");
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", phoneNumber]]];
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
