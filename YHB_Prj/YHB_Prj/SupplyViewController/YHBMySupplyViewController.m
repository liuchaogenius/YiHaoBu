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

#define topViewHeight 40

@interface YHBMySupplyViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL isSupply;
    YHBMySupplyManage *manage;
    BOOL isFind;
    UIView *underLine;
}

@property(nonatomic, strong) UITableView *supplyTableView;
@property(nonatomic, strong) NSMutableArray *tableViewArray;
@property(nonatomic, strong) UIButton *selectAllBtn;
@property(nonatomic, strong) UIButton *selectVipBtn;
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
    self.view.backgroundColor = [UIColor whiteColor];
    if (isSupply)
    {
        self.title = @"我的供应";
        self.supplyTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    }
    else
    {
        self.title = @"我的采购";
        isFind=NO;
#pragma mark 建立topView
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, topViewHeight)];
        [self.view addSubview:topView];
        
        self.selectAllBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth/2, topViewHeight)];
        [self.selectAllBtn setTitle:@"寻找中" forState:UIControlStateNormal];
        self.selectAllBtn.titleLabel.font = kFont16;
        [self.selectAllBtn setTitleColor:KColor forState:UIControlStateNormal];
        [self.selectAllBtn addTarget:self action:@selector(touchTopViewBtn:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:self.selectAllBtn];
        
        UIView *midLineView = [[UIView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-0.25, 10, 0.5, topViewHeight-20)];
        midLineView.backgroundColor = [UIColor lightGrayColor];
        [topView addSubview:midLineView];
        
        self.selectVipBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2, 0, kMainScreenWidth/2, topViewHeight)];
        [self.selectVipBtn setTitle:@"已找到" forState:UIControlStateNormal];
        self.selectVipBtn.titleLabel.font = kFont16;
        [self.selectVipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.selectVipBtn addTarget:self action:@selector(touchTopViewBtn:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:self.selectVipBtn];
        
        UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, topViewHeight-0.5, kMainScreenWidth, 0.5)];
        underLineView.backgroundColor = [UIColor lightGrayColor];
        [topView addSubview:underLineView];

        underLine = [[UIView alloc] initWithFrame:CGRectMake(0, topViewHeight-2, kMainScreenWidth/2.0, 2)];
        underLine.backgroundColor = KColor;
        [topView addSubview:underLine];
        
        self.supplyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topViewHeight, kMainScreenWidth, kMainScreenHeight-62-topViewHeight)];
    }
    [self setRightButton:nil title:@"添加+" target:self action:@selector(addSupply)];
#pragma mark 建立tableview
    self.supplyTableView.delegate = self;
    self.supplyTableView.dataSource = self;
    self.supplyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.supplyTableView];
    
    [self addTableViewTrag];
    [self showFlower];
    
    manage = [[YHBMySupplyManage alloc] init];
    [self getFirstDataWithIsSupply:isSupply andIsFind:isFind];
}

- (void)getFirstDataWithIsSupply:(BOOL)aSupplyBool andIsFind:(BOOL)aFindBool
{
    [manage getSupplyArray:^(NSMutableArray *aArray) {
        [self dismissFlower];
        self.tableViewArray = aArray;
        [self.supplyTableView reloadData];
    } andFail:^(NSString *aStr){
        [self dismissFlower];
        [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
    } isSupply:isSupply isFind:isFind];
}

- (void)touchTopViewBtn:(UIButton *)aBtn
{
    [UIView animateWithDuration:0.2 animations:^{
        self.supplyTableView.contentOffset = CGPointMake(0, 0);
    }];
    if (isFind)
    {
        [self.selectAllBtn setTitleColor:KColor forState:UIControlStateNormal];
        [self.selectVipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = CGRectMake(0, topViewHeight-2, kMainScreenWidth/2.0, 2);
            underLine.frame = frame;
        }];
    }
    else
    {
        [self.selectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.selectVipBtn setTitleColor:KColor forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = CGRectMake(kMainScreenWidth/2.0, topViewHeight-2, kMainScreenWidth/2.0, 2);
            underLine.frame = frame;
        }];
    }
    isFind = !isFind;
    [self showFlower];
    [self getFirstDataWithIsSupply:isSupply andIsFind:isFind];
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak YHBMySupplyViewController *weakself = self;
    [weakself.supplyTableView addPullToRefreshWithActionHandler:^{
        [manage getSupplyArray:^(NSMutableArray *aArray) {
            [weakself.supplyTableView.pullToRefreshView stopAnimating];
            self.tableViewArray = aArray;
            [self.supplyTableView reloadData];
        } andFail:^(NSString *aStr){
            [weakself.supplyTableView.pullToRefreshView stopAnimating];
            [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
        } isSupply:isSupply isFind:isFind];
    }];
    
    
    [weakself.supplyTableView addInfiniteScrollingWithActionHandler:^{
        if(self.tableViewArray.count%20==0&&self.tableViewArray.count>0)
        {
            [manage getNextSupplyArray:^(NSMutableArray *aArray) {
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
        else
        {
            [weakself.supplyTableView.infiniteScrollingView stopAnimating];
        }
    }];
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
    [cell setCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHBSupplyModel *model = [self.tableViewArray objectAtIndex:indexPath.row];
    if (isSupply) {
        YHBSupplyDetailViewController *vc = [[YHBSupplyDetailViewController alloc] initWithItemId:model.itemid andIsMine:YES isModal:NO];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        YHBBuyDetailViewController *vc = [[YHBBuyDetailViewController alloc] initWithItemId:model.itemid andIsMine:YES isModal:NO];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self dismissFlower];
    [super viewWillDisappear:YES];
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
