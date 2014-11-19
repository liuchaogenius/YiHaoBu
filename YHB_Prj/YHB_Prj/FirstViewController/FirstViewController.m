//
//  FirstViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 14-11-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "FirstViewController.h"
#import "YHBShopMallViewController.h"
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
