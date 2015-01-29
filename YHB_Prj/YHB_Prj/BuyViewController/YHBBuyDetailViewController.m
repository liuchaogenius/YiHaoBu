//
//  YHBBuyDetailViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBBuyDetailViewController.h"
#import "YHBBuyDetailManage.h"
#import "SVProgressHUD.h"
#import "YHBContactView.h"
#import "YHBBuyDetailView.h"
#import "YHBVariousImageView.h"
#import "YHBContactView.h"
#import "PushPriceViewController.h"
#import "YHBPublishBuyViewController.h"
#import "YHBStoreViewController.h"

#define kContactViewHeight 60
@interface YHBBuyDetailViewController ()
{
    UIScrollView *scrollView;
    YHBBuyDetailView *buyDetailView;
    YHBVariousImageView *variousImageView;
    BOOL isModal;
    int itemId;
    YHBBuyDetailData *myModel;
    BOOL isMine;
    YHBContactView *contactView;
}
@property(nonatomic, strong) YHBBuyDetailManage *manage;
@end

@implementation YHBBuyDetailViewController

- (instancetype)initWithItemId:(int)aItemId andIsMine:(BOOL)aIsMine isModal:(BOOL)aIsModal
{
    if (self = [super init]) {
        isModal = aIsModal;
        itemId = aItemId;
        isMine = aIsMine;
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        isModal = YES;
        [self dismissFlower];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(241, 241, 241);
    self.title = @"求购详情";
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-kContactViewHeight-62)];
    [self.view addSubview:scrollView];
    
    variousImageView = [[YHBVariousImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 120) andPhotoArray:[NSArray new]];
    [scrollView addSubview:variousImageView];
    
    buyDetailView = [[YHBBuyDetailView alloc] initWithFrame:CGRectMake(0, variousImageView.bottom, kMainScreenWidth, 235)];
    [scrollView addSubview:buyDetailView];
    
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(dismissSelf)];
    
    if (!isMine)
    {
        UIButton *pushPriceBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, buyDetailView.bottom+20, kMainScreenWidth/2-20, 40)];
        pushPriceBtn.backgroundColor = KColor;
        [pushPriceBtn addTarget:self action:@selector(pushPriceBtn) forControlEvents:UIControlEventTouchUpInside];
        [pushPriceBtn setTitle:@"我要报价" forState:UIControlStateNormal];
        [pushPriceBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        pushPriceBtn.layer.cornerRadius = 2.5;
        [scrollView addSubview:pushPriceBtn];
        
        UIButton *watchStoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(pushPriceBtn.right+20, pushPriceBtn.top, kMainScreenWidth/2-20, 40)];
        watchStoreBtn.backgroundColor = KColor;
        [watchStoreBtn addTarget:self action:@selector(watchStoreBtn) forControlEvents:UIControlEventTouchUpInside];
        [watchStoreBtn setTitle:@"浏览店铺" forState:UIControlStateNormal];
        watchStoreBtn.layer.cornerRadius = 2.5;
        [watchStoreBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        [scrollView addSubview:watchStoreBtn];
        
        scrollView.contentSize = CGSizeMake(kMainScreenWidth, pushPriceBtn.bottom+20);
        
        contactView = [[YHBContactView alloc] initWithFrame:CGRectMake(0, scrollView.bottom, kMainScreenWidth, kContactViewHeight)];
        contactView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:contactView];
    }
    
    UIView *navRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 22)];
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(navRightView.right-25, 0, 25, 21)];
    [shareBtn setImage:[UIImage imageNamed:@"detailShareImg"] forState:UIControlStateNormal];
    [shareBtn addTarget:self  action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [navRightView addSubview:shareBtn];
    
    if (isMine)
    {
        UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        [editBtn setImage:[UIImage imageNamed:@"editImg"] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
        [navRightView addSubview:editBtn];
    }
    
    UIBarButtonItem *navRightBarItem = [[UIBarButtonItem alloc] initWithCustomView:navRightView];
    self.navigationItem.rightBarButtonItem = navRightBarItem;
   
    [self showFlower];
    
//    if (isModal==NO)
//    {
        self.manage = [[YHBBuyDetailManage alloc] init];
        [self.manage getBuyDetailWithItemid:itemId SuccessBlock:^(YHBBuyDetailData *aModel)
         {
             myModel = aModel;
             [buyDetailView setDetailWithModel:aModel];
             [variousImageView setMyWebPhotoArray:aModel.pic];
             if (!isMine) {
                 [contactView setPhoneNumber:aModel.mobile storeName:aModel.truename itemId:itemId isVip:aModel.vip imgUrl:@"1" Title:myModel.title andType:@"buy"];
             }
             [self dismissFlower];
         } andFailBlock:^(NSString *aStr) {
             [self dismissFlower];
//             [self.navigationController popViewControllerAnimated:YES];
             [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
         }];
//    }
}

#pragma mark 分享
- (void)share
{
    MLOG(@"分享");
}

#pragma mark 编辑
- (void)edit
{
    YHBPublishBuyViewController *vc = [[YHBPublishBuyViewController alloc] initWithModel:myModel];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark 浏览商城
- (void)pushPriceBtn
{
    PushPriceViewController *vc = [[PushPriceViewController alloc] initWithItemId:myModel.itemid];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)watchStoreBtn
{
    YHBStoreViewController *vc = [[YHBStoreViewController alloc] initWithShopID:(int)myModel.userid];
    [self.navigationController pushViewController:vc animated:YES];
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

- (void)dismissSelf
{
    [self dismissFlower];
    if (isModal)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self dismissFlower];
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
