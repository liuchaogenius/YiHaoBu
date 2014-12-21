//
//  YHBEditSupplyView.m
//  TestButton
//
//  Created by Johnny's on 14/11/18.
//  Copyright (c) 2014年 Johnny's. All rights reserved.
//

#import "YHBEditSupplyView.h"
#import "TitleTagViewController.h"

#define labelHeight 20
#define interval 15
#define keyBoardHeight 224
@implementation YHBEditSupplyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        self.userInteractionEnabled = YES;
        oldFrame = frame;
//        oldScrollFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        contentScrollView = [[UIScrollView alloc] initWithFrame:oldScrollFrame];
//        contentScrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
//        [self addSubview:contentScrollView];
        self.typeid=0;
        self.backgroundColor = [UIColor whiteColor];
//        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        
//        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, frame.size.width-6, frame.size.height)];
//        backGroundView.layer.borderColor = [[UIColor grayColor] CGColor];
//        backGroundView.layer.borderWidth = 0.5;
//        [contentScrollView addSubview:backGroundView];
        
        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 0.5)];
        topLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:topLineView];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, kMainScreenWidth, 0.5)];
        bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomLineView];
        
        NSArray *strArray = @[@"名       称 |",@"价       格 |",@"到期时间 |",@"分       类 |",@"供货状态 |",@"详细描述 |"];
        for (int i=0; i<strArray.count; i++)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, interval+(labelHeight+interval)*i, 70, labelHeight)];
            label.text = [strArray objectAtIndex:i];
            label.font = [UIFont systemFontOfSize:15];
//            [contentScrollView addSubview:label];
            [self addSubview:label];
        }
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, interval-3, 180, labelHeight+6)];
        titleLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        titleLabel.layer.borderWidth = 0.5;
        titleLabel.text = @"请输入您要发布的名称";
        titleLabel.userInteractionEnabled = YES;
        titleLabel.font = kFont14;
        titleLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:titleLabel];
        
        tapTitleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTitle)];
        [titleLabel addGestureRecognizer:tapTitleGesture];
        
//        titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, interval, 90, labelHeight)];
//        titleTextField.font = [UIFont systemFontOfSize:15];
//        titleTextField.layer.borderColor = [[UIColor blackColor] CGColor];
//        titleTextField.returnKeyType = UIReturnKeyDone;
//        titleTextField.delegate = self;
//        titleTextField.layer.borderWidth = 0.5;
//        [contentScrollView addSubview:titleTextField];
//        
//        UILabel *nameLabelNote = [[UILabel alloc] initWithFrame:CGRectMake(titleTextField.right+3, titleTextField.top, 120, labelHeight)];
//        nameLabelNote.font = [UIFont systemFontOfSize:12];
//        nameLabelNote.textColor = [UIColor lightGrayColor];
//        nameLabelNote.text = @"请输入您要发布的名称";
//        [contentScrollView addSubview:nameLabelNote];
//        
        priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, interval*2+labelHeight-3, 80, labelHeight+6)];
        priceTextField.font = [UIFont systemFontOfSize:15];
        priceTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        priceTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        priceTextField.returnKeyType = UIReturnKeyDone;
        priceTextField.delegate = self;
        priceTextField.textAlignment = NSTextAlignmentCenter;
        priceTextField.layer.borderWidth = 0.5;
        [self addSubview:priceTextField];

        UILabel *priceLabelNote = [[UILabel alloc] initWithFrame:CGRectMake(priceTextField.right+3, priceTextField.top, 120, labelHeight+6)];
        priceLabelNote.font = [UIFont systemFontOfSize:15];
        priceLabelNote.textColor = [UIColor lightGrayColor];
        priceLabelNote.text = @"元/米";
        [self addSubview:priceLabelNote];

        dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, (interval+labelHeight)*2+interval-3, 80, labelHeight+6)];
        dayLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        dayLabel.layer.borderWidth = 0.5;
        dayLabel.font = kFont15;
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.userInteractionEnabled = YES;
        dayLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:dayLabel];
        
        tapDayGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchDay)];
        [dayLabel addGestureRecognizer:tapDayGesture];

        UILabel *dayLabelNote = [[UILabel alloc] initWithFrame:CGRectMake(dayLabel.right+3, dayLabel.top, 120, labelHeight+6)];
        dayLabelNote.font = [UIFont systemFontOfSize:15];
        dayLabelNote.textColor = [UIColor lightGrayColor];
        dayLabelNote.text = @"天";
        [self addSubview:dayLabelNote];
        
        catNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, (interval+labelHeight)*3+interval-3, 160, labelHeight+6)];
        catNameLabel.layer.borderWidth = 0.5;
        catNameLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self addSubview:catNameLabel];
        
        NSArray *array = @[@"现货",@"期货",@"促销"];
        for (int i=0; i<3; i++)
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(85+(labelHeight+6+40)*i, (interval+labelHeight)*4+interval-3, labelHeight+6, labelHeight+6)];
            btn.backgroundColor = [UIColor yellowColor];
            btn.tag=10+i;
            [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i==0) {
                btn.backgroundColor = [UIColor redColor];
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btn.right+5, btn.top, 30, labelHeight+6)];
            label.text = [array objectAtIndex:i];
            label.font = kFont15;
            label.textColor = [UIColor lightGrayColor];
            [self addSubview:label];
        }
        
        contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(85, interval+(interval+labelHeight)*5, 180, 70)];
        contentTextView.layer.borderWidth = 0.5;
        contentTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        contentTextView.font = [UIFont systemFontOfSize:15];
        contentTextView.returnKeyType = UIReturnKeyDone;
        contentTextView.delegate = self;
        contentTextView.backgroundColor = [UIColor clearColor];
        [self addSubview:contentTextView];
        
//        NSArray *typeArray = @[@"现货",@"订购",@"促销"];
//        typeVariousView = [[YHBVariousView alloc] initWithFrame:CGRectMake(80, interval+6*(labelHeight+interval), 50, labelHeight) andItemArray:typeArray andSelectedItem:0];
//        [contentScrollView addSubview:typeVariousView];
//        
//        NSArray *itemArray = @[@"欧式",@"中式",@"韩国风",@"美式"];
//        for (int i=3; i>-1; i--)
//        {
//            YHBVariousView *view = [[YHBVariousView alloc] initWithFrame:CGRectMake(80, interval+(2+i)*(labelHeight+interval), 50, labelHeight) andItemArray:itemArray andSelectedItem:2];
//            [contentScrollView addSubview:view];
//        }
    }
    return self;
}

- (void)touchTitle
{
    TitleTagViewController *vc = [[TitleTagViewController alloc] init];
    [vc useBlock:^(NSString *title) {
        if ([title isEqualToString:@""])
        {
            titleLabel.text = @"请输入您要发布的名称";
            titleLabel.textColor = [UIColor lightGrayColor];
        }
        else
        {
            titleLabel.text = title;
            titleLabel.textColor = [UIColor blackColor];
        }
    }];
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

- (void)touchDay
{
    MLOG(@"1");
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

- (void)touchBtn:(UIButton *)aBtn
{
    for (int i=0; i<3; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i+10];
        [btn setImage:[UIImage imageNamed:@"btnNotChoose"] forState:UIControlStateNormal];
    }
    [aBtn setImage:[UIImage imageNamed:@"btnChoose"] forState:UIControlStateNormal];
    self.typeid = (int)aBtn.tag-10;
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    [self keyboardWillAppear];
//    return YES;
//}
//
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==priceTextField)
    {
        _price = textField.text;
    }
    [textField resignFirstResponder];
//    [self keyboardDidDisappear];
    return YES;
}
//
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    [self keyboardWillAppear];
//    return YES;
//}
//
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        _content = textView.text;
        [textView resignFirstResponder];
//        [self keyboardDidDisappear];
    }
    return YES;
}
//
//- (void)keyboardWillAppear
//{
//    //注册通知,监听键盘出现
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(handleKeyboardDidShow:)
//                                                name:UIKeyboardWillShowNotification
//                                              object:nil];
//    //注册通知，监听键盘消失事件
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(handleKeyboardDidHidden)
//                                                name:UIKeyboardWillHideNotification
//                                              object:nil];
//}
//
////监听事件
//- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
//{
//    //获取键盘高度
//    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
//    
//    CGRect keyboardRect;
//    [keyboardRectAsObject getValue:&keyboardRect];
//    
//    BOOL isSmallPhone = NO;
//    float newScrollHeight = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62;
//    if (newScrollHeight+20<oldFrame.size.height)
//    {
//        isSmallPhone = YES;
//    }
//    [UIView animateWithDuration:0.2 animations:^{
//        CGRect temFrame = self.frame;
//        CGFloat newOriginY;
//        if ([contentTextView isFirstResponder])
//        {
//            if (isSmallPhone)
//            {
//                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-200;
//                contentScrollView.frame = CGRectMake(0, 0, oldFrame.size.width, newScrollHeight);
//            }
//            else
//            {
//                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-290;
//            }
//        }
////        else if([priceTextField isFirstResponder])
////        {
////            if (isSmallPhone)
////            {
////                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-230;
////                contentScrollView.frame = CGRectMake(0, 30, oldFrame.size.width, newScrollHeight);
////            }
////            else
////            {
////                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-290;
////            }
////        }
////        else
////        {
////            if (isSmallPhone)
////            {
////                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-280;
////                contentScrollView.frame = CGRectMake(0, 80, oldFrame.size.width, newScrollHeight);
////            }
////            else
////            {
////                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-290;
////            }
////        }
//        CGFloat oldOriginY = temFrame.origin.y;
//        temFrame.origin.y = oldOriginY<newOriginY?oldOriginY:newOriginY;
//        self.frame = temFrame;
//    }];
//}
//
//- (void)handleKeyboardDidHidden
//{
//    [UIView animateWithDuration:0.2 animations:^{
//        self.frame = oldFrame;
////        contentScrollView.frame = CGRectMake(0, 0, oldFrame.size.width, oldFrame.size.height);
//    }];
//}
//
//- (void)keyboardDidDisappear
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


@end
