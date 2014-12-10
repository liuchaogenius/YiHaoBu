//
//  FifthViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 14-11-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "FifthViewController.h"
#import "YHBShoppingCartTableViewCell.h"
#import "TableSectionFooterView.h"
#import "YHBShopCartManage.h"
#import "YHBShopCartRslist.h"
#import "YHBShopCartCartlist.h"
#import "SVProgressHUD.h"

@interface FifthViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    YHBShoppingCartTableViewCell *selectedCell;
}
@property(nonatomic, strong) YHBShopCartManage *netManage;
@property(nonatomic, strong) NSMutableArray *tableViewArray;
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.netManage = [[YHBShopCartManage alloc] init];
    self.tableViewArray = [NSMutableArray new];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-62-49-50) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self showFlower];
    [self.netManage getShopCartArray:^(NSMutableArray *aArray) {
        self.tableViewArray = aArray;
        [self.tableView reloadData];
        [self dismissFlower];
    } andFail:^{
        [self dismissFlower];
    }];
}

#pragma mark tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    TableSectionFooterView *view = [[TableSectionFooterView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
    YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:section];
    [view setViewWith:model];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:section];
    return model.cartlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHBShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[YHBShoppingCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.isSelected = NO;
    YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:indexPath.section];
    YHBShopCartCartlist *cartModel = [model.cartlist objectAtIndex:indexPath.row];
    [cell setCellWithModel:cartModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
