//
//  FourthViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 14-11-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "FourthViewController.h"
#import "YHBUserHeadView.h"
#import "YHBUserCellsView.h"
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
@interface FourthViewController ()

@property (strong, nonatomic) UIBarButtonItem *loginItem;
@property (strong, nonatomic) YHBUserHeadView *userHeadView;
@property (strong, nonatomic) UIView *buttonsView;
@property (strong, nonatomic) UIScrollView *scollView;
@property (strong, nonatomic) YHBUserCellsView *userCellsView;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64)];
    scrollView.backgroundColor = RGBCOLOR(240, 240, 242);
    scrollView.contentSize = CGSizeMake(kMainScreenWidth, 600);
    _scollView = scrollView;
    [self.view addSubview:scrollView];
    
    UIBarButtonItem *loginItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(touchLoginItem)];
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
    [self.scollView addSubview:self.userCellsView];
}

#pragma mark - Action
#pragma mark touchBtnsView
- (void)touchFuncButtons:(UIButton *)sender
{
    MLOG(@"touchFuncButtons");
#warning 带登陆验证
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
    MLOG(@"登陆");
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginForUserMessage object:[NSNumber numberWithBool:NO]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessItem) name:kLoginSuccessMessae object:nil];
}

#pragma mark 登录成功返回调用方法
- (void)loginSuccessItem
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSuccessMessae object:nil];
    //数据刷新
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
