//
//  YHBPublishSupplyViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBPublishSupplyViewController.h"
#import "YHBVariousImageView.h"
#import "YHBSupplyDetailViewController.h"
#import "TitleTagViewController.h"
#import "SVProgressHUD.h"
#import "YHBPublishSupplyManage.h"
#import "CategoryViewController.h"
#import "YHBCatSubcate.h"
#import "YHBUser.h"
#import "YHBUploadImageManage.h"
#import "NetManager.h"


#define kButtonTag_Yes 100
@interface YHBPublishSupplyViewController ()<UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIScrollView *scrollView;
    UITextField *nameTextField;
    UITextField *phoneTextField;
    
    NSString *content;
    int typeId;
    float price;
    int pickViewSelected;
    
    UILabel *titleLabel;
    UITextField *priceTextField;
    UILabel *dayLabel;
    UIView *dayView;
    UILabel *catNameLabel;
    UITextView *contentTextView;
    UITapGestureRecognizer *tapTitleGesture;
    UITapGestureRecognizer *tapDayGesture;
    YHBSupplyDetailModel *myModel;
    BOOL isClean;
    
    NSString *catidString;
    
    YHBVariousImageView *variousImageView;
//    YHBUploadImageManage *netManage;
}

@property(nonatomic, strong) UIPickerView *dayPickerView;
@property(nonatomic, strong) UIView *toolView;
@property(nonatomic, strong) YHBPublishSupplyManage *netManage;
@end

@implementation YHBPublishSupplyViewController

- (instancetype)initWithModel:(YHBSupplyDetailModel *)aModel
{
    if (self = [super init]) {
        myModel = aModel;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(dismissSelf)];
    
    self.title = @"发布供应";
    self.view.backgroundColor = RGBCOLOR(241, 241, 241);
    isClean = NO;
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    variousImageView = [[YHBVariousImageView alloc] initEditWithFrame:CGRectMake(0, 0, kMainScreenWidth, 120)];
    [scrollView addSubview:variousImageView];
    
#pragma mark 中间View
    float labelHeight = 20;//label高度
    float interval = 20;//label之间间隔
    float editViewHeight = 310;//中间view高度
    typeId=0;
    
    UIView *editSupplyView = [[UIView alloc] initWithFrame:CGRectMake(0, variousImageView.bottom, kMainScreenWidth, editViewHeight)];
    editSupplyView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:editSupplyView];
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 0.5)];
    topLineView.backgroundColor = [UIColor lightGrayColor];
    [editSupplyView addSubview:topLineView];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, editViewHeight-0.5, kMainScreenWidth, 0.5)];
    bottomLineView.backgroundColor = [UIColor lightGrayColor];
    [editSupplyView addSubview:bottomLineView];
    
    NSArray *strArray = @[@"名       称 |",@"价       格 |",@"到期时间 |",@"分       类 |",@"供货状态 |",@"详细描述 |"];
    for (int i=0; i<strArray.count; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, interval+(labelHeight+interval)*i, 70, labelHeight)];
        label.text = [strArray objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:15];
        //            [contentScrollView addSubview:label];
        [editSupplyView addSubview:label];
    }
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, interval-5, 200, labelHeight+10)];
    titleLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    titleLabel.layer.borderWidth = 0.5;
    titleLabel.text = @"请输入您要发布的名称";
    titleLabel.userInteractionEnabled = YES;
    titleLabel.font = kFont14;
//    titleLabel.textColor = [UIColor lightGrayColor];
    [editSupplyView addSubview:titleLabel];
    
    UIImageView *rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(titleLabel.right-titleLabel.left-12, (labelHeight+10-15)/2, 9, 15)];
    [rightArrow setImage:[UIImage imageNamed:@"rightArrow"]];
    [titleLabel addSubview:rightArrow];
    
    tapTitleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTitle)];
    [titleLabel addGestureRecognizer:tapTitleGesture];
    
    priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, interval*2+labelHeight-5, 80, labelHeight+10)];
    priceTextField.font = [UIFont systemFontOfSize:15];
    priceTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    priceTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    priceTextField.returnKeyType = UIReturnKeyDone;
    priceTextField.delegate = self;
//    priceTextField.textColor = [UIColor lightGrayColor];
//    priceTextField.textAlignment = NSTextAlignmentCenter;
    priceTextField.layer.borderWidth = 0.5;
    [editSupplyView addSubview:priceTextField];
    
    UILabel *priceLabelNote = [[UILabel alloc] initWithFrame:CGRectMake(priceTextField.right+3, priceTextField.top, 120, labelHeight+10)];
    priceLabelNote.font = [UIFont systemFontOfSize:15];
    priceLabelNote.textColor = [UIColor lightGrayColor];
    priceLabelNote.text = @"元/米";
    [editSupplyView addSubview:priceLabelNote];
    
    dayView = [[UIView alloc] initWithFrame:CGRectMake(85, (interval+labelHeight)*2+interval-5, 80, labelHeight+10)];
    dayView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    dayView.layer.borderWidth = 0.5;
    dayView.userInteractionEnabled = YES;
    [editSupplyView addSubview:dayView];
    
    dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80-18, labelHeight+10)];
    dayLabel.font = kFont15;
//    dayLabel.textAlignment = NSTextAlignmentCenter;
//    dayLabel.textColor = [UIColor lightGrayColor];
    dayLabel.userInteractionEnabled = YES;
    [dayView addSubview:dayLabel];
    
    UIImageView *downArrow = [[UIImageView alloc] initWithFrame:CGRectMake(dayView.right-dayView.left-18, (labelHeight+10-12)/2+2, 15, 9)];
    [downArrow setImage:[UIImage imageNamed:@"downArrow"]];
    [dayView addSubview:downArrow];
    
    tapDayGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchDay)];
    [dayView addGestureRecognizer:tapDayGesture];
    
    UILabel *dayLabelNote = [[UILabel alloc] initWithFrame:CGRectMake(dayView.right+3, dayView.top, 120, labelHeight+10)];
    dayLabelNote.font = [UIFont systemFontOfSize:15];
    dayLabelNote.textColor = [UIColor lightGrayColor];
    dayLabelNote.text = @"天";
    [editSupplyView addSubview:dayLabelNote];
    
    catNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, (interval+labelHeight)*3+interval-5, 177, labelHeight+10)];
    catNameLabel.layer.borderWidth = 0.5;
    catNameLabel.font = kFont15;
    catNameLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [editSupplyView addSubview:catNameLabel];
    
    UIImageView *plusImgView = [[UIImageView alloc] initWithFrame:CGRectMake(catNameLabel.right, catNameLabel.top, 23, 30)];
    plusImgView.image = [UIImage imageNamed:@"plusImg"];
    plusImgView.userInteractionEnabled = YES;
    [editSupplyView addSubview:plusImgView];
    
    UITapGestureRecognizer *tapGestureReco = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCat)];
    [plusImgView addGestureRecognizer:tapGestureReco];
    
    NSArray *array = @[@"现货",@"期货",@"促销"];
    for (int i=0; i<3; i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(85+(labelHeight+10+40)*i, (interval+labelHeight)*4+interval-5, labelHeight+6, labelHeight+6)];
        [btn setImage:[UIImage imageNamed:@"btnNotChoose"] forState:UIControlStateNormal];
        btn.tag=10+i;
        [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [editSupplyView addSubview:btn];
        if (i==0) {
            [btn setImage:[UIImage imageNamed:@"btnChoose"] forState:UIControlStateNormal];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btn.right+5, btn.top, 30, labelHeight+10)];
        label.text = [array objectAtIndex:i];
        label.font = kFont15;
        label.textColor = [UIColor lightGrayColor];
        [editSupplyView addSubview:label];
    }
    
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(85, interval+(interval+labelHeight)*5, 200, 70)];
    contentTextView.layer.borderWidth = 0.5;
    contentTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    contentTextView.font = [UIFont systemFontOfSize:15];
    contentTextView.returnKeyType = UIReturnKeyDone;
    contentTextView.delegate = self;
    contentTextView.backgroundColor = [UIColor clearColor];
    [editSupplyView addSubview:contentTextView];
    
    if (myModel)
    {
        titleLabel.text = myModel.title;
        priceTextField.text = myModel.price;
        catNameLabel.text = myModel.catname;
        contentTextView.text = myModel.content;
    }
    
#pragma mark 下面View
    UIView *contactView = [[UIView alloc] initWithFrame:CGRectMake(0, editSupplyView.bottom+10, kMainScreenWidth, 90)];
    [scrollView addSubview:contactView];
    contactView.backgroundColor = [UIColor whiteColor];
    
    UILabel *personNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 75, 20)];
    personNameLabel.font = kFont15;
    personNameLabel.text = @"联 系 人 : ";
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(personNameLabel.left, personNameLabel.bottom+20, 75, 20)];
    phoneLabel.font = kFont15;
    phoneLabel.text = @"联系电话 : ";
    
    YHBUser *user = [YHBUser sharedYHBUser];
    
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(contentTextView.left, personNameLabel.top-5, 200, labelHeight+10)];
    nameTextField.font = kFont15;
    nameTextField.delegate = self;
    nameTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    nameTextField.layer.borderWidth = 0.5;
    nameTextField.returnKeyType = UIReturnKeyDone;
    nameTextField.text = user.userInfo.truename;
    
    phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(contentTextView.left, phoneLabel.top-5, 200, labelHeight+10)];
    phoneTextField.font = kFont15;
    phoneTextField.delegate = self;
    phoneTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    phoneTextField.layer.borderWidth = 0.5;
    phoneTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phoneTextField.returnKeyType = UIReturnKeyDone;
    phoneTextField.text = user.userInfo.mobile;
    
    [contactView addSubview:phoneTextField];
    [contactView addSubview:nameTextField];
    [contactView addSubview:personNameLabel];
    [contactView addSubview:phoneLabel];
    
    
    UIButton *publishBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, contactView.bottom+10, kMainScreenWidth-20, 40)];
    publishBtn.layer.cornerRadius = 2.5;
    publishBtn.backgroundColor = KColor;
    [publishBtn setTitle:@"发 布" forState:UIControlStateNormal];
    [publishBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [publishBtn addTarget:self action:@selector(TouchPublish)
         forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:publishBtn];
    
    scrollView.contentSize = CGSizeMake(kMainScreenWidth, publishBtn.bottom+10);
}

#pragma mark getter
- (YHBPublishSupplyManage *)netManage
{
    if (!_netManage) {
        _netManage = [[YHBPublishSupplyManage alloc] init];
    }
    return _netManage;
}

- (UIPickerView *)dayPickerView
{
    if (!_dayPickerView)
    {
        _dayPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight+30, kMainScreenWidth, 200)];
        _dayPickerView.backgroundColor = [UIColor whiteColor];
        _dayPickerView.dataSource = self;
        _dayPickerView.delegate = self;
    }
    return _dayPickerView;
}

- (UIView *)toolView
{
    if (!_toolView) {
        _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.dayPickerView.top-30, kMainScreenWidth, 40)];
        _toolView.backgroundColor = [UIColor lightGrayColor];
        UIButton *_tool = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 60, 0, 60, 40)];
        [_tool setTitle:@"完成" forState:UIControlStateNormal];
        _tool.titleLabel.textAlignment = NSTextAlignmentCenter;
        _tool.tag = kButtonTag_Yes;
        _tool.titleLabel.font = kFont15;
        _tool.backgroundColor = [UIColor clearColor];
        [_tool addTarget:self action:@selector(pickerPickEnd:) forControlEvents:UIControlEventTouchDown];
        [_toolView addSubview:_tool];
        
        UIButton *_cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cancelBtn.titleLabel.font = kFont15;
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn addTarget:self action:@selector(pickerPickEnd:) forControlEvents:UIControlEventTouchDown];
        [_toolView addSubview:_cancelBtn];
    }
    return _toolView;
}

#pragma mark pickerView datasource delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 7;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld", row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    pickViewSelected = (int)row;
}

- (void)pickerPickEnd:(UIButton *)aBtn
{
    if (aBtn.tag == kButtonTag_Yes)
    {
        dayLabel.text = [NSString stringWithFormat:@"%d", pickViewSelected+1];
    }
    self.dayPickerView.top = kMainScreenHeight+30;
    self.toolView.top = self.dayPickerView.top-30;
    [self.dayPickerView removeFromSuperview];
    [aBtn.superview removeFromSuperview];
}

#pragma mark 点击cat
- (void)touchCat
{
    CategoryViewController *vc = [CategoryViewController sharedInstancetype];
    if (!isClean) {
        isClean = YES;
        [vc cleanAll];
    }
    vc.isPushed = YES;
    [vc setBlock:^(NSArray *aArray) {
        NSString *str = @"";
        NSString *idStr = @"";
        for (YHBCatSubcate *subModel in aArray) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@" %@", subModel.catname]];
            idStr = [str stringByAppendingString:[NSString stringWithFormat:@",%d", (int)subModel.catid]];
        }
        catidString = [idStr substringFromIndex:1];
        catNameLabel.text = str;
    }];
    [self.navigationController pushViewController:vc animated:YES];
} 

#pragma mark 点击标题
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
//            titleLabel.textColor = [UIColor blackColor];
        }
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 点击天数
- (void)touchDay
{
    if (self.dayPickerView.top != kMainScreenHeight-200)
    {
        [priceTextField resignFirstResponder];
        [contentTextView resignFirstResponder];
        [self.dayPickerView reloadAllComponents];
        [self.view addSubview:self.dayPickerView];
        [self.view addSubview:self.toolView];
        [UIView animateWithDuration:0.2 animations:^{
            self.dayPickerView.top = kMainScreenHeight-200;
            self.toolView.top = self.dayPickerView.top-30;
        }];
    }
}

#pragma mark 菊花
- (void)showFlower
{
    [SVProgressHUD show:YES offsetY:kMainScreenHeight/2.0];
}

- (void)dismissFlower
{
    [SVProgressHUD dismiss];
}

#pragma mark 选择类型
- (void)touchBtn:(UIButton *)aBtn
{
    for (int i=0; i<3; i++)
    {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i+10];
        [btn setImage:[UIImage imageNamed:@"btnNotChoose"] forState:UIControlStateNormal];
    }
    [aBtn setImage:[UIImage imageNamed:@"btnChoose"] forState:UIControlStateNormal];
    typeId = (int)aBtn.tag-10;
}

#pragma mark 返回
- (void)dismissSelf
{
    [self dismissFlower];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark 发布
- (void)TouchPublish
{
    if ([self isTextNotNil:titleLabel.text]&&[self isTextNotNil:priceTextField.text]&&[self isTextNotNil:dayLabel.text]&&[self isTextNotNil:contentTextView.text]&&[self isTextNotNil:catNameLabel.text]&&[self isTextNotNil:nameTextField.text]&&[self isTextNotNil:phoneTextField.text])
    {
        [self showFlower];
        [self.netManage publishSupplyWithItemid:0 title:titleLabel.text price:priceTextField.text catid:catidString typeid:[NSString stringWithFormat:@"%d", typeId] today:dayLabel.text content:contentTextView.text truename:nameTextField.text mobile:phoneTextField.text andSuccBlock:^(NSDictionary *aDict) {
            [self dismissFlower];
            int itemid = [[aDict objectForKey:@"itemid"] intValue];
//            [SVProgressHUD showWithStatus:@"正在上传图片" cover:YES offsetY:kMainScreenHeight/2.0];
            NSString *uploadPhototUrl = nil;
            kYHBRequestUrl(@"upload.php", uploadPhototUrl);
            
            if (variousImageView.myPhotoArray.count>1)
            {
                for (int i=0; i<variousImageView.myPhotoArray.count-1; i++)
                {
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[YHBUser sharedYHBUser].token,@"token",[NSString stringWithFormat:@"%d", i],@"order",@"album",@"action",[NSString stringWithFormat:@"%d",itemid],@"itemid",[aDict objectForKey:@"moduleid"],@"moduleid", nil];
                    [NetManager uploadImg:[variousImageView.myPhotoArray objectAtIndex:i] parameters:dic uploadUrl:uploadPhototUrl uploadimgName:@"album" parameEncoding:AFJSONParameterEncoding progressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                    } succ:^(NSDictionary *successDict) {
                        NSString *result = [successDict objectForKey:@"result"];
                        if ([result intValue] != 1)
                        {
                            MLOG(@"%@", [successDict objectForKey:@"error"]);
                        }
                        else
                        {
                        
                        }
                        if (i==variousImageView.myPhotoArray.count-2)
                        {
                            YHBSupplyDetailViewController *vc = [[YHBSupplyDetailViewController alloc] initWithItemId:itemid andIsMine:YES isModal:YES];
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                        
                    } failure:^(NSDictionary *failDict, NSError *error) {
                        
                    }];
                }
            }
            else
            {
                YHBSupplyDetailViewController *vc = [[YHBSupplyDetailViewController alloc] initWithItemId:itemid andIsMine:YES isModal:YES];
                [self.navigationController pushViewController:vc animated:YES];
            }
        } failBlock:^(NSString *aStr) {
            [self dismissFlower];
            [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
        }];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请核对输入信息" cover:YES offsetY:kMainScreenHeight/2.0];
    }
}

- (BOOL)isTextNotNil:(NSString *)aStr
{
    if (aStr.length==0 || aStr==nil || [aStr isEqualToString:@" "] || [aStr isEqualToString:@"请输入您要发布的名称"])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark 键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==priceTextField)
    {
        if ([self isPureFloat:priceTextField.text])
        {
            price = [textField.text floatValue];
            [textField resignFirstResponder];
        }
        else
        {
            price=0;
            [SVProgressHUD showErrorWithStatus:@"请输入正确价格" cover:YES offsetY:kMainScreenWidth/2.0];
        }
    }
    if (textField==nameTextField)
    {
        NSString *oldstr = nameTextField.text;
        NSString *newStr = [oldstr stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([newStr isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请输入姓名" cover:YES offsetY:kMainScreenWidth/2.0];
        }
        else
        {
            [nameTextField resignFirstResponder];
        }
    }
    
    if (textField==phoneTextField)
    {
        if ([self isPureInt:phoneTextField.text] && phoneTextField.text.length==11)
        {
            [textField resignFirstResponder];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"请输入正确号码" cover:YES offsetY:kMainScreenWidth/2.0];
        }
    }
    
    return YES;
}

//判断是否为float
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

//判断是否为int
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        content = textView.text;
        [textView resignFirstResponder];
        //        [self keyboardDidDisappear];
    }
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self keyboardWillAppear];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self keyboardWillAppear];
    return YES;
}

- (void)keyboardWillAppear
{
    [self pickerPickEnd:nil];
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

    if (![priceTextField isFirstResponder])
    {
        float offY = 0;
        MLOG(@"%f", kMainScreenHeight);
        if (kMainScreenHeight>500)
        {
            offY=kMainScreenHeight;
        }
        else
        {
            offY=330;
        }
        [UIView animateWithDuration:0.2 animations:^{
            scrollView.contentOffset = CGPointMake(0, offY);
        }];
        CGRect temFrame = scrollView.frame;
        temFrame.size.height = self.view.frame.size.height - keyboardRect.size.height;
        scrollView.frame = temFrame;
    }

}

- (void)handleKeyboardDidHidden
{
    [UIView animateWithDuration:0.2 animations:^{
        scrollView.frame = self.view.bounds;
        scrollView.contentOffset = CGPointMake(0, 0);
    }];
}

- (void)keyboardDidDisappear
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
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
