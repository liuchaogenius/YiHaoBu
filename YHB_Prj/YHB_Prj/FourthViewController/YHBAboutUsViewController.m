//
//  YHBAboutUsViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/18.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBAboutUsViewController.h"
#import "NetManager.h"
#import "SVProgressHUD.h"
@interface YHBAboutUsViewController ()

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;



@end

@implementation YHBAboutUsViewController

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 10, kMainScreenWidth-10, kMainScreenHeight-20-44-10)];
        _textView.backgroundColor = kViewBackgroundColor;
        _textView.font = kFont13;
    }
    return _textView;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = CGPointMake(kMainScreenWidth/2.0, 100);
    }
    return _indicatorView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:self.textView];
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    [self getOurInfo];
}
- (void)getOurInfo
{
    NSString *url = nil;
    kYHBRequestUrl(@"ourinfo.aspx", url);
    [NetManager requestWith:nil url:url method:@"GET" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        [self.indicatorView stopAnimating];
        if (successDict[@"ourinfo"]) {
            self.textView.text = successDict[@"ourinfo"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"信息获取失败，请稍后再试" cover:YES offsetY:kMainScreenWidth/2.0f];
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        [self.indicatorView stopAnimating];
        [SVProgressHUD showErrorWithStatus:@"网络连接失败，请检查网络" cover:YES offsetY:kMainScreenHeight/2.0f];
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
