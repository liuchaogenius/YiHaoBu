//
//  YHBSupplyDetailViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBSupplyDetailViewController.h"
#import "YHBSupplyDetailView.h"
#import "YHBVariousImageView.h"
#import "YHBSupplyDetailManage.h"
#import "SVProgressHUD.h"
#import "UIImage+WebP.h"
#import "YHBContactView.h"

#define kContactViewHeight 60
@interface YHBSupplyDetailViewController ()
{
    UIScrollView *scrollView;
    YHBSupplyDetailView *supplyDetailView;
    YHBVariousImageView *variousImageView;
    BOOL isModal;
    int itemId;
}
@property(nonatomic, strong) YHBSupplyDetailManage *netManage;
@end

@implementation YHBSupplyDetailViewController

- (instancetype)initWithItemId:(int)aItemId
{
    if (self = [super init]) {
        isModal=NO;
        itemId = aItemId;
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

- (YHBSupplyDetailManage *)netManage
{
    if (!_netManage) {
        _netManage = [[YHBSupplyDetailManage alloc] init];
    }
    return _netManage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(241, 241, 241);
    self.title = @"供应详情";
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-kContactViewHeight-62)];
    [self.view addSubview:scrollView];
    
    variousImageView = [[YHBVariousImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 120) andPhotoArray:[NSArray new]];
    [scrollView addSubview:variousImageView];
    
    supplyDetailView = [[YHBSupplyDetailView alloc] initWithFrame:CGRectMake(0, variousImageView.bottom, kMainScreenWidth, 270)];
    [scrollView addSubview:supplyDetailView];
    
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(dismissSelf)];

    UIButton *watchStoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, supplyDetailView.bottom+20, kMainScreenWidth-10, 35)];
    watchStoreBtn.backgroundColor = KColor;
    [watchStoreBtn addTarget:self action:@selector(watchStoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [watchStoreBtn setTitle:@"浏览商城" forState:UIControlStateNormal];
    watchStoreBtn.layer.cornerRadius = 2.5;
    watchStoreBtn.titleLabel.font = kFont15;
    [scrollView addSubview:watchStoreBtn];
    
    scrollView.contentSize = CGSizeMake(kMainScreenWidth, watchStoreBtn.bottom+20);
    
    YHBContactView *contactView = [[YHBContactView alloc] initWithFrame:CGRectMake(0, scrollView.bottom, kMainScreenWidth, kContactViewHeight)];
    contactView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contactView];
    
    [self showFlower];
    
    if (isModal==NO)
    {
        [self.netManage getSupllyDetailWithItemid:itemId SuccessBlock:^(YHBSupplyDetailModel *aModel)
         {
             [supplyDetailView setDetailWithModel:aModel];
             [variousImageView setMyWebPhotoArray:aModel.pic];
             [contactView setPhoneNumber:aModel.mobile storeName:aModel.truename itemId:itemId isVip:aModel.vip];
             [self dismissFlower];
         } andFailBlock:^{
             [self dismissFlower];
         }];
    }
}

#pragma mark 浏览商城
- (void)watchStoreBtn
{
    MLOG(@"浏览商城");
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
