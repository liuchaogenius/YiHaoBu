//
//  FirstViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 14-11-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "FirstViewController.h"
#import "YHBShopMallViewController.h"
#import "YHBPublishSupplyViewController.h"
#import "YHBLookSupplyViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#warning 首页ui未定
    UIButton *shopsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shopsBtn.frame = CGRectMake((kMainScreenWidth-100)/2.0f, 100, 100, 50);
    [shopsBtn setTitle:@"商城" forState:UIControlStateNormal];
    [shopsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shopsBtn addTarget:self action:@selector(touchShopsBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopsBtn];
    
    UIButton *supplyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    supplyBtn.frame = CGRectMake((kMainScreenWidth-100)/2.0f, 200, 100, 50);
    [supplyBtn setTitle:@"发供" forState:UIControlStateNormal];
    [supplyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [supplyBtn addTarget:self action:@selector(touchSupplyBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:supplyBtn];
    
    UIButton *lookSupplyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lookSupplyBtn.frame = CGRectMake((kMainScreenWidth-100)/2.0f, 300, 100, 50);
    [lookSupplyBtn setTitle:@"查供" forState:UIControlStateNormal];
    [lookSupplyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lookSupplyBtn addTarget:self action:@selector(lookSupplyBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lookSupplyBtn];
}

- (void)lookSupplyBtn
{
    YHBLookSupplyViewController *vc = [[YHBLookSupplyViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchSupplyBtn
{
    YHBPublishSupplyViewController *supplyVC = [[YHBPublishSupplyViewController alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:supplyVC] animated:YES completion:^{
        
    }];
}

#pragma mark - action
- (void)touchShopsBtn
{
    YHBShopMallViewController *shopMallVC = [[YHBShopMallViewController alloc] init];
    shopMallVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopMallVC animated:YES];
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
