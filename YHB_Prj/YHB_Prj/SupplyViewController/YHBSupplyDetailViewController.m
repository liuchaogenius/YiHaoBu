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

@interface YHBSupplyDetailViewController ()
{
    UIScrollView *scrollView;
}
@end

@implementation YHBSupplyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(241, 241, 241);
    self.title = @"供应详情";
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-50-62)];
    [self.view addSubview:scrollView];
    
    YHBVariousImageView *variousImageView = [[YHBVariousImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 110) andPhotoArray:[NSArray new]];
    [scrollView addSubview:variousImageView];
    
    YHBSupplyDetailView *supplyDetailView = [[YHBSupplyDetailView alloc] initWithFrame:CGRectMake(0, variousImageView.bottom, kMainScreenWidth, 340)];
    [scrollView addSubview:supplyDetailView];
    
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(dismissSelf)];

    UIButton *watchStoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(3, supplyDetailView.bottom+5, kMainScreenWidth-6, 35)];
    watchStoreBtn.backgroundColor = KColor;
    [watchStoreBtn setTitle:@"浏览商城" forState:UIControlStateNormal];
    watchStoreBtn.titleLabel.font = kFont15;
    [scrollView addSubview:watchStoreBtn];
    
    scrollView.contentSize = CGSizeMake(kMainScreenWidth, watchStoreBtn.bottom+10);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, scrollView.bottom, kMainScreenWidth, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)dismissSelf
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
