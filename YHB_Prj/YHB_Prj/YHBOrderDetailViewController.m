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
typedef enum : NSInteger {
    Com_phone = 0,//电话
    Com_message,//短信
    Com_chat,//在线
} Communicate_Type;

@interface YHBOrderDetailViewController ()<YHBOrderFSDelegate,YHBOrderSecondViewDelegate>
@property (assign, nonatomic) NSInteger itemID;
@property (strong, nonatomic) YHBOrderManager *orderManager;
@property (strong, nonatomic) YHBOrderDetail *orderModel;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) YHBOrderFirstSectionView *firstSection;
@property (strong, nonatomic) YHBOrderSecondView *secondSection;
@property (strong, nonatomic) YHBOrderDetailInfoView *infoView;

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
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
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
    } failure:^{
        [SVProgressHUD dismissWithError:@"加载订单信息失败，请稍后再试!"];
    }];
}

- (void)reSetUI
{
    [self.firstSection setUIWithBuyer:self.orderModel.buyerName address:self.orderModel.buyerAddress moble:self.orderModel.buyerMobile statusDes:self.orderModel.dstatus isNeedLogicView:(self.orderModel.sendUrl.length ? YES:NO) amount:self.orderModel.money fee:self.orderModel.fee];
    [self.scrollView addSubview:self.firstSection];
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

#pragma mark 点击交流
- (void)touchCommunicateBtnWithTag:(NSInteger)tag
{
    switch (tag) {
        case Com_chat:
        {
            //在线聊天
        }
            break;
        case Com_message:
        {
            //短信
        }
            break;
        case Com_phone:
        {
            //电话
        }
            break;
        default:
            break;
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
