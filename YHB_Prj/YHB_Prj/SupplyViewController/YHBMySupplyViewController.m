//
//  YHBMySupplyViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/26.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBMySupplyViewController.h"
#import "GoodsTableViewCell.h"
#import "SVPullToRefresh.h"
#import "SVProgressHUD.h"
#import "YHBSupplyModel.h"
#import "YHBSupplyDetailViewController.h"
#import "YHBBuyDetailViewController.h"
#import "YHBPublishSupplyViewController.h"
#import "YHBPublishBuyViewController.h"
#import "YHBMySupplyManage.h"

@interface YHBMySupplyViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL isSupply;
}

@property(nonatomic, strong) UITableView *supplyTableView;
@property(nonatomic, strong) NSMutableArray *tableViewArray;
@end

@implementation YHBMySupplyViewController

- (instancetype)initWithIsSupply:(BOOL)aIsSupply
{
    if (self = [super init]) {
        isSupply = aIsSupply;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (isSupply)
    {
        self.title = @"我的供应";
    }
    else
    {
        self.title = @"我的采购";
    }
    [self setRightButton:nil title:@"添加+" target:self action:@selector(addSupply)];
#pragma mark 建立tableview
    self.supplyTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.supplyTableView.delegate = self;
    self.supplyTableView.dataSource = self;
    self.supplyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.supplyTableView];
    
//    [self addTableViewTrag];
    [self showFlower];
    
    YHBMySupplyManage *manage = [[YHBMySupplyManage alloc] init];
    [manage getSupplyArray:^(NSMutableArray *aArray) {
        [self dismissFlower];
        self.tableViewArray = aArray;
        [self.supplyTableView reloadData];
    } andFail:^{
        [self dismissFlower];
    } isSupply:isSupply];
}

- (void)addSupply
{
    if (isSupply)
    {
        YHBPublishSupplyViewController *vc = [[YHBPublishSupplyViewController alloc] init];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
            
        }];
    }
    else
    {
        YHBPublishBuyViewController *vc = [[YHBPublishBuyViewController alloc] init];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
            
        }];
    }
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

#pragma mark tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    YHBSupplyModel *model = [self.tableViewArray objectAtIndex:indexPath.row];
    [cell setCellWithGoodImage:@"http://file1.youboy.com/a/42/96/35/7/381037.jpg" title:model.title catName:model.catname typeName:model.typename editTime:model.editdate skimCount:2000 paidPrice:0 isVip:model.vip];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHBSupplyModel *model = [self.tableViewArray objectAtIndex:indexPath.row];
    if (isSupply) {
        YHBSupplyDetailViewController *vc = [[YHBSupplyDetailViewController alloc] initWithItemId:model.itemid andIsMine:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        YHBBuyDetailViewController *vc = [[YHBBuyDetailViewController alloc] initWithItemId:model.itemid andIsMine:YES];
        [self.navigationController pushViewController:vc animated:YES];
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
