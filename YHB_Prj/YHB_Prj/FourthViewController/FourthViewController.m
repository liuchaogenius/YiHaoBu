//
//  FourthViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 14-11-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//  用户管理界面

#import "FourthViewController.h"
#import "YHBUserHeadView.h"
#import "YHBUserCellsView.h"
#import "YHBShopInfoViewController.h"
#import "YHBAboutUsViewController.h"
#import "YHBUser.h"
#import "YHBUserInfo.h"
#import "SVProgressHUD.h"
#define kHeadHeight 110
#define kBtnsViewHeight 65
#define kBtnImageWidth 25
#define kBtnLabelFont 12
#define kBtnsTagStart 40
enum Button_Type
{
    Button_purchase = kBtnsTagStart,//我的购买
    Button_supply,//我的供应
    Button_lookStore//浏览商店
};
@interface FourthViewController ()<userCellsDelegate,UserHeadDelegate>

@property (strong, nonatomic) UIBarButtonItem *loginItem;
@property (strong, nonatomic) YHBUserHeadView *userHeadView;
@property (strong, nonatomic) UIView *buttonsView;
@property (strong, nonatomic) UIScrollView *scollView;
@property (strong, nonatomic) YHBUserCellsView *userCellsView;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    scrollView.backgroundColor = RGBCOLOR(240, 240, 242);
    scrollView.contentSize = CGSizeMake(kMainScreenWidth, kMainScreenHeight);
    _scollView = scrollView;
    [self.view addSubview:scrollView];
    
    NSString *btnTitle = [YHBUser sharedYHBUser].isLogin ? @"注销" : @"登陆";
    UIBarButtonItem *loginItem = [[UIBarButtonItem alloc] initWithTitle:btnTitle style:UIBarButtonItemStylePlain target:self action:@selector(touchLoginItem)];
    loginItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = loginItem;
    self.loginItem = loginItem;
    
    //UI
    [self creatHeadView];
    [self creatButtonsView];
    [self creatCellsView];
}

#pragma mark - UI
- (void)creatHeadView {
    _userHeadView = [[YHBUserHeadView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kHeadHeight)];
    _userHeadView.delegate = self;
    [self refreshUserHeadView];
    [self.scollView addSubview:self.userHeadView];
}

- (void)creatButtonsView {
    UIView *buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.userHeadView.bottom, kMainScreenWidth, kBtnsViewHeight)];
    //buttonsView.backgroundColor = [UIColor blackColor];
    NSArray *titleArray = @[@"我的采购",@"我的供应",@"浏览商城"];
    for (int i = 0; i < 3; i++) {
        UIButton *button  = [self customButtonViewWithNum:i title:titleArray[i]];
        //button.backgroundColor = [UIColor blueColor];
        [buttonsView addSubview:button];
    }
    self.buttonsView = buttonsView;
    [self.scollView addSubview:self.buttonsView];
}

- (void)creatCellsView {
    self.userCellsView = [[YHBUserCellsView alloc] initWithFrame:CGRectMake(0, self.buttonsView.bottom+10, kMainScreenWidth, KcellHeight * 6)];
    self.userCellsView.delegate = self;
    [self.scollView addSubview:self.userCellsView];
}

#pragma mark - Action
#pragma mark touchBtnsView
- (void)touchFuncButtons:(UIButton *)sender
{
    MLOG(@"touchFuncButtons");
#warning 带登陆验证-cc
    switch (sender.tag) {
        case Button_purchase:{
            //跳入我的采购
        }
            break;
        case Button_supply:{
            //跳入我的供应
        }
            break;
        case Button_lookStore:{
            //跳入浏览商店
        }
            break;
        default:
            break;
    }
}

#pragma mark 登陆或注销
- (void)touchLoginItem
{
    if (![YHBUser sharedYHBUser].isLogin) {
        MLOG(@"登陆");
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginForUserMessage object:[NSNumber numberWithBool:NO]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessItem) name:kLoginSuccessMessae object:nil];
    }else{
        //注销
        [[YHBUser sharedYHBUser] logoutUser];
        [self refreshUserHeadView];//刷新
    }
    
}

#pragma mark - delegate
#pragma mark  点击cell
- (void)touchCellWithTag:(NSInteger)tag
{
    if ([YHBUser sharedYHBUser].isLogin) {
        switch (tag) {
            case Cell_shopInfo:
            {
                YHBShopInfoViewController *shopInfoVC = [[YHBShopInfoViewController alloc] init];
                shopInfoVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:shopInfoVC animated:YES];
            }
                break;
            case Cell_certification:
            {
                
            }
                break;
            case Cell_private:
            {
                
            }
                break;
            case Cell_aboutUs:
            {
                YHBAboutUsViewController *aboutVC = [[YHBAboutUsViewController alloc] init];
                aboutVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:aboutVC animated:YES];
            }
                break;
            case Cell_clause:
            {
                
            }
                break;
            case Cell_tips:
            {
                
            }
                break;
            default:
                break;
        }

    }else{
        [self touchLoginItem];
    }
}

#pragma mark 点击head中的登录按钮
- (void)touchHeadLoginBtn
{
    [self touchLoginItem];
}
#pragma mark 登录成功返回调用方法
- (void)loginSuccessItem
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSuccessMessae object:nil];
    //数据刷新
    [self refreshUserHeadView];
}

#pragma mark - 刷新headview
- (void)refreshUserHeadView
{
    if ([YHBUser sharedYHBUser].isLogin) {
        [self.loginItem setTitle:@"注销"];
        YHBUser *user = [YHBUser sharedYHBUser];
        [self.userHeadView refreshViewWithIslogin:YES vcompany:user.userInfo.vcompany sell:user.userInfo.selltotal buy:user.userInfo.buytotal name:user.userInfo.truename avator:user.userInfo.avatar];
    }else{
        [self.loginItem setTitle:@"登陆"];
        [self.userHeadView refreshViewWithIslogin:NO vcompany:0 sell:0 buy:0 name:nil avator:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)customButtonViewWithNum:(int)number  title:(NSString *)title
{
    CGFloat width = kMainScreenWidth/3.0f;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((number)*width, 0, width, kBtnsViewHeight);
    button.tag = number + kBtnsTagStart;
    [button addTarget:self action:@selector(touchFuncButtons:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderColor = [kLineColor CGColor];
    button.layer.borderWidth = 0.5f;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((button.width-kBtnImageWidth)/2.0f, 10, kBtnImageWidth, kBtnImageWidth)];
    //设置图片
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"MiButtons_%d",number]];
    [button addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kBtnsViewHeight-kBtnLabelFont-5, width,kBtnLabelFont)];
    label.font = [UIFont systemFontOfSize:kBtnLabelFont];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    [button addSubview:label];
    
    return button;
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
