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

#define KAbtnWidth 70
#define kAbtnHeight 25
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
@property (strong, nonatomic) UIView *actionView;
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
            NSString *title = [self.orderModel getTitleOfNextStepForIndex:i];
            if (title && title.length && i < 2) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:title forState:UIControlStateNormal];
                btn.frame = CGRectMake(kMainScreenWidth-(!i + 1)*(KAbtnWidth+10) , _actionView.height/2.0-kAbtnHeight/2.0, KAbtnWidth, kAbtnHeight);
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
#warning 评价vc未引入
//    YHBPublicCommentVC *vc = [[YHBPublicCommentVC alloc] initWithOrderDetailModel:self.orderModel];
//    [self.navigationController pushViewController:vc animated:YES];
    
    NSString *action = self.orderModel.naction[sender.tag];
    [SVProgressHUD showWithStatus:@"操作中..." cover:YES offsetY:0];
    __weak YHBOrderDetailViewController *weakself = self;
    [self.orderManager changeOrderStatusWithToken:([YHBUser sharedYHBUser].token ? :@"") ItemID:(NSInteger)self.orderModel.itemid Action:action?:@"" Success:^{
        [SVProgressHUD showWithStatus:@"操作成功,正在重新加载订单信息.." cover:YES offsetY:0];
        [weakself.orderManager getOrderDetailWithToken:([YHBUser sharedYHBUser].token?:@"") ItemID:(NSInteger)weakself.orderModel.itemid Success:^(YHBOrderDetail *model) {
            weakself.orderModel = model;
            [weakself reSetUI];
            [SVProgressHUD dismissWithSuccess:@"操作成功!"];
        } failure:^{
            [SVProgressHUD dismissWithError:@"加载订单信息失败,请重新尝试"];
        }];
    } failure:^{
        [SVProgressHUD dismissWithError:@"操作失败，请稍后重试"];
    }];
    
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
