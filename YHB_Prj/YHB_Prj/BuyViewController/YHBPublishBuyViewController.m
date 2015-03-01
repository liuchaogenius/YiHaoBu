//
//  YHBPublishSupplyViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBPublishBuyViewController.h"
#import "YHBVariousImageView.h"
#import "YHBBuyDetailViewController.h"
#import "TitleTagViewController.h"
#import "SVProgressHUD.h"
#import "YHBPublishBuyManage.h"
#import "CategoryViewController.h"
#import "YHBCatSubcate.h"
#import "YHBUser.h"
#import "NetManager.h"
#import "YHBVariousView.h"
#import "YHBBuyDetailAlbum.h"

#define kButtonTag_Yes 100
@interface YHBPublishBuyViewController()<UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
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
    
    YHBBuyDetailData *myModel;
    BOOL isClean;
    
    NSString *catidString;
    
    
    YHBVariousImageView *variousImageView;
    
    UILabel *titlePlaceHolder;
    UILabel *dayPlaceHolder;
    UILabel *catPlaceHolder;
    UILabel *detailPlaceHolder;
    
    YHBVariousView *variousView;
    
    BOOL webEdit;
}

@property(nonatomic, strong) UIPickerView *dayPickerView;
@property(nonatomic, strong) UIView *toolView;
@property(nonatomic, strong) YHBPublishBuyManage *netManage;
@end

@implementation YHBPublishBuyViewController

- (instancetype)initWithModel:(YHBBuyDetailData *)aModel
{
    if (self = [super init]) {
        myModel = aModel;
        webEdit = YES;
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
    
    isClean = NO;
    self.title = @"发布采购";
    self.view.backgroundColor = RGBCOLOR(241, 241, 241);
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    variousImageView = [[YHBVariousImageView alloc] initEditWithFrame:CGRectMake(0, 0, kMainScreenWidth, 120)];
    [scrollView addSubview:variousImageView];
    
#pragma mark 中间View
    float labelHeight = 20;//label高度
    float interval = 20;//label之间间隔
    float editViewHeight = 305;//中间view高度
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
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kMainScreenWidth, 15)];
    topLabel.font = kFont12;
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor lightGrayColor];
    topLabel.text = @"请上传清晰可辨的布料或成品照片";
    [editSupplyView addSubview:topLabel];
    
    UIView *aLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 35, kMainScreenWidth, 0.5)];
    aLineView.backgroundColor = [UIColor lightGrayColor];
    [editSupplyView addSubview:aLineView];
    
    NSArray *strArray = @[@"名       称 :",@"分       类 :",@"数       量 :",@"求购周期 :",@"面料详情 :"];
    for (int i=0; i<strArray.count; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 35+interval/2+(labelHeight+interval)*i, 70, labelHeight)];
        label.text = [strArray objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:15];
        //            [contentScrollView addSubview:label];
        [editSupplyView addSubview:label];
        
        if (i!=strArray.count-1)
        {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, label.bottom+10, kMainScreenWidth, 0.5)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [editSupplyView addSubview:lineView];
        }
    }
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 35+interval/2-5, kMainScreenWidth-85-10, labelHeight+10)];
//    titleLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    titleLabel.layer.borderWidth = 0.5;
    titleLabel.userInteractionEnabled = YES;
    titleLabel.font = kFont15;
//    titleLabel.textColor = [UIColor lightGrayColor];
    [editSupplyView addSubview:titleLabel];
    
    titlePlaceHolder = [[UILabel alloc] initWithFrame:titleLabel.frame];
    titlePlaceHolder.text = @"请选择或输入品名关键词";
    titlePlaceHolder.font = kFont15;
    titlePlaceHolder.textColor = [UIColor lightGrayColor];
    [editSupplyView addSubview:titlePlaceHolder];
    
    UIImageView *rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(titleLabel.right-titleLabel.left-12, 35+(labelHeight+10-15)/2, 9, 15)];
    [rightArrow setImage:[UIImage imageNamed:@"rightArrow"]];
    [titleLabel addSubview:rightArrow];
    
    tapTitleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTitle)];
    [titleLabel addGestureRecognizer:tapTitleGesture];

    priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 35+interval*2.5+labelHeight*2-5, kMainScreenWidth-60-85, labelHeight+10)];
    priceTextField.font = [UIFont systemFontOfSize:15];
//    priceTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    priceTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    priceTextField.returnKeyType = UIReturnKeyDone;
//    priceTextField.textColor = [UIColor lightGrayColor];
//    priceTextField.textAlignment = NSTextAlignmentCenter;
    priceTextField.placeholder = @"需求数量";
    [priceTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    priceTextField.delegate = self;
//    priceTextField.layer.borderWidth = 0.5;
    [editSupplyView addSubview:priceTextField];
    
//    UILabel *priceLabelNote = [[UILabel alloc] initWithFrame:CGRectMake(priceTextField.right+3, priceTextField.top, 120, labelHeight+10)];
//    priceLabelNote.font = [UIFont systemFontOfSize:15];
//    priceLabelNote.textColor = [UIColor lightGrayColor];
//    priceLabelNote.text = @"元/米";
//    [editSupplyView addSubview:priceLabelNote];
    
    variousView = [[YHBVariousView alloc] initWithFrame:CGRectMake(priceTextField.right, priceTextField.top+5, 50, labelHeight) andItemArray:@[@"米",@"本",@"码"] andSelectedItem:0];
    variousView.layer.borderColor = [KColor CGColor];
    variousView.layer.borderWidth=0.5;
    variousView.layer.cornerRadius = 10;
    variousView.clipsToBounds = YES;

    dayView = [[UIView alloc] initWithFrame:CGRectMake(85, 35+(interval+labelHeight)*3+interval/2-5, kMainScreenWidth-85-10, labelHeight+10)];
//    dayView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    dayView.layer.borderWidth = 0.5;
    dayView.userInteractionEnabled = YES;
    [editSupplyView addSubview:dayView];
    
    dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth-85-10-40, labelHeight+10)];
    dayLabel.font = kFont15;
//    dayLabel.textAlignment = NSTextAlignmentCenter;
//    dayLabel.textColor = [UIColor lightGrayColor];
    dayLabel.userInteractionEnabled = YES;
    [dayView addSubview:dayLabel];
    
    dayPlaceHolder = [[UILabel alloc] initWithFrame:dayLabel.frame];
    dayPlaceHolder.text = @"信息过期时间";
    dayPlaceHolder.font = kFont15;
    dayPlaceHolder.textColor = [UIColor lightGrayColor];
    [dayView addSubview:dayPlaceHolder];
    
    
    tapDayGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchDay)];
    [dayView addGestureRecognizer:tapDayGesture];

    UILabel *dayLabelNote = [[UILabel alloc] initWithFrame:CGRectMake(dayLabel.right, 0, 20, labelHeight+10)];
    dayLabelNote.font = [UIFont systemFontOfSize:15];
    dayLabelNote.textColor = [UIColor lightGrayColor];
    dayLabelNote.text = @"天";
    [dayView addSubview:dayLabelNote];
    
    UIImageView *downArrow = [[UIImageView alloc] initWithFrame:CGRectMake(dayView.right-dayView.left-12, (labelHeight+10-15)/2, 9, 15)];
    [downArrow setImage:[UIImage imageNamed:@"rightArrow"]];
    [dayView addSubview:downArrow];
    
    [editSupplyView addSubview:variousView];


    catNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 35+(interval+labelHeight)*1+interval/2-5, kMainScreenWidth-85-10, labelHeight+10)];
//    catNameLabel.layer.borderWidth = 0.5;
//    catNameLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    catNameLabel.font = kFont15;
    catNameLabel.userInteractionEnabled = YES;
    [editSupplyView addSubview:catNameLabel];
    
    catPlaceHolder = [[UILabel alloc] initWithFrame:catNameLabel.frame];
    catPlaceHolder.text = @"请选择产品分类";
    catPlaceHolder.font = kFont15;
    catPlaceHolder.textColor = [UIColor lightGrayColor];
    [editSupplyView addSubview:catPlaceHolder];
    
//    UIImageView *plusImgView = [[UIImageView alloc] initWithFrame:CGRectMake(catNameLabel.right, catNameLabel.top, 23, 30)];
//    plusImgView.image = [UIImage imageNamed:@"plusImg"];
//    plusImgView.userInteractionEnabled = YES;
//    [editSupplyView addSubview:plusImgView];
    
    UITapGestureRecognizer *tapGestureReco = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCat)];
//    [plusImgView addGestureRecognizer:tapGestureReco];
    [catNameLabel addGestureRecognizer:tapGestureReco];

    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 35+interval/2+(interval+labelHeight)*4+labelHeight+3, kMainScreenWidth-20, 70)];
//    contentTextView.layer.borderWidth = 0.5;
//    contentTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    contentTextView.font = [UIFont systemFontOfSize:15];
    contentTextView.returnKeyType = UIReturnKeyDone;
    contentTextView.delegate = self;
    contentTextView.backgroundColor = [UIColor clearColor];
    [editSupplyView addSubview:contentTextView];
    
    detailPlaceHolder = [[UILabel alloc] initWithFrame:contentTextView.frame];
    detailPlaceHolder.text = @"请输入您要买的产品的织法、成分、颜色、厚薄、弹力、手感、宽幅、克重、用途等，尽可能填写您所知道的全部信息。";
    detailPlaceHolder.numberOfLines = 0;
    detailPlaceHolder.font = kFont15;
    detailPlaceHolder.textColor = [UIColor lightGrayColor];
    [editSupplyView addSubview:detailPlaceHolder];
    
    if (myModel)
    {
        titleLabel.text = myModel.title;
        catNameLabel.text = myModel.catname;
        contentTextView.text = myModel.introduce;
        dayLabel.text = myModel.today;
        catidString=nil;
        catidString=myModel.catid;
        
        if (myModel.amount>0)
        {
            priceTextField.text = myModel.amount;
        }

        if (myModel.album.count>0)
        {
            [variousImageView setMyWebPhotoArray:myModel.album canEdit:YES];
            
        }
        else
        {
            //            [variousImageView changeEdit];
            variousImageView.webEdit = YES;
            variousImageView.currentPhotoCount = 0;
            [variousImageView.webPhotoArray addObject:[UIImage imageNamed:@"QSPlusBtn"]];
        }

        
        dayPlaceHolder.hidden = YES;
        titlePlaceHolder.hidden = YES;
        catPlaceHolder.hidden = YES;
        detailPlaceHolder.hidden = YES;
    }
    
#pragma mark 下面View
    UIView *contactView = [[UIView alloc] initWithFrame:CGRectMake(0, editSupplyView.bottom+10, kMainScreenWidth, 90)];
    [scrollView addSubview:contactView];
    contactView.backgroundColor = [UIColor whiteColor];
    
    UILabel *personNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 75, 20)];
    personNameLabel.font = kFont15;
    personNameLabel.text = @"联 系 人 : ";
    
    UIView *alineView = [[UIView alloc] initWithFrame:CGRectMake(0, personNameLabel.bottom+10, kMainScreenWidth, 0.5)];
    alineView.backgroundColor = [UIColor lightGrayColor];
    [contactView addSubview:alineView];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(personNameLabel.left, personNameLabel.bottom+20, 75, 20)];
    phoneLabel.font = kFont15;
    phoneLabel.text = @"联系电话 : ";
    
    YHBUser *user = [YHBUser sharedYHBUser];

    
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, personNameLabel.top-5, kMainScreenWidth-85-10, labelHeight+10)];
    nameTextField.font = kFont15;
    nameTextField.delegate = self;
//    nameTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    nameTextField.layer.borderWidth = 0.5;
    nameTextField.returnKeyType = UIReturnKeyDone;
    nameTextField.text = user.userInfo.truename;
    
    phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, phoneLabel.top-5, kMainScreenWidth-85-10, labelHeight+10)];
    phoneTextField.font = kFont15;
    phoneTextField.delegate = self;
    phoneTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    phoneTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    phoneTextField.layer.borderWidth = 0.5;
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
    
    if (publishBtn.bottom+10>kMainScreenHeight-62+1)
    {
        scrollView.contentSize = CGSizeMake(kMainScreenWidth, publishBtn.bottom+10);
    }
    else
    {
        scrollView.contentSize = CGSizeMake(kMainScreenWidth, kMainScreenHeight-62+1);
    }
}

#pragma mark getter
- (YHBPublishBuyManage *)netManage
{
    if (!_netManage) {
        _netManage = [[YHBPublishBuyManage alloc] init];
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
    return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d", (int)row+1];
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
        dayPlaceHolder.hidden = YES;
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
    }    vc.isPushed = YES;
    [vc setBlock:^(NSArray *aArray) {
        if (aArray.count>0)
        {
            catPlaceHolder.hidden = YES;
            NSString *str = @"";
            catidString = @"";
            for (YHBCatSubcate *subModel in aArray) {
                str = [str stringByAppendingString:[NSString stringWithFormat:@" %@", subModel.catname]];
                catidString = [catidString stringByAppendingString:[NSString stringWithFormat:@",%d", (int)subModel.catid]];
            }
            catidString = [catidString substringFromIndex:1];
            catNameLabel.text = str;
        }
        else
        {
            catNameLabel.text = @"";
            catPlaceHolder.hidden = NO;
        }
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
            titlePlaceHolder.hidden = YES;
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
    [[CategoryViewController sharedInstancetype] cleanAll];
    [self dismissFlower];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark 发布
- (void)TouchPublish
{
    if ([self isTextNotNil:titleLabel.text]&&[self isTextNotNil:dayLabel.text]&&[self isTextNotNil:contentTextView.text]&&[self isTextNotNil:catNameLabel.text]&&[self isTextNotNil:nameTextField.text]&&[self isTextNotNil:phoneTextField.text]&&variousImageView.currentPhotoCount>0)//&&[self isTextNotNil:priceTextField.text])
    {
        [self showFlower];
        int publishItemid = myModel?myModel.itemid:0;
        NSMutableArray *photoArray = variousImageView.myPhotoArray;
        NSMutableArray *havePhotoArray = [NSMutableArray new];
        if (webEdit)
        {
            photoArray = variousImageView.webPhotoArray;
            if (variousImageView.currentPhotoCount!=5)
            {
                [photoArray removeObjectAtIndex:0];
            }
            for (int i=0; i<photoArray.count; i++)
            {
                id obj = [photoArray objectAtIndex:i];
                if (![obj isKindOfClass:[UIImage class]])
                {
                    YHBBuyDetailAlbum *model = [photoArray objectAtIndex:i];
                    [havePhotoArray addObject:model.thumb];
                }
                else
                {
                    break;
                }
            }
        }
        else
        {
            photoArray = variousImageView.myPhotoArray;
            if (variousImageView.currentPhotoCount!=5)
            {
                [photoArray removeObjectAtIndex:0];
            }
        }


        [self.netManage publishBuyWithItemid:publishItemid title:titleLabel.text catid:catidString today:dayLabel.text content:contentTextView.text truename:nameTextField.text mobile:phoneTextField.text unit:variousView.itemLabel.text photoArray:havePhotoArray amount:priceTextField.text andSuccBlock:^(NSDictionary *aDict) {
            [self dismissFlower];
            int itemid = [[aDict objectForKey:@"itemid"] intValue];
            YHBBuyDetailViewController *vc = [[YHBBuyDetailViewController alloc] initWithItemId:itemid itemDict:aDict uploadPhotoArray:photoArray isWebArray:webEdit];
            [[CategoryViewController sharedInstancetype] cleanAll];
            [self.navigationController pushViewController:vc animated:YES];
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

#pragma mark 菊花
- (void)showFlower
{
    [SVProgressHUD show:YES offsetY:kMainScreenHeight/2.0];
}

- (void)dismissFlower
{
    [SVProgressHUD dismiss];
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
            [self keyboardDidDisappear];
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
            [self keyboardDidDisappear];
        }
    }
    
    if (textField==phoneTextField)
    {
        if ([self isPureInt:phoneTextField.text] && phoneTextField.text.length==11)
        {
            [textField resignFirstResponder];
            [self keyboardDidDisappear];
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
        if (kMainScreenHeight>500)
        {
            offY=kMainScreenHeight;
        }
        else
        {
            offY=300;
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

- (void)dealloc
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
