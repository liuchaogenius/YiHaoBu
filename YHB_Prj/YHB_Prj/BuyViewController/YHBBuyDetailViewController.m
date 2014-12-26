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

- (instancetype)initWithItemId:(int)aItemId andIsMine:(BOOL)aIsMine
{
    if (self = [super init]) {
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
   
    [self showFlower];
    
    if (isModal==NO)
    {
        self.manage = [[YHBBuyDetailManage alloc] init];
        [self.manage getBuyDetailWithItemid:itemId SuccessBlock:^(YHBBuyDetailData *aModel)
         {
             myModel = aModel;
             [buyDetailView setDetailWithModel:aModel];
             [variousImageView setMyWebPhotoArray:aModel.pic];
             if (!isMine) {
                 [contactView setPhoneNumber:aModel.mobile storeName:aModel.truename itemId:itemId isVip:aModel.vip];
             }
             [self dismissFlower];
         } andFailBlock:^{
             [self dismissFlower];
         }];
    }
}

#pragma mark 浏览商城
- (void)pushPriceBtn
{
    PushPriceViewController *vc = [[PushPriceViewController alloc] initWithItemId:myModel.itemid];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)watchStoreBtn
{
    MLOG(@"浏览店铺");
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
