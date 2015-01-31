//
//  YHBLookSupplyViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/6.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBLookSupplyViewController.h"
#import "GoodsTableViewCell.h"
#import "SVPullToRefresh.h"
#import "YHBLookSupplyManage.h"
#import "SVProgressHUD.h"
#import "YHBSupplyModel.h"
#import "YHBSupplyDetailViewController.h"
#import "YHBLookBuyManage.h"
#import "YHBBuyDetailViewController.h"

#define topViewHeight 40

@interface YHBLookSupplyViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL isVip;
    BOOL isSupply;
}
@property(nonatomic, strong) UIButton *selectAllBtn;
@property(nonatomic, strong) UIButton *selectVipBtn;

@property(nonatomic, strong) UITableView *supplyTableView;

@property(nonatomic, strong) NSMutableArray *tableViewArray;

@property(nonatomic, strong) YHBLookSupplyManage *supplyManage;
@property(nonatomic, strong) YHBLookBuyManage *buyManage;
@end

@implementation YHBLookSupplyViewController

- (instancetype)initWithIsSupply:(BOOL)aIsSupply
{
    if (self = [super init]) {
        isSupply = aIsSupply;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    isVip = NO;
    
    if (isSupply) {
        self.title = @"查看供应";
    }
    else
    {
        self.title = @"查看求购";
    }
    
#pragma mark 建立topView
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, topViewHeight)];
    [self.view addSubview:topView];

    self.selectAllBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth/2, topViewHeight)];
    [self.selectAllBtn setTitle:@"全部" forState:UIControlStateNormal];
    self.selectAllBtn.titleLabel.font = kFont16;
    [self.selectAllBtn setTitleColor:KColor forState:UIControlStateNormal];
    [self.selectAllBtn addTarget:self action:@selector(touchTopViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.selectAllBtn];
    
    UIView *midLineView = [[UIView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-0.25, 10, 0.5, topViewHeight-20)];
    midLineView.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:midLineView];
    
    self.selectVipBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2, 0, kMainScreenWidth/2, topViewHeight)];
    [self.selectVipBtn setTitle:@"仅看VIP" forState:UIControlStateNormal];
    self.selectVipBtn.titleLabel.font = kFont16;
    [self.selectVipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectVipBtn addTarget:self action:@selector(touchTopViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.selectVipBtn];
    
    UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, topViewHeight-0.5, kMainScreenWidth, 0.5)];
    underLineView.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:underLineView];
    
#pragma mark 建立tableview
    self.supplyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topViewHeight, kMainScreenWidth, kMainScreenHeight-topViewHeight-62)];
    self.supplyTableView.delegate = self;
    self.supplyTableView.dataSource = self;
    self.supplyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.supplyTableView];
    
    [self addTableViewTrag];
    [self showFlower];
    [self getDataIsVip:isVip];
}

- (void)getDataIsVip:(BOOL)aIsVip
{
    if (isSupply) {
        [self.supplyManage getSupplyArray:^(NSMutableArray *aArray){
            [self dismissFlower];
            self.tableViewArray = aArray;
            [self.supplyTableView reloadData];
        } andFail:^(NSString *aStr) {
            [self dismissFlower];
            [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
        } isVip:isVip];
    }
    else
    {
        [self.buyManage getBuyArray:^(NSMutableArray *aArray) {
            [self dismissFlower];
            self.tableViewArray = aArray;
            [self.supplyTableView reloadData];
        } andFail:^(NSString *aStr){
            [self dismissFlower];
            [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
        } isVip:isVip];
    }
    
}

- (void)touchTopViewBtn:(UIButton *)aBtn
{
    [UIView animateWithDuration:0.2 animations:^{
        self.supplyTableView.contentOffset = CGPointMake(0, 0);
    }];
    if (isVip)
    {
        [self.selectAllBtn setTitleColor:KColor forState:UIControlStateNormal];
        [self.selectVipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else
    {
        [self.selectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.selectVipBtn setTitleColor:KColor forState:UIControlStateNormal];
    }
    isVip = !isVip;
    [self showFlower];
    [self getDataIsVip:isVip];
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

#pragma mark manage
- (YHBLookSupplyManage *)supplyManage
{
    if (!_supplyManage) {
        _supplyManage = [[YHBLookSupplyManage alloc] init];
    }
    return _supplyManage;
}

-(YHBLookBuyManage *)buyManage
{
    if (!_buyManage) {
        _buyManage = [[YHBLookBuyManage alloc] init];
    }
    return _buyManage;
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak YHBLookSupplyViewController *weakself = self;
    [weakself.supplyTableView addPullToRefreshWithActionHandler:^{
        if (isSupply) {
            [self.supplyManage getSupplyArray:^(NSMutableArray *aArray){
                [weakself.supplyTableView.pullToRefreshView stopAnimating];
                self.tableViewArray = aArray;
                [self.supplyTableView reloadData];
            } andFail:^(NSString *aStr){
                [weakself.supplyTableView.pullToRefreshView stopAnimating];
                [self dismissFlower];
            } isVip:isVip];
        }
        else
        {
            [self.buyManage getBuyArray:^(NSMutableArray *aArray) {
                [weakself.supplyTableView.pullToRefreshView stopAnimating];
                self.tableViewArray = aArray;
                [self.supplyTableView reloadData];
            } andFail:^(NSString *aStr){
                [weakself.supplyTableView.pullToRefreshView stopAnimating];
                [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
            } isVip:isVip];
        }
        
    }];
    
    
    [weakself.supplyTableView addInfiniteScrollingWithActionHandler:^{
        if(self.tableViewArray.count%20==0&&self.tableViewArray.count>0)
        {
            if (isSupply) {
                [self.supplyManage getNextSupplyArray:^(NSMutableArray *aArray) {
                    [weakself.supplyTableView.infiniteScrollingView stopAnimating];
                    NSMutableArray *insertIndexPaths = [NSMutableArray new];
                    for (unsigned long i=self.tableViewArray.count; i<self.tableViewArray.count+aArray.count; i++)
                    {
                        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                        [insertIndexPaths addObject:indexpath];
                    }
                    [self.tableViewArray addObjectsFromArray:aArray];
                    [self.supplyTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
                } andFail:^(NSString *aStr){
                    [weakself.supplyTableView.infiniteScrollingView stopAnimating];
                    [self dismissFlower];
                }];
            }
            else
            {
                [self.buyManage getNextBuyArray:^(NSMutableArray *aArray) {
                    [weakself.supplyTableView.infiniteScrollingView stopAnimating];
                    NSMutableArray *insertIndexPaths = [NSMutableArray new];
                    for (unsigned long i=self.tableViewArray.count; i<self.tableViewArray.count+aArray.count; i++)
                    {
                        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                        [insertIndexPaths addObject:indexpath];
                    }
                    [self.tableViewArray addObjectsFromArray:aArray];
                    [self.supplyTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
                } andFail:^(NSString *aStr){
                    [weakself.supplyTableView.infiniteScrollingView stopAnimating];
                    [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
                }];
            }
        }
        else
        {
            [weakself.supplyTableView.infiniteScrollingView stopAnimating];
        }
    }];
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
    [cell setCellWithModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHBSupplyModel *model = [self.tableViewArray objectAtIndex:indexPath.row];
    if (isSupply) {
        YHBSupplyDetailViewController *vc = [[YHBSupplyDetailViewController alloc] initWithItemId:model.itemid andIsMine:NO isModal:NO];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        YHBBuyDetailViewController *vc = [[YHBBuyDetailViewController alloc] initWithItemId:model.itemid andIsMine:NO isModal:NO];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self dismissFlower];
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
