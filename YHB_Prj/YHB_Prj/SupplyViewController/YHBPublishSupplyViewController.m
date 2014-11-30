//
//  YHBPublishSupplyViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBPublishSupplyViewController.h"
#import "YHBVariousImageView.h"
#import "YHBEditSupplyView.h"
#import "YHBContactView.h"
#import "YHBSupplyDetailViewController.h"

@interface YHBPublishSupplyViewController ()
{
    UIScrollView *scrollView;
}
@end

@implementation YHBPublishSupplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(dismissSelf)];
    
    self.title = @"发布供应";
    self.view.backgroundColor = RGBCOLOR(241, 241, 241);
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    YHBVariousImageView *variousImageView = [[YHBVariousImageView alloc] initEditWithFrame:CGRectMake(0, 0, kMainScreenWidth, 110)];
    [scrollView addSubview:variousImageView];
    
    YHBEditSupplyView *editSupplyView = [[YHBEditSupplyView alloc] initWithFrame:CGRectMake(0, variousImageView.bottom, kMainScreenWidth, 300)];
    [scrollView addSubview:editSupplyView];
    
    YHBContactView *contactView = [[YHBContactView alloc] initWithFrame:CGRectMake(0, editSupplyView.bottom+5, kMainScreenWidth, 60)];
    [scrollView addSubview:contactView];
    
    UIButton *publishBtn = [[UIButton alloc] initWithFrame:CGRectMake(3, contactView.bottom+10, kMainScreenWidth-6, 35)];
    publishBtn.layer.cornerRadius = 2.5;
    publishBtn.backgroundColor = KColor;
    [publishBtn setTitle:@"发 布" forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(TouchPublish)
         forControlEvents:UIControlEventTouchUpInside];
    publishBtn.titleLabel.font = kFont15;
    [scrollView addSubview:publishBtn];
    
    scrollView.contentSize = CGSizeMake(kMainScreenWidth, publishBtn.bottom+10);
}

- (void)dismissSelf
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)TouchPublish
{
    YHBSupplyDetailViewController *vc = [[YHBSupplyDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
