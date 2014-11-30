//
//  YHBEditSupplyView.m
//  TestButton
//
//  Created by Johnny's on 14/11/18.
//  Copyright (c) 2014年 Johnny's. All rights reserved.
//

#import "YHBEditSupplyView.h"

#define labelHeight 20
#define interval 10
#define keyBoardHeight 224
@implementation YHBEditSupplyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        oldFrame = frame;
        oldScrollFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        contentScrollView = [[UIScrollView alloc] initWithFrame:oldScrollFrame];
        contentScrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        [self addSubview:contentScrollView];
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, frame.size.width-6, frame.size.height)];
        backGroundView.layer.borderColor = [[UIColor grayColor] CGColor];
        backGroundView.layer.borderWidth = 0.5;
        [contentScrollView addSubview:backGroundView];
        
        NSArray *strArray = @[@"名       称 |",@"价       格 |",@"风       格 |",@"成       分 |",@"用       途 |",@"工       艺 |",@"供货状态 |",@"详细描述 |"];
        for (int i=0; i<strArray.count; i++)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, interval+(labelHeight+interval)*i, 70, labelHeight)];
            label.text = [strArray objectAtIndex:i];
            label.font = [UIFont systemFontOfSize:15];
            [contentScrollView addSubview:label];
        }
        
        titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, interval, 90, labelHeight)];
        titleTextField.font = [UIFont systemFontOfSize:15];
        titleTextField.layer.borderColor = [[UIColor blackColor] CGColor];
        titleTextField.returnKeyType = UIReturnKeyDone;
        titleTextField.delegate = self;
        titleTextField.layer.borderWidth = 0.5;
        [contentScrollView addSubview:titleTextField];
        
        UILabel *nameLabelNote = [[UILabel alloc] initWithFrame:CGRectMake(titleTextField.right+3, titleTextField.top, 120, labelHeight)];
        nameLabelNote.font = [UIFont systemFontOfSize:12];
        nameLabelNote.textColor = [UIColor lightGrayColor];
        nameLabelNote.text = @"请输入您要发布的名称";
        [contentScrollView addSubview:nameLabelNote];
        
        priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, interval*2+labelHeight, 90, labelHeight)];
        priceTextField.font = [UIFont systemFontOfSize:15];
        priceTextField.layer.borderColor = [[UIColor blackColor] CGColor];
        priceTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        priceTextField.returnKeyType = UIReturnKeyDone;
        priceTextField.delegate = self;
        priceTextField.layer.borderWidth = 0.5;
        [contentScrollView addSubview:priceTextField];
        
        UILabel *priceLabelNote = [[UILabel alloc] initWithFrame:CGRectMake(priceTextField.right+3, priceTextField.top, 120, labelHeight)];
        priceLabelNote.font = [UIFont systemFontOfSize:12];
        priceLabelNote.textColor = [UIColor lightGrayColor];
        priceLabelNote.text = @"平方米/元";
        [contentScrollView addSubview:priceLabelNote];
        
        UITextView *contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(80, interval+(interval+labelHeight)*7, [UIScreen mainScreen].bounds.size.width-90, 70)];
        contentTextView.layer.borderWidth = 0.5;
        contentTextView.layer.borderColor = [[UIColor blackColor] CGColor];
        contentTextView.font = [UIFont systemFontOfSize:15];
        contentTextView.returnKeyType = UIReturnKeyDone;
        contentTextView.delegate = self;
        contentTextView.backgroundColor = [UIColor clearColor];
        [contentScrollView addSubview:contentTextView];
        
        NSArray *typeArray = @[@"现货",@"订购",@"促销"];
        typeVariousView = [[YHBVariousView alloc] initWithFrame:CGRectMake(80, interval+6*(labelHeight+interval), 50, labelHeight) andItemArray:typeArray andSelectedItem:0];
        [contentScrollView addSubview:typeVariousView];
        
        NSArray *itemArray = @[@"欧式",@"中式",@"韩国风",@"美式"];
        for (int i=3; i>-1; i--)
        {
            YHBVariousView *view = [[YHBVariousView alloc] initWithFrame:CGRectMake(80, interval+(2+i)*(labelHeight+interval), 50, labelHeight) andItemArray:itemArray andSelectedItem:2];
            [contentScrollView addSubview:view];
        }
    }
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self keyboardWillAppear];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==priceTextField)
    {
        _price = textField.text;
    }
    else
    {
        _title = textField.text;
    }
    [textField resignFirstResponder];
    [self keyboardDidDisappear];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self keyboardWillAppear];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        _content = textView.text;
        [textView resignFirstResponder];
        [self keyboardDidDisappear];
    }
    return YES;
}

- (void)keyboardWillAppear
{
    //注册通知,监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidHidden)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
}

//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    
    BOOL isSmallPhone = NO;
    float newScrollHeight = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62;
    if (newScrollHeight+20<oldFrame.size.height)
    {
        isSmallPhone = YES;
    }
    [UIView animateWithDuration:0.2 animations:^{
        CGRect temFrame = self.frame;
        CGFloat newOriginY;
        if ([titleTextField isFirstResponder])
        {
            if (isSmallPhone)
            {
                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-200;
                contentScrollView.frame = CGRectMake(0, 0, oldFrame.size.width, newScrollHeight);
            }
            else
            {
                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-290;
            }
        }
        else if([priceTextField isFirstResponder])
        {
            if (isSmallPhone)
            {
                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-230;
                contentScrollView.frame = CGRectMake(0, 30, oldFrame.size.width, newScrollHeight);
            }
            else
            {
                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-290;
            }
        }
        else
        {
            if (isSmallPhone)
            {
                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-280;
                contentScrollView.frame = CGRectMake(0, 80, oldFrame.size.width, newScrollHeight);
            }
            else
            {
                newOriginY = [UIScreen mainScreen].bounds.size.height-keyBoardHeight-62-290;
            }
        }
        CGFloat oldOriginY = temFrame.origin.y;
        temFrame.origin.y = oldOriginY<newOriginY?oldOriginY:newOriginY;
        self.frame = temFrame;
    }];
}

- (void)handleKeyboardDidHidden
{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = oldFrame;
        contentScrollView.frame = CGRectMake(0, 0, oldFrame.size.width, oldFrame.size.height);
    }];
}

- (void)keyboardDidDisappear
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
