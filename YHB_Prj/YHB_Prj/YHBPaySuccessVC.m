//
//  YHBPaySuccessVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/2/8.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBPaySuccessVC.h"

@interface YHBPaySuccessVC ()

@property (strong, nonatomic) NSString *info;

@end

@implementation YHBPaySuccessVC

- (instancetype)initWithAppendInfo:(NSString *)info
{
    self = [super init];
    if (self) {
        self.info = info;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBackgroundColor;
    self.title = @"支付结果";
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 150, 20)];
    resultLabel.text = @"你已付款成功!";
    resultLabel.textColor = [UIColor lightGrayColor];
    
    [self.view addSubview:resultLabel];
    
    if (self.info.length) {
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, 260, 60)];
        infoLabel.numberOfLines = 2;
        infoLabel.text = self.info;
        infoLabel.textColor = [UIColor lightGrayColor];
        [self.view addSubview:infoLabel];
    }
    
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(touchBack)];
}

- (void)touchBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
