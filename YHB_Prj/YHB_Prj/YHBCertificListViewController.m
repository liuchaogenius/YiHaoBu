//
//  YHBCertificListViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBCertificListViewController.h"
#import "YHBUser.h"
#import "YHBUserInfo.h"
#import "YHBComCertificVieController.h"
@interface YHBCertificListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation YHBCertificListViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20-44) style:UITableViewStylePlain];
        _tableView.backgroundColor = kViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:self.tableView];
    [self setExtraCellLineHidden:self.tableView];
}

#pragma mark - 数据源方法
#pragma mark 数据行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

//    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, cell.height-10)];
//    [icon setContentMode:UIViewContentModeScaleAspectFit];
//    [cell.contentView addSubview:icon];
    
    cell.imageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], indexPath.row?@"Cert_Store" :@"Cert_phone"]];
    
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(icon.right+5, 0, 100, cell.height)];
//    titleLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = kFont14;
    cell.textLabel.text = indexPath.row ? @"企业认证":@"   手机认证";
//    [cell.contentView addSubview:titleLabel];
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-20-60, 0, 60, cell.height)];
    statusLabel.font = kFont12;
    if (indexPath.row == 0 || [YHBUser sharedYHBUser].userInfo.groupid > 6) {
        statusLabel.text = @"已认证";
        statusLabel.textColor = RGBCOLOR(0, 119, 0);
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }else{
        statusLabel.text = @"未认证";
        statusLabel.textColor = [UIColor lightGrayColor];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    [cell.contentView addSubview:statusLabel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1 && [YHBUser sharedYHBUser].userInfo.groupid != 7) {
        YHBComCertificVieController *vc = [[YHBComCertificVieController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
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
