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
#import "YHBUser.h"
#import "YHBUserInfo.h"
#import "SVProgressHUD.h"
#import "YHBMySupplyViewController.h"
#import "YHBOrderListViewController.h"
#import "LookQuoteViewController.h"
#import "YHBAdressListViewController.h"
#import "UIImageView+WebCache.h"
#import "YHBMyPrivateViewController.h"
#import "YHBCertificListViewController.h"
#import "YHBProductListViewController.h"
#import "YHBStoreViewController.h"
#import "UMSocial.h"
#import "IntroduceViewController.h"
#import "UMSocialWechatHandler.h"

#define kBtnsViewHeight 65
#define kBtnImageWidth 25
#define kBtnLabelFont 12
#define kBtnsTagStart 40
enum Button_Type
{
    Button_purchase = kBtnsTagStart,//我的采购
    Button_supply,//我的供应
    Button_product,//我的产品
    Button_lookStore//浏览商店
};
@interface FourthViewController ()<userCellsDelegate,UserHeadDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) UIBarButtonItem *loginItem;
@property (strong, nonatomic) YHBUserHeadView *userHeadView;
@property (strong, nonatomic) UIView *buttonsView;
@property (strong, nonatomic) UIScrollView *scollView;
@property (strong, nonatomic) YHBUserCellsView *userCellsView;
@property (strong, nonatomic) NSArray *dataArray;
@property (assign, nonatomic) CGFloat cellViewHeight;

@end

@implementation FourthViewController

#pragma mark - getter and setter
- (CGFloat)cellViewHeight
{
    if (_cellViewHeight < 0) {
        _cellViewHeight = 0.0;
        int i;
        for (i = 0; i < self.dataArray.count; i++) {
            NSArray *array = self.dataArray[i];
            _cellViewHeight += array.count * (KcellHeight+1.5);
            _cellViewHeight += kBlankHeight;
        }
    }
    return _cellViewHeight;
}

- (NSArray *)dataArray
{
    if(!_dataArray){
        _dataArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserVCData" ofType:@"plist"]];
    }
    return _dataArray;
}

#pragma mark - life

- (void)viewWillAppear:(BOOL)animated
{
    if ([YHBUser sharedYHBUser].isLogin && [YHBUser sharedYHBUser].statusIsChanged) {
        [YHBUser sharedYHBUser].statusIsChanged = NO;
        [[YHBUser sharedYHBUser] refreshUserInfoWithSuccess:^{
            [self refreshUserHeadView];
        } failure:nil];
    }
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settitleLabel:@"我的"];
    
    _cellViewHeight = -1;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64-49)];
    scrollView.backgroundColor = RGBCOLOR(240, 240, 242);
    scrollView.contentSize = CGSizeMake(kMainScreenWidth, kMainScreenHeight);
    _scollView = scrollView;
    [self.view addSubview:scrollView];
    
    
    NSString *btnTitle = [YHBUser sharedYHBUser].isLogin ? @"注销" : @"注册";
    UIBarButtonItem *loginItem = [[UIBarButtonItem alloc] initWithTitle:btnTitle style:UIBarButtonItemStylePlain target:self action:@selector(touchLoginItem)];
    loginItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = loginItem;
    self.loginItem = loginItem;
    
    //UI
    [self creatHeadView];
    [self creatButtonsView];
    [self creatCellsView];
    
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserHeadView) name:kUserInfoGetMessage object:nil];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
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
    NSArray *titleArray = @[@"我的采购",@"我的供应",@"我的产品",@"我的商城"];
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button  = [self customButtonViewWithNum:i title:titleArray[i]];
        //button.backgroundColor = [UIColor blueColor];
        [buttonsView addSubview:button];
    }
    self.buttonsView = buttonsView;
    [self.scollView addSubview:self.buttonsView];
}

- (void)creatCellsView {
    _scollView.contentSize = CGSizeMake(kMainScreenWidth, self.buttonsView.bottom + 10 + self.cellViewHeight+20);
    self.userCellsView = [[YHBUserCellsView alloc] initWithFrame:CGRectMake(0, self.buttonsView.bottom+10, kMainScreenWidth, self.cellViewHeight) withData:self.dataArray];
    self.userCellsView.delegate = self;
    [self.scollView addSubview:self.userCellsView];
}

#pragma mark - Action
#pragma mark touchBtnsView
- (void)touchFuncButtons:(UIButton *)sender
{
    if ([self userLoginConfirm]) {
        switch (sender.tag) {
            case Button_purchase:{
                //跳入我的采购
                //            LookQuoteViewController *vc = [[LookQuoteViewController alloc] init];
                YHBMySupplyViewController *vc = [[YHBMySupplyViewController alloc] initWithIsSupply:NO];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case Button_supply:{
                //跳入我的供应
                YHBMySupplyViewController *vc = [[YHBMySupplyViewController alloc] initWithIsSupply:YES];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case Button_product:{
                if ((int)[YHBUser sharedYHBUser].userInfo.groupid == 7) {
                    YHBProductListViewController *vc = [[YHBProductListViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"您未开通商城功能" cover:YES offsetY:0];
                }
            }
                break;
            case Button_lookStore:{
                //跳入浏览商店
                if ((int)[YHBUser sharedYHBUser].userInfo.groupid >= 6) {
                    YHBStoreViewController *vc = [[YHBStoreViewController alloc] initWithShopID:(int)[YHBUser sharedYHBUser].userInfo.userid];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请加入VIP开通商城" cover:YES offsetY:0];
                }
                
            }
                break;
            default:
                break;
        }
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
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确定注销？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
    }
    
}

#pragma mark - delegate
#pragma mark  点击cell
- (void)touchCellWithTag:(NSInteger)tag
{
    switch (tag) {
        case Cell_shopInfo:
        {
            if ([self userLoginConfirm]) {
                YHBShopInfoViewController *shopInfoVC = [[YHBShopInfoViewController alloc] init];
                shopInfoVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:shopInfoVC animated:YES];
            }
        }
            break;
        case Cell_certification:
        {
            if ([self userLoginConfirm]) {
                YHBCertificListViewController *vc = [[YHBCertificListViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case Cell_myOrder:
        {
            if ([self userLoginConfirm]) {
                YHBOrderListViewController *vc = [[YHBOrderListViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case Cell_address:
        {
            if ([self userLoginConfirm]) {
                YHBAdressListViewController *vc = [[YHBAdressListViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case Cell_private:
        {
            if ([self userLoginConfirm]) {
                YHBMyPrivateViewController *vc = [[YHBMyPrivateViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
            break;
        case Cell_aboutUs:
        {
            IntroduceViewController *vc = [[IntroduceViewController alloc] init];
            [vc setUrl:[NSString stringWithFormat:@"%@file/apphtml/about.html",kYHBUrl] title:@"关于我们"];
            vc.isSysPush = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case Cell_clause:
        {
            IntroduceViewController *vc = [[IntroduceViewController alloc] init];
            [vc setUrl:[NSString stringWithFormat:@"%@file/apphtml/service.html",kYHBUrl] title:@"服务条款"];
            vc.isSysPush = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case Cell_tips:
        {
            IntroduceViewController *vc = [[IntroduceViewController alloc] init];
            [vc setUrl:[NSString stringWithFormat:@"%@file/apphtml/help.html",kYHBUrl] title:@"使用帮助"];
            vc.isSysPush = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case Cell_share:
        {
            
            [UMSocialWechatHandler setWXAppId:kShareWEIXINAPPID appSecret:kShareWEIXINAPPSECRET url:kWeChatOpenUrl];
            
            [UMSocialSnsService presentSnsIconSheetView:self appKey:kUMENG_APPKEY shareText:@"#【快布】#  全球首款专业装饰布在线交易平台上线啦！买布卖布，1键搞定！行业资讯，1手掌控！线上交易，方便快捷！猛戳了解：http://www.51kuaibu.com/app" shareImage:[UIImage imageNamed:@"ShareIcon"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,nil] delegate:nil];
        }
            break;
        case Cell_Myprice:
        {
            //我的报价
            if ([self userLoginConfirm])
            {
                LookQuoteViewController *vc = [[LookQuoteViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
            break;
        default:
            break;
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
    if ([YHBUser sharedYHBUser].isLogin ) {
        [self.loginItem setTitle:@"注销"];
        YHBUser *user = [YHBUser sharedYHBUser];
        //[self loadUserPhoto];
        [self.userHeadView refreshSelfHeadWithIsLogin:YES name:user.userInfo.truename avator:user.userInfo.avatar thumb:user.userInfo.thumb group:(NSInteger)user.userInfo.groupid company:user.userInfo.company money:user.userInfo.money lock:user.userInfo.locking credit:[NSString stringWithFormat:@"%d",(int)user.userInfo.credit]];
    }else{
        [self.loginItem setTitle:@"注册"];
        [self.userHeadView refreshSelfHeadWithIsLogin:NO name:nil avator:nil thumb:nil group:0 company:nil money:nil lock:nil credit:nil];
    }
}

- (BOOL)userLoginConfirm
{
    if ([YHBUser sharedYHBUser].isLogin) {
        return YES;
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginForUserMessage object:[NSNumber numberWithBool:NO]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessItem) name:kLoginSuccessMessae object:nil];
        return NO;
    }
}

#pragma mark - actionsheet - 注销
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[YHBUser sharedYHBUser] logoutUser];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutMessage object:nil];
        [self refreshUserHeadView];//刷新
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)customButtonViewWithNum:(int)number  title:(NSString *)title
{
    CGFloat width = kMainScreenWidth/4.0f;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((number)*width, 0, width, kBtnsViewHeight);
    button.tag = number + kBtnsTagStart;
    [button addTarget:self action:@selector(touchFuncButtons:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor whiteColor];
    //button.layer.borderColor = [kLineColor CGColor];
    //button.layer.borderWidth = 0.5f;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((button.width-kBtnImageWidth)/2.0f, 10, kBtnImageWidth, kBtnImageWidth)];
    //设置图片
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"MiButtons_%d",number]];
    [button addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kBtnsViewHeight-kBtnLabelFont-10, width,kBtnLabelFont)];
    label.font = [UIFont systemFontOfSize:kBtnLabelFont];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    [button addSubview:label];
    
    return button;
}

/*
- (void)loadUserPhoto
{
    YHBUser *user = [YHBUser sharedYHBUser];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:user.localBannerUrl]) {
        self.userHeadView.bannerImageView.image = [UIImage imageWithContentsOfFile:user.localBannerUrl];
        
    }else{
        [self.userHeadView.bannerImageView sd_setImageWithURL:[NSURL URLWithString:user.userInfo.thumb] placeholderImage:[UIImage imageNamed:@"userBannerDefault"]];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:user.localHeadUrl]) {
        self.userHeadView.userImageView.image = [UIImage imageWithContentsOfFile:user.localHeadUrl];
        
    }else{
        [self.userHeadView.userImageView sd_setImageWithURL:[NSURL URLWithString:user.userInfo.avatar] placeholderImage:[UIImage imageNamed:@"userDefault"]];
    }
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
