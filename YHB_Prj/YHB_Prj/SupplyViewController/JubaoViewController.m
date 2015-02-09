//
//  JubaoViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/2/7.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "JubaoViewController.h"
#import "jubaoManage.h"
#import "SVProgressHUD.h"

#define cellHeight 38
@interface JubaoViewController ()<UITextViewDelegate>
{
    int itemid;
    int selectIndex;
    UITextView *_textView;
    UILabel *detailPlaceHolder;
    UIScrollView *scrollView;
    UIButton *publishBtn;
    jubaoManage *manage;
    BOOL ischoose;
    int moduleid;
}
@property(nonatomic, strong) UIView *redView;
@end

@implementation JubaoViewController

- (instancetype)initWithItemid:(int)aItemid isSupply:(BOOL)aBool
{
    if (self = [super init]) {
        itemid = aItemid;
        if (aBool==YES)
        {
            moduleid=5;
        }
        else
        {
            moduleid=6;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settitleLabel:@"选择原因"];
    self.view.backgroundColor = RGBCOLOR(239, 239, 239);
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kMainScreenWidth-10, 15)];
    label1.textColor = [UIColor lightGrayColor];
    label1.text = @"请选择举报原因";
    label1.font = kFont12;
    [scrollView addSubview:label1];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, label1.bottom+10, kMainScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView];
    
//    CGSize size = [@"12" sizeWithFont:kFont15];

    NSArray *array = @[@"欺诈",@"色情",@"无效信息",@"恶意营销",@"隐私信息收集"];
    for (int i=0; i<5; i++)
    {
        UIButton *backView = [[UIButton alloc] initWithFrame:CGRectMake(0, cellHeight*i+lineView.bottom, kMainScreenWidth, cellHeight)];
        backView.tag = 100+i;
        [backView addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        backView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:backView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-0.5, kMainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [backView addSubview:line];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, (cellHeight-18)/2.0, 18, 18)];
        btn.layer.cornerRadius = 9.0;
        btn.tag = 1000+i;
//        [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        btn.layer.borderWidth = 0.5;
//        btn.tag = 100+i;
        [backView addSubview:btn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btn.right+10, btn.top, 200, 18)];
        label.font = kFont15;
        label.text = [array objectAtIndex:i];
        [backView addSubview:label];
    }
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, cellHeight*array.count+lineView.bottom+10, kMainScreenWidth-10, 15)];
    label2.textColor = [UIColor lightGrayColor];
    label2.text = @"其他补充说明";
    label2.font = kFont12;
    [scrollView addSubview:label2];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, label2.bottom+10, kMainScreenWidth, 100)];
    _textView.font = kFont12;
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    [scrollView addSubview:_textView];
    
    detailPlaceHolder = [[UILabel alloc] initWithFrame:CGRectMake(5, _textView.top+5, kMainScreenWidth, 15)];
    detailPlaceHolder.text = @"请输入...";
    detailPlaceHolder.font = kFont12;
    detailPlaceHolder.textColor = [UIColor lightGrayColor];
    [scrollView addSubview:detailPlaceHolder];
    
    publishBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, _textView.bottom+20, kMainScreenWidth-20, 40)];
    publishBtn.layer.cornerRadius = 2.5;
    publishBtn.backgroundColor = KColor;
    [publishBtn setTitle:@"发 送" forState:UIControlStateNormal];
    [publishBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [publishBtn addTarget:self action:@selector(touchPublish)
         forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:publishBtn];
    
    
    CGFloat endHeight = publishBtn.bottom+20;
    CGFloat contentHeight = endHeight>kMainScreenHeight-61?endHeight:kMainScreenHeight-61;
    scrollView.contentSize = CGSizeMake(kMainScreenWidth, contentHeight);
    
    manage = [[jubaoManage alloc] init];
    ischoose = NO;
}

- (void)touchPublish
{
    if (ischoose==YES)
    {
        [SVProgressHUD show:YES offsetY:kMainScreenHeight/2.0];
        [manage jubaoModuleid:moduleid itemid:itemid typeid:selectIndex-100+1 andintroduce:_textView.text succBlock:^{
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"举报成功" cover:YES offsetY:kMainScreenHeight/2.0];
        } failBlock:^(NSString *aStr) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
        }];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请选择举报类型" cover:YES offsetY:kMainScreenHeight/2.0];
    }
}

- (UIView *)redView
{
    if (!_redView)
    {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(4, 4, 10, 10)];
        _redView.backgroundColor = [UIColor redColor];
        _redView.layer.cornerRadius = 5.0;
        _redView.layer.borderColor = [[UIColor redColor] CGColor];
        _redView.layer.borderWidth = 0.5;
    }
    return _redView;
}

- (void)touchBtn:(UIButton *)aBtn
{
    for (int i=0; i<6; i++)
    {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        [btn removeSubviews];
    }
    int index = (int)aBtn.tag-100;
    UIButton *btn = (UIButton *)[self.view viewWithTag:1000+index];
    [btn addSubview:self.redView];
    selectIndex = (int)aBtn.tag;
    if (ischoose==NO) {
        ischoose=YES;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
                [self keyboardDidDisappear];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0)
    {
        detailPlaceHolder.hidden = YES;
    }
    else
    {
        detailPlaceHolder.hidden = NO;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self keyboardWillAppear];
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
    
    CGFloat keyBoardHeight = keyboardRect.size.height;
    if (keyBoardHeight+publishBtn.bottom+10+62>kMainScreenHeight)
    {
        float x = keyBoardHeight+publishBtn.bottom+10+62-kMainScreenHeight;
        CGRect frame = scrollView.frame;
        frame.origin.y -= x;
        [UIView animateWithDuration:0.2 animations:^{
            scrollView.frame = frame;
        }];
    }
    
}

- (void)handleKeyboardDidHidden
{
    CGRect frame = scrollView.frame;
    frame.origin.y = 0;
    [UIView animateWithDuration:0.2 animations:^{
        scrollView.frame = frame;
    }];
}

- (void)keyboardDidDisappear
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
