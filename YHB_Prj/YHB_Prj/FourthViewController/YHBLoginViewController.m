//
//  YHBLoginViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/13.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBLoginViewController.h"
#import "YHBUserManager.h"
#import "YHBFindPswViewController.h"
#import "YHBUser.h"
#import "SVProgressHUD.h"
#define sgmButtonHeight 40

enum SegmentBtn_Type
{
    SegmentBtn_login = 100, //登陆
    SegmentBtn_register     //注册
};

enum TextField_Type
{
    TextField_phoneNumber = 130,//账号文本框-登录
    TextField_password, //密码框-登录
    TextField_rgPhoneNumber,
    TextField_rgPassword,
    TextField_checkCode
};

@interface YHBLoginViewController ()<UITextFieldDelegate>
{
    int _secondCountDown;
}


@property (nonatomic,strong) UIButton *sgmLoginButton; //登陆选项按钮
@property (nonatomic,strong) UIButton *sgmRegisterButton; //注册选项按钮
@property (nonatomic,strong) UIView *loginView;//注册界面
@property (nonatomic,strong) UIView *registerView;//注册界面
@property (nonatomic,strong) UIView *selectedLine;//选择表示线
//登录界面
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
//注册界面
@property (nonatomic, strong) UITextField *rgPhoneNumberTextField;
@property (nonatomic, strong) UITextField *rgPasswordTextField;
@property (nonatomic, strong) UITextField *checkCodeTextField;

@property (nonatomic, weak) UIButton *LoginButton;//登陆按钮
@property (nonatomic, weak) UIButton *forgetPasswordBtn;//忘记密码按钮
@property (nonatomic, weak) UIButton *registerButton;//注册按钮
@property (nonatomic, weak) UIButton *checkCodeButton;//验证码按钮
@property (nonatomic, strong) NSString *checkCode;//验证码
@property (nonatomic, strong) NSTimer *checkCodeTimer; //计时器

@property (strong, nonatomic) UIView *forgetPswView; //忘记密码view
@end

@implementation YHBLoginViewController
@synthesize type;
#pragma mark - getter and setter
- (UIButton *)sgmLoginButton
{
    if (!_sgmLoginButton) {
        _sgmLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sgmLoginButton setFrame:CGRectMake(0, 0, kMainScreenWidth/2.0f, sgmButtonHeight)];
        [_sgmLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sgmLoginButton setTitleColor:KColor forState:UIControlStateSelected];
        [_sgmLoginButton setTitle:@"账号登陆" forState:UIControlStateNormal];
        _sgmLoginButton.tag = SegmentBtn_login;
        _sgmLoginButton.layer.borderWidth = 0.7f;
        _sgmLoginButton.layer.borderColor = [kLineColor CGColor];//[RGBCOLOR(207, 207, 207) CGColor];
        _sgmLoginButton.selected = NO;
        [_sgmLoginButton addTarget:self action:@selector(touchSgmBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sgmLoginButton;
}

- (UIButton *)sgmRegisterButton
{
    if (!_sgmRegisterButton) {
        _sgmRegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sgmRegisterButton setFrame:CGRectMake(kMainScreenWidth/2.0f, 0, kMainScreenWidth/2.0f, sgmButtonHeight)];
        [_sgmRegisterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sgmRegisterButton setTitleColor:KColor forState:UIControlStateSelected];
        [_sgmRegisterButton setTitle:@"注册" forState:UIControlStateNormal];
        _sgmRegisterButton.tag = SegmentBtn_register;
        _sgmRegisterButton.layer.borderWidth = 0.7f;
        _sgmRegisterButton.layer.borderColor = [kLineColor CGColor];//[RGBCOLOR(207, 207, 207) CGColor];
        _sgmRegisterButton.selected = NO;
        [_sgmRegisterButton addTarget:self action:@selector(touchSgmBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sgmRegisterButton;
}

- (UIView *)selectedLine
{
    if (!_selectedLine) {
        _selectedLine = [[UIView alloc] initWithFrame:CGRectMake(0, sgmButtonHeight-2, kMainScreenWidth/2.0, 2)];
        _selectedLine.backgroundColor = KColor;
    }
    return _selectedLine;
}

- (UIView *)loginView
{
    if (!_loginView) {
        _loginView = [[UIView alloc] initWithFrame:CGRectMake(0, sgmButtonHeight, kMainScreenWidth, kMainScreenHeight-sgmButtonHeight-64)];
        _loginView.backgroundColor = RGBCOLOR(249, 249, 249);
        
        UIView *whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(2, 20, kMainScreenWidth-4, 105)];
        whiteBackView.backgroundColor = [UIColor whiteColor];
        whiteBackView.layer.borderColor = [kLineColor CGColor];//[RGBCOLOR(207, 207, 207) CGColor];
        whiteBackView.layer.borderWidth = 1.0f;
        whiteBackView.layer.cornerRadius = 4.0;
        [_loginView addSubview:whiteBackView];
        
        self.phoneNumberTextField = [self customedTextFieldWithFrame:CGRectMake(10, 10, whiteBackView.bounds.size.width-20, 35) andPlaceholder:@"用户名/邮箱/手机号" andTag:TextField_phoneNumber andReturnKeyType:(UIReturnKeyNext)];
        [whiteBackView addSubview:self.phoneNumberTextField];
        
        self.passwordTextField = [self customedTextFieldWithFrame:CGRectMake(10, 60, whiteBackView.bounds.size.width-20, 35) andPlaceholder:@"密码" andTag:TextField_password andReturnKeyType:UIReturnKeyGo];
        self.passwordTextField.secureTextEntry = YES;
        [whiteBackView addSubview:self.passwordTextField];
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.backgroundColor = KColor;
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setFrame:CGRectMake(20, 125+45, kMainScreenWidth-40.0, 40)];
        loginButton.layer.cornerRadius = 5.0f;
        [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(touchLoginButton) forControlEvents:UIControlEventTouchUpInside];
        _LoginButton = loginButton;
        [_loginView addSubview:loginButton];
        
        _forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPasswordBtn addTarget:self action:@selector(touchForgetPswBtn) forControlEvents:UIControlEventTouchUpInside];
        [_forgetPasswordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_forgetPasswordBtn setFrame:CGRectMake(kMainScreenWidth - 20-50, 125+85+20, 50, 20)];
        _forgetPasswordBtn.titleLabel.font = kFont12;
        [_loginView addSubview:_forgetPasswordBtn];
        [self.view addSubview:_loginView];
    }
    return _loginView;
}

- (UIView *)registerView
{
    if (!_registerView) {
        _registerView = [[UIView alloc] initWithFrame:CGRectMake(0, sgmButtonHeight, kMainScreenWidth, kMainScreenHeight-sgmButtonHeight-64)];
        _registerView.backgroundColor = RGBCOLOR(249, 249, 249);
        
        UIView *whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(2, 20, kMainScreenWidth-4, 165)];
        whiteBackView.backgroundColor = [UIColor whiteColor];
        whiteBackView.layer.borderColor = [kLineColor CGColor];//[RGBCOLOR(207, 207, 207) CGColor];
        whiteBackView.layer.borderWidth = 1.0f;
        whiteBackView.layer.cornerRadius = 4.0;
        [_registerView addSubview:whiteBackView];
        
        _rgPhoneNumberTextField = [self customedTextFieldWithFrame:CGRectMake(10, 15, whiteBackView.bounds.size.width-20, 35)  andPlaceholder:@"输入手机号" andTag:TextField_rgPhoneNumber andReturnKeyType:UIReturnKeyNext];
        [_rgPhoneNumberTextField setKeyboardType:UIKeyboardTypeNumberPad];
        [whiteBackView addSubview:self.rgPhoneNumberTextField];
        
        _checkCodeTextField = [self customedTextFieldWithFrame:CGRectMake(10, 65, (whiteBackView.bounds.size.width-20)*1.9/3.0f, 35) andPlaceholder:@"输入验证码" andTag:TextField_checkCode andReturnKeyType:UIReturnKeyNext];
        [whiteBackView addSubview:self.checkCodeTextField];
        
        _rgPasswordTextField = [self customedTextFieldWithFrame:CGRectMake(10, 115, whiteBackView.bounds.size.width-20, 35) andPlaceholder:@"输入密码" andTag:TextField_checkCode andReturnKeyType:UIReturnKeyGo];
        self.rgPasswordTextField.secureTextEntry = YES;
        [whiteBackView addSubview:self.rgPasswordTextField];
        [self.view addSubview:_registerView];
        
        //验证码button
        UIButton *checkCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        checkCodeButton.frame = CGRectMake(whiteBackView.bounds.size.width-10-_checkCodeTextField.width/2.0, 65, _checkCodeTextField.width/2.0, 35);
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
        [whiteBackView addSubview:checkCodeButton];
        
        UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        registerButton.backgroundColor = KColor;
        [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [registerButton setFrame:CGRectMake(20, 165+45, kMainScreenWidth-40.0, 40)];
        registerButton.layer.cornerRadius = 5.0f;
        [registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [registerButton addTarget:self action:@selector(touchRegisterButton) forControlEvents:UIControlEventTouchUpInside];
        _LoginButton = registerButton;
        [_registerView addSubview:registerButton];
        
    }
    return _registerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sgmLoginButton];
    [self.view addSubview:self.sgmRegisterButton];
    self.sgmLoginButton.selected = YES;
    self.title = @"登陆";
    
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.selectedLine];
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(backItem)];
}

- (void)backItem
{
    [self resignAllKeybord];
    self.type = eLoginBack;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)touchSgmBtn:(UIButton *)sender
{
    if (!sender.selected) {
        sender.selected = YES;
        switch (sender.tag) {
            case SegmentBtn_login:
            {
                self.sgmRegisterButton.selected = NO;
                [UIView animateWithDuration:0.5f animations:^{
                    self.selectedLine.centerX -= kMainScreenWidth/2.0f;
                }];
                [UIView transitionFromView:self.registerView toView:self.loginView duration:0.7f options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
            }
                break;
            case SegmentBtn_register:
            {
                self.sgmLoginButton.selected = NO;
                [UIView animateWithDuration:0.5f animations:^{
                    self.selectedLine.centerX += kMainScreenWidth/2.0f;
                }];
                [UIView transitionFromView:self.loginView toView:self.registerView duration:0.7f options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
            }
                break;
            default:
                break;
        }
    }
    
}

- (void)clearText
{
    _phoneNumberTextField.text = @"";
    _passwordTextField.text = @"";
    _rgPasswordTextField.text = @"";
    _rgPhoneNumberTextField.text = @"";
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignAllKeybord];
}

#pragma mark 点击登陆按钮
- (void)touchLoginButton
{
    [self resignAllKeybord];
    __weak YHBLoginViewController *weakself = self;
    if (self.phoneNumberTextField.text.length && self.passwordTextField.text.length) {
        [SVProgressHUD showWithStatus:@"登录中" cover:YES offsetY:kMainScreenHeight/2.0];
        [[YHBUserManager sharedManager] loginWithPhone:self.phoneNumberTextField.text andPassWord:self.passwordTextField.text withSuccess:^{
            [SVProgressHUD dismissWithSuccess:@"登陆成功！"];
            weakself.type = eLoginSucc;
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessMessae object:nil];
        } failure:^(int result, NSString *errorStr) {
            [SVProgressHUD dismissWithError:errorStr];
            //self.type = eLoginFail;
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailMessage object:nil];
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入完整" cover:YES offsetY:kMainScreenHeight/2.0];
    }
}

#pragma mark 点击获取验证码按钮
- (void)getCheckCode
{
    
    if (self.rgPhoneNumberTextField.text && self.rgPhoneNumberTextField.text.length) {
        [SVProgressHUD showWithStatus:@"验证码发送中" cover:YES offsetY:kMainScreenHeight/2.0];
        [[YHBUserManager sharedManager] getCheckCodeWithPhone:self.rgPhoneNumberTextField.text smstpl:@"register" Success:^(){
            [SVProgressHUD dismissWithSuccess:@"验证码已发送到您的手机"];
            self.checkCodeButton.enabled = NO;
            _secondCountDown = ksecond;
            if (!self.checkCodeTimer) {
                self.checkCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeClicked) userInfo:nil repeats:YES];
            }
        } failure:^(int result, NSString *errorString) {
            [SVProgressHUD showErrorWithStatus:errorString cover:YES offsetY:kMainScreenHeight/2.0];
            self.checkCode = nil;
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入手机号" cover:YES offsetY:kMainScreenHeight/2.0];
    }
    
}

#pragma mark 点击注册按钮
- (void)touchRegisterButton
{
    
    [self resignAllKeybord];
    if (self.rgPasswordTextField.text.length && self.rgPhoneNumberTextField.text.length && self.checkCodeTextField.text.length) {
        [SVProgressHUD showWithStatus:@"信息提交中" cover:YES offsetY:kMainScreenHeight/2.0];
        [[YHBUserManager sharedManager] registerWithPhone:self.rgPhoneNumberTextField.text checkCode:self.checkCodeTextField.text passWord:self.rgPasswordTextField.text withSuccess:^{
            [SVProgressHUD dismissWithSuccess:@"注册成功!"];
            self.type = eLoginSucc;
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessMessae object:nil];
        } failure:^(int result, NSString *errorString) {
            [SVProgressHUD dismissWithError:errorString];
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入完整" cover:YES offsetY:kMainScreenHeight/2.0];
    }
    
}

#pragma mark touch忘记密码按钮
- (void)touchForgetPswBtn
{
    YHBFindPswViewController *findVC = [[YHBFindPswViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:findVC];
    [self presentViewController:nav animated:YES completion:nil];
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

#pragma mark - textField delegate
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
    [textField resignFirstResponder];
    
    switch (textField.tag) {
        case TextField_phoneNumber:
        {
            [self.passwordTextField becomeFirstResponder];
        }
            break;
        case TextField_password:
        {
            [self touchLoginButton]; //登陆
        }
            break;
        default:
            break;
    }
    return YES;
}


- (void)resignAllKeybord
{
    if (_loginView) {
        if ([self.phoneNumberTextField isFirstResponder]) {
            [self.phoneNumberTextField resignFirstResponder];
        }
        if ([self.passwordTextField isFirstResponder]) {
            [self.passwordTextField resignFirstResponder];
        }
    }
    if (_registerView) {
        if ([self.rgPhoneNumberTextField isFirstResponder]) {
            [self.rgPhoneNumberTextField resignFirstResponder];
        }
        if ([self.rgPasswordTextField isFirstResponder]) {
            [self.rgPasswordTextField resignFirstResponder];
        }
        if ([self.checkCodeTextField isFirstResponder]) {
            [self.checkCodeTextField resignFirstResponder];
        }
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
