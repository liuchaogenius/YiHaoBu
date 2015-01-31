//
//  PushPriceViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "PushPriceViewController.h"
#import "PushPriceManage.h"
#import "SVProgressHUD.h"

@interface PushPriceViewController ()<UITextFieldDelegate>
{
    NSString *myUnit;
    UITextField *priceTextField;
    UITextField *remarkTextField;
    int typeId;
    int myItemId;
}
@property(nonatomic, strong) PushPriceManage *manage;
@end

@implementation PushPriceViewController

- (instancetype)initWithUnit:(NSString *)aUnit
{
    if (self = [super init]) {
        myUnit = aUnit;
    }
    return self;
}

- (instancetype)initWithItemId:(int)aItemId
{
    if (self = [super init]) {
        myItemId = aItemId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    typeId=0;
    self.title = @"报价";
    self.view.backgroundColor = [UIColor whiteColor];
    float interval = 25;//label之间间隔
    float labelHeight = 20;//label高度
    float labelWidth = 70;
    float endY = 0.0;
    
    NSArray *strArray = @[@"价       格 : ",@"货源状态 : ",@"备注信息 : "];
    for (int i=0; i<strArray.count; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 62+interval+(labelHeight+interval)*i, labelWidth, labelHeight)];
        label.text = [strArray objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:label];
        endY = label.bottom;
    }
    
    priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(10+labelWidth+5, 62+interval-5, 100, labelHeight+10)];
    priceTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    priceTextField.layer.borderWidth = 0.5;
    priceTextField.layer.cornerRadius = 2.5;
    priceTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    priceTextField.returnKeyType = UIReturnKeyDone;
    priceTextField.delegate = self;
    [self.view addSubview:priceTextField];
    
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceTextField.right+5, 62+interval, 50, labelHeight)];
    unitLabel.textColor = [UIColor lightGrayColor];
    unitLabel.font = kFont15;
    unitLabel.text = @"元/米";
    [self.view addSubview:unitLabel];
    
    NSArray *array = @[@"现货",@"预定"];
    for (int i=0; i<array.count; i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(priceTextField.left+(labelHeight+6+40)*i, 62+interval+(interval+labelHeight)*1, labelHeight+6, labelHeight+6)];
        [btn setImage:[UIImage imageNamed:@"btnNotChoose"] forState:UIControlStateNormal];
        btn.tag=10+i;
        [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if (i==0) {
            [btn setImage:[UIImage imageNamed:@"btnChoose"] forState:UIControlStateNormal];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btn.right+5, btn.top, 30, labelHeight+6)];
        label.text = [array objectAtIndex:i];
        label.font = kFont15;
        label.textColor = [UIColor lightGrayColor];
        [self.view addSubview:label];
    }
    
    remarkTextField = [[UITextField alloc]
                       initWithFrame:CGRectMake(priceTextField.left, 62+interval+(interval+labelHeight)*2-5, kMainScreenWidth-priceTextField.left-10, 40)];
    remarkTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    remarkTextField.layer.borderWidth = 0.5;
    remarkTextField.layer.cornerRadius = 2.5;
    remarkTextField.delegate = self;
    remarkTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:remarkTextField];

    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, endY+interval+20, kMainScreenWidth-20, 40)];
    confirmBtn.layer.cornerRadius = 2.5;
    confirmBtn.backgroundColor = KColor;
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [confirmBtn addTarget:self action:@selector(touchConfirm)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

- (PushPriceManage *)manage
{
    if (!_manage) {
        _manage = [[PushPriceManage alloc] init];
    }
    return _manage;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchBtn:(UIButton *)aBtn
{
    for (int i=0; i<2; i++)
    {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i+10];
        [btn setImage:[UIImage imageNamed:@"btnNotChoose"] forState:UIControlStateNormal];
    }
    [aBtn setImage:[UIImage imageNamed:@"btnChoose"] forState:UIControlStateNormal];
    typeId = (int)aBtn.tag-10;
}

- (void)touchConfirm
{
    if ([priceTextField.text floatValue])
    {
        [self showFlower];
        [self.manage pushPriceManageWithItemId:myItemId price:[priceTextField.text floatValue] content:remarkTextField.text typeid:typeId succBlock:^{
            [self dismissFlower];
            [SVProgressHUD showSuccessWithStatus:@"报价成功" cover:YES offsetY:kMainScreenWidth/2.0];
            [self.navigationController popViewControllerAnimated:YES];
        } andFailBlock:^(NSString *aStr){
            [self dismissFlower];
            [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenWidth/2.0];
        }];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"报价有误" cover:YES offsetY:kMainScreenHeight/2.0];
    }
    
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
