//
//  YHBFindPswViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/15.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBFindPswViewController.h"
#import "SVProgressHUD.h"
#import "YHBUser.h"
#import "YHBUserManager.h"

enum TextField_Type
{
    TextField_phoneNumber = 30,//账号文本框-登录
    TextField_checkCode,
    TextField_newPassword,
    TextField_rePassword,
};

@interface YHBFindPswViewController ()<UITextFieldDelegate>
{
    int _secondCountDown;
}
@property (strong, nonatomic) UIView *findPswView;
@property (strong, nonatomic) UITextField *phoneNumberTextField;
@property (strong, nonatomic) UITextField *checkCodeTextField;
@property (strong, nonatomic) UITextField *passwordTextFiled;
@property (strong, nonatomic) UITextField *rePasswordTextField;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIButton *checkCodeButton;
@property (nonatomic, strong) NSTimer *checkCodeTimer; //计时器

@end

@implementation YHBFindPswViewController
#pragma mark - getter and setter
- (UIView *)findPswView
{
    if (!_findPswView) {
        
        _findPswView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, kMainScreenWidth-20, 215)];
        _findPswView.backgroundColor = [UIColor whiteColor];
        _findPswView.layer.borderColor = [kLineColor CGColor];//[RGBCOLOR(207, 207, 207) CGColor];
        _findPswView.layer.borderWidth = 1.0f;
        _findPswView.layer.cornerRadius = 4.0;
        
        _phoneNumberTextField = [self customedTextFieldWithFrame:CGRectMake(5, 15, _findPswView.bounds.size.width-10, 35)  andPlaceholder:@"输入手机号" andTag:TextField_phoneNumber andReturnKeyType:UIReturnKeyNext];
        [_phoneNumberTextField setKeyboardType:UIKeyboardTypeNumberPad];
        [_findPswView addSubview:self.phoneNumberTextField];
        
        _checkCodeTextField = [self customedTextFieldWithFrame:CGRectMake(5, 15+_phoneNumberTextField.bottom, (_findPswView.bounds.size.width-10)*1.8/3.0f, 35) andPlaceholder:@"输入验证码" andTag:TextField_checkCode andReturnKeyType:UIReturnKeyNext];
        [_findPswView addSubview:self.checkCodeTextField];
        
        _passwordTextFiled = [self customedTextFieldWithFrame:CGRectMake(5, 15+_checkCodeTextField.bottom, _findPswView.bounds.size.width-10, 35) andPlaceholder:@"输入新密码" andTag:TextField_newPassword andReturnKeyType:UIReturnKeyNext];
        self.passwordTextFiled.secureTextEntry = YES;
        [_findPswView addSubview:self.passwordTextFiled];

        _rePasswordTextField = [self customedTextFieldWithFrame:CGRectMake(5, 15+_passwordTextFiled.bottom, _findPswView.bounds.size.width-10, 35) andPlaceholder:@"重新输入新密码" andTag:TextField_rePassword andReturnKeyType:UIReturnKeyGo];
        self.rePasswordTextField.secureTextEntry = YES;
        [_findPswView addSubview:self.rePasswordTextField];
        
        //验证码button
        UIButton *checkCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        checkCodeButton.frame = CGRectMake(_findPswView.bounds.size.width-10-95,_checkCodeTextField.top, 95, 35);
        checkCodeButton.titleLabel.font = kFont14;
        [checkCodeButton setBackgroundColor:RGBCOLOR(220, 220, 220)];
        [checkCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [checkCodeButton setTitleColor:RGBCOLOR(157, 157, 157) forState:UIControlStateNormal];
        [checkCodeButton addTarget:self action:@selector(getCheckCode) forControlEvents:UIControlEventTouchUpInside];
        checkCodeButton.layer.borderColor = [kLineColor CGColor];//[RGBCOLOR(198, 198, 198) CGColor];
        checkCodeButton.layer.borderWidth = 0.5f;
        checkCodeButton.layer.masksToBounds = YES;
        self.checkCodeButton = checkCodeButton;
        checkCodeButton.layer.cornerRadius = 5.0f;
        [_findPswView addSubview:checkCodeButton];
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.backgroundColor = KColor;
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setFrame:CGRectMake(20, _findPswView.bottom+45, kMainScreenWidth-40.0, 40)];
        loginButton.layer.cornerRadius = 5.0f;
        [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(touchLoginButton) forControlEvents:UIControlEventTouchUpInside];
        _loginButton = loginButton;
        [self.view addSubview:loginButton];
        
    }
    return _findPswView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    //ui
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(backItem)];
    
    self.view.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:self.findPswView];
    
}


#pragma mark - Action
- (void)getCheckCode
{
    
     if (self.phoneNumberTextField.text && self.phoneNumberTextField.text.length) {
     [SVProgressHUD showWithStatus:@"验证码发送中" cover:YES offsetY:kMainScreenHeight/2.0];
     [[YHBUserManager sharedManager] getCheckCodeWithPhone:self.phoneNumberTextField.text Success:^(){
         [SVProgressHUD dismissWithSuccess:@"验证码已发送到您的手机"];
         self.checkCodeButton.enabled = NO;
         _secondCountDown = 90;
         if (!self.checkCodeTimer) {
             self.checkCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeClicked) userInfo:nil repeats:YES];
         }
    } failure:^(int result, NSString *errorString) {
         [SVProgressHUD showErrorWithStatus:errorString cover:YES offsetY:kMainScreenHeight/2.0];
         //self.checkCode = nil;
     }];
     }else{
         [SVProgressHUD showErrorWithStatus:@"请输入手机号" cover:YES offsetY:kMainScreenHeight/2.0];
     }
    
}

- (void)touchLoginButton
{
    
    [self resignAllKeyBord];
    if (self.phoneNumberTextField.text.length && self.checkCodeTextField.text.length && self.passwordTextFiled.text.length && self.rePasswordTextField.text.length) {
        if ([self.passwordTextFiled.text isEqualToString:self.rePasswordTextField.text]) {
            [SVProgressHUD showWithStatus:@"登录中" cover:YES offsetY:kMainScreenHeight/2.0];
            [[YHBUserManager sharedManager] findPasswordWithPhone:self.phoneNumberTextField.text newPassword:self.passwordTextFiled.text checkcode:self.checkCodeTextField.text Success:^{
                [SVProgressHUD dismissWithSuccess:@"修改密码成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
            } failure:^(NSInteger result, NSString *resultString) {
                [SVProgressHUD dismissWithError:resultString];
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致，请重新输入" cover:YES offsetY:kMainScreenHeight/2.0];
        };
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入完整" cover:YES offsetY:kMainScreenHeight/2.0];
    }
    
}

- (void)backItem
{
    [self resignAllKeyBord];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 倒计时
- (void)timeClicked
{
    if (_secondCountDown > 0) {
        //self.checkCodeButton.titleLabel.text = [NSString stringWithFormat:@"%ds重发",_secondCountDown];
        [self.checkCodeButton setTitle:[NSString stringWithFormat:@"%ds后重发",_secondCountDown] forState:UIControlStateNormal];
        _secondCountDown--;
    }else{
        self.checkCodeButton.enabled = YES;
        [self.checkCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        if ([self.checkCodeTimer isValid]) {
            [self.checkCodeTimer invalidate];
            _checkCodeTimer = nil;
        }
    }
}

- (void)resignAllKeyBord
{
    if([self.phoneNumberTextField isFirstResponder]) [self.phoneNumberTextField resignFirstResponder];
    if([self.passwordTextFiled isFirstResponder]) [self.passwordTextFiled resignFirstResponder];
    if([self.rePasswordTextField isFirstResponder]) [self.rePasswordTextField resignFirstResponder];
    if([self.checkCodeTextField isFirstResponder]) [self.checkCodeTextField resignFirstResponder];
}

#pragma mark - delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = [KColor CGColor];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.layer.borderColor = [kLineColor CGColor];//[RGBCOLOR(207, 207, 204) CGColor];
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case TextField_phoneNumber:
            [self.checkCodeTextField becomeFirstResponder];
            break;
        case TextField_checkCode:
            [self.passwordTextFiled becomeFirstResponder];
            break;
        case TextField_newPassword:
            [self.rePasswordTextField becomeFirstResponder];
            break;
        case TextField_rePassword:
        {
            [textField resignFirstResponder];
            [self touchLoginButton];
        }
            break;
        default:
            break;
    }
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignAllKeyBord];
}

//定制的textField
- (UITextField *)customedTextFieldWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeholder andTag:(NSInteger)TextField_Type andReturnKeyType:(UIReturnKeyType)returnKeyType
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 4.0f;
    textField.layer.borderColor = [kLineColor CGColor];//[RGBCOLOR(207, 207, 207) CGColor];//[KColor CGColor];
    if (kSystemVersion < 7.0) {
        [textField setBorderStyle:UITextBorderStyleBezel];
    }
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.layer.borderWidth = 0.7f;
    textField.placeholder = placeholder;
    textField.delegate = self;
    textField.tag = TextField_Type;
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textField setReturnKeyType:returnKeyType];
    return textField;
}


@end
