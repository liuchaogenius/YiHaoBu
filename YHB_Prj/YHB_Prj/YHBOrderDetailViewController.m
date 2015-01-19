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
@interface YHBOrderDetailViewController ()<YHBOrderFSDelegate>

@property (assign, nonatomic) NSInteger itemID;
@property (strong, nonatomic) YHBOrderManager *orderManager;
@property (strong, nonatomic) YHBOrderDetail *orderModel;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) YHBOrderFirstSectionView *firstSection;

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
    [self.firstSection setUIWithBuyer:self.orderModel.buyerName address:self.orderModel.buyerAddress moble:self.orderModel.buyerMobile statusDes:self.orderModel.dstatus isNeedLogicView:(self.orderModel.sendUrl.length ? YES:NO) amount:self.orderModel.amount fee:self.orderModel.fee];
    [self.scrollView addSubview:self.firstSection];
    if (![self.firstSection superview]) {
        [self.scrollView addSubview:self.firstSection];
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
