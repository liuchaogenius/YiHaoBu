//
//  YHBOrderDetailViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/19.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderDetailViewController.h"
#import "YHBOrderDetail.h"
#import "YHBOrderManager.h"
#import "SVProgressHUD.h"
#import "YHBOrderFirstSectionView.h"
#import "YHBUser.h"
#import "IntroduceViewController.h"
#import "YHBOrderSecondView.h"
#import "YHBOrderDetailInfoView.h"
#import "YHBPublicCommentVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YHBPaySuccessVC.h"
#import "GetUserNameManage.h"
#import "UserinfoBaseClass.h"
#import "ChatViewController.h"
#import "YHBOrderActionModel.h"

#define KAbtnWidth 70
#define kAbtnHeight 25
typedef enum : NSInteger {
    Com_phone = 0,//电话
    Com_message,//短信
    Com_chat,//在线
} Communicate_Type;

@interface YHBOrderDetailViewController ()<YHBOrderFSDelegate,YHBOrderSecondViewDelegate>
{
    NSString *_payMoneyInfo;
}
@property (assign, nonatomic) NSInteger itemID;
@property (strong, nonatomic) YHBOrderManager *orderManager;
@property (strong, nonatomic) YHBOrderDetail *orderModel;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) YHBOrderFirstSectionView *firstSection;
@property (strong, nonatomic) YHBOrderSecondView *secondSection;
@property (strong, nonatomic) YHBOrderDetailInfoView *infoView;
@property (strong, nonatomic) UIView *actionView;
@property (strong, nonatomic) GetUserNameManage *userManage;
@end

@implementation YHBOrderDetailViewController

#pragma mark - getter and setter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20-44)];
        _scrollView.backgroundColor = kViewBackgroundColor;
    }
    return _scrollView;
}

- (GetUserNameManage *)userManage
{
    if (!_userManage) {
        _userManage = [[GetUserNameManage alloc] init];
    }
    return _userManage;
}

-  (YHBOrderManager *)orderManager
{
    if (!_orderManager) {
        _orderManager = [YHBOrderManager sharedManager];
    }
    return _orderManager;
}

- (instancetype)initWithItemId:(NSInteger)itemID
{
    self = [super init];
    self.itemID = itemID;
    _isPopToRoot = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayresult:) name:kAlipayOrderResultMessage object:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(touchBack)];
    
    self.view.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:self.scrollView];
    self.firstSection = [[YHBOrderFirstSectionView alloc] init];
    self.firstSection.delegate = self;
    self.secondSection = [[YHBOrderSecondView alloc] init];
    self.secondSection.delegate = self;
    self.infoView = [[YHBOrderDetailInfoView alloc] init];
    
    [SVProgressHUD showWithStatus:@"拼命加载中..." cover:YES offsetY:0];
    __weak YHBOrderDetailViewController *weakself = self;
    [self.orderManager getOrderDetailWithToken:([YHBUser sharedYHBUser].token ? :@"") ItemID:self.itemID Success:^(YHBOrderDetail *model) {
        weakself.orderModel = model;
        [weakself reSetUI];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismissWithError:error];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

- (void)reSetUI
{
    [self.firstSection setUIWithBuyer:self.orderModel.buyerName address:self.orderModel.buyerAddress moble:self.orderModel.buyerMobile statusDes:self.orderModel.dstatus isNeedLogicView:(self.orderModel.sendUrl.length ? YES:NO) amount:self.orderModel.money fee:self.orderModel.fee];
    if (![self.firstSection superview]) {
        [self.scrollView addSubview:self.firstSection];
    }
    
    self.secondSection.top = self.firstSection.bottom + 15;
    [self.secondSection setUIWithSellCom:self.orderModel.sellcom Title:self.orderModel.title Price:self.orderModel.price Number:self.orderModel.number fee:self.orderModel.fee Money:self.orderModel.money thumb:self.orderModel.thumb];
    if (![self.secondSection superview]) {
        [self.scrollView addSubview:self.secondSection];
    }
    
    [self.infoView setUIWithTextArray:[self.orderModel getDetailTextArray]];
    self.infoView.top = self.secondSection.bottom;
    self.scrollView.contentSize = CGSizeMake(0, self.infoView.bottom+20);
    if (![self.infoView superview]) {
        [self.scrollView addSubview:self.infoView];
    }
    
    [self creatOrResetActonView];
    
}

- (void)creatOrResetActonView
{
    if (self.orderModel.naction.count) {
        if (!_actionView) {
            self.actionView = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight-20-44-40, kMainScreenWidth, 40)];
            self.actionView.layer.borderColor = [kLineColor CGColor];
            self.actionView.layer.borderWidth = 0.5;
            self.actionView.backgroundColor = [UIColor whiteColor];
        }
        [self.actionView removeSubviews];
#warning 下一步动作 have problem
        for (int i = 0; i < self.orderModel.naction.count; i++) {
            NSString *title = [YHBOrderActionModel getTitleOfNextStepForNactionStr:self.orderModel.naction[i]];//[self.orderModel getTitleOfNextStepForIndex:i];
            if (title && title.length && i < 2) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:title forState:UIControlStateNormal];
                CGFloat x = self.orderModel.naction.count == 1 ? (kMainScreenWidth-10-KAbtnWidth) : kMainScreenWidth-(!i + 1)*(KAbtnWidth+10);
                btn.frame = CGRectMake(x , _actionView.height/2.0-kAbtnHeight/2.0, KAbtnWidth, kAbtnHeight);
                [btn addTarget:self action:@selector(touchActionBtn:) forControlEvents:UIControlEventTouchUpInside];
                btn.layer.cornerRadius  =2.0;
                btn.titleLabel.font = kFont12;
                [btn setTitleColor:(!i%2 ? [UIColor blackColor] : [UIColor whiteColor] ) forState:UIControlStateNormal];
                [btn setBackgroundColor:(!i%2 ? RGBCOLOR(238, 238, 238) : KColor)];
                btn.tag = i;
                btn.layer.borderColor = [kLineColor CGColor];
                btn.layer.borderWidth = 0.5f;
                [self.actionView addSubview:btn];
            }
            
        }
        if (![self.actionView superview]) {
            [self.view addSubview:self.actionView];
            self.scrollView.height -= self.actionView.height;
        }
    }else if ([self.actionView superview]){
        self.scrollView.height += self.actionView.height;
        [self.actionView removeFromSuperview];
    }
}

#pragma mark - Action
#pragma mark 点击物流cell
- (void)touchLogicCell
{
    if (self.orderModel.sendUrl.length) {
        IntroduceViewController *vc = [[IntroduceViewController alloc] init];
        [vc setUrl:self.orderModel.sendUrl title:@"物流信息"];
        vc.isSysPush = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 点击功能按钮
- (void)touchActionBtn : (UIButton *)sender
{
    self.isPopToRoot = YES;
    if ([sender.titleLabel.text isEqualToString:@"评价"]) {
        YHBPublicCommentVC *vc = [[YHBPublicCommentVC alloc] initWithOrderDetailModel:self.orderModel];
        [vc setPublishSuccessHandler:^{
            __weak YHBOrderDetailViewController *weakself = self;
            [self.orderManager getOrderDetailWithToken:([YHBUser sharedYHBUser].token ? :@"") ItemID:self.itemID Success:^(YHBOrderDetail *model) {
                weakself.orderModel = model;
                [weakself reSetUI];
            }failure:^(NSString *error) {
            }];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"付款"]) {
        //支付
        [self.orderManager getPayInfoWithToken:[YHBUser sharedYHBUser].token ItemID:self.itemID Success:^(NSString *info, NSString *ordermoney, NSString *overmoney, NSString *realmoney) {
            _payMoneyInfo = [NSString stringWithFormat:@"订单总金额:%@ 余额支付:%@ 实际支付金额:%@",ordermoney,overmoney,realmoney];
            //MLOG(@"info:%@",info);
            if(!overmoney) overmoney = @"0";
            if ([overmoney integerValue] > 0) {
                [YHBUser sharedYHBUser].statusIsChanged = YES;
            }
            if ([realmoney isEqualToString:@"0.00"]) {
                //余额支付
                YHBPaySuccessVC *sVc = [[YHBPaySuccessVC alloc] initWithAppendInfo:_payMoneyInfo];
                [self.navigationController pushViewController:sVc animated:YES];
            }else if (info) {
                static NSString *strSchem = @"com.yibu.kuaibu";
                [[AlipaySDK defaultService] payOrder:info fromScheme:strSchem callback:^(NSDictionary *resultDic) {
                    MLOG(@"%@",resultDic);
                    [[NSNotificationCenter defaultCenter] postNotificationName:kAlipayOrderResultMessage object:resultDic];
                }];
            }
        } failure:^(NSString *error) {
            [SVProgressHUD showErrorWithStatus:error cover:YES offsetY:0];
        }];
    }else{
        NSString *action = self.orderModel.naction[sender.tag];
        [SVProgressHUD showWithStatus:@"操作中..." cover:YES offsetY:0];
        __weak YHBOrderDetailViewController *weakself = self;
        [self.orderManager changeOrderStatusWithToken:([YHBUser sharedYHBUser].token ? :@"") ItemID:(NSInteger)self.orderModel.itemid Action:action?:@"" Success:^{
            [SVProgressHUD showWithStatus:@"操作成功,正在重新加载订单信息.." cover:YES offsetY:0];
            [weakself.orderManager getOrderDetailWithToken:([YHBUser sharedYHBUser].token?:@"") ItemID:(NSInteger)weakself.orderModel.itemid Success:^(YHBOrderDetail *model) {
                weakself.orderModel = model;
                [weakself reSetUI];
                [SVProgressHUD dismissWithSuccess:@"操作成功!"];
            } failure:^(NSString *error) {
                [SVProgressHUD dismissWithError:error];
            }];
        } failure:^(NSString *error) {
            [SVProgressHUD dismissWithError:error];
        }];
    }
}

#pragma mark - 支付结果处理
- (void)aliPayresult:(NSNotification *)aNotification
{
    MLOG(@"resultDic :  %@",aNotification);
    
    NSDictionary *resultDic = [aNotification object];
    
    if(resultDic && resultDic.count)
    {
        MLOG(@"notificationDict = %@",resultDic);
        int resultStatus = [[resultDic objectForKey:@"resultStatus"] intValue];
        NSString *resultDesc = [resultDic objectForKey:@"result"];
        if(resultStatus == 9000)///支付成功
        {
            YHBPaySuccessVC *sVc = [[YHBPaySuccessVC alloc] initWithAppendInfo:_payMoneyInfo];
            [self.navigationController pushViewController:sVc animated:YES];
            
        }
        else if(resultStatus == 8000)///正在处理
        {
            YHBPaySuccessVC *sVc = [[YHBPaySuccessVC alloc] initWithAppendInfo:_payMoneyInfo];
            [self.navigationController pushViewController:sVc animated:YES];
            
        }
        else///支付失败
        {
            [SVProgressHUD showErrorWithStatus:@"支付失败，请在订单页面重新支付" cover:YES offsetY:kMainScreenHeight/2.0];
           // [[NSNotificationCenter defaultCenter] postNotificationName:kPayFail object:self];
        }
    }
    
}

#pragma mark 点击交流
- (void)touchCommunicateBtnWithTag:(NSInteger)tag
{
    switch (tag) {
        case Com_chat:
        {
            //在线聊天
            NSString *sellerName = self.orderModel.sellname;//姓名
            double userID = self.orderModel.sellid;//用户id
            //缺少头像

            NSString *useridStr = [NSString stringWithFormat:@"%d",(int)userID];
            NSMutableArray *temArray = [NSMutableArray new];
            [temArray addObject:useridStr];
            [self.userManage getUserNameUseridArray:temArray succBlock:^(NSMutableArray *aMuArray) {
                UserinfoBaseClass *model = [aMuArray objectAtIndex:0];
                ChatViewController *vc = [[ChatViewController alloc] initWithChatter:useridStr isGroup:NO andChatterAvatar:model.avatar];
                vc.title = sellerName;
                [self.navigationController pushViewController:vc animated:YES];
            } failBlock:^(NSString *aStr) {
                
            }];
        }
            break;
        case Com_message:
        {
            //短信
            if (self.orderModel.sellmob.length) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",self.orderModel.sellmob]]];
            } else{
                [SVProgressHUD showErrorWithStatus:@"卖家没有留下电话" cover:YES offsetY:0];
            }
            
        }
            break;
        case Com_phone:
        {
            //电话
            if (self.orderModel.sellmob.length) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.orderModel.sellmob]]];
            } else {
                [SVProgressHUD showErrorWithStatus:@"卖家没有留下电话" cover:YES offsetY:0];
            }
        }
            break;
        default:
            break;
    }
}

- (void)touchBack
{
    self.isPopToRoot ? [self.navigationController popToRootViewControllerAnimated:YES] : [self.navigationController popViewControllerAnimated:YES];
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
