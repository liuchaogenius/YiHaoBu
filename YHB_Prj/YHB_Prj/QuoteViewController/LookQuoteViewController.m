//
//  LookQuoteViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "LookQuoteViewController.h"
#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"
#import "LookQuoteManage.h"
#import "QuoteTableViewCell.h"
#import "PriceDetailViewController.h"

#define topViewHeight 40

@interface LookQuoteViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL isMe;
    LookQuoteManage *netManage;
    UIView *underLine;
}
@property(nonatomic, strong) UIButton *selectAllBtn;
@property(nonatomic, strong) UIButton *selectVipBtn;

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *tableViewArray;
@end

@implementation LookQuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的报价";
    self.tableViewArray = [NSMutableArray new];
    isMe=NO;
    
#pragma mark 建立topView
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, topViewHeight)];
    [self.view addSubview:topView];
    
    self.selectAllBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth/2, topViewHeight)];
    [self.selectAllBtn setTitle:@"给我报的价" forState:UIControlStateNormal];
    self.selectAllBtn.titleLabel.font = kFont16;
    [self.selectAllBtn setTitleColor:KColor forState:UIControlStateNormal];
    [self.selectAllBtn addTarget:self action:@selector(touchTopViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.selectAllBtn];
    
    UIView *midLineView = [[UIView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-0.25, 0, 0.5, topViewHeight)];
    midLineView.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:midLineView];
    
    self.selectVipBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2, 0, kMainScreenWidth/2, topViewHeight)];
    [self.selectVipBtn setTitle:@"我报过的价" forState:UIControlStateNormal];
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

#pragma mark tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topViewHeight, kMainScreenWidth, kMainScreenHeight-topViewHeight-62)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self addTableViewTrag];
    [self showFlower];
    
    netManage = [[LookQuoteManage alloc] init];
    [self getFirstData];
}

- (void)getFirstData
{
    [netManage getQuoteArray:^(NSMutableArray *aArray) {
        [self dismissFlower];
        self.tableViewArray = aArray;
        [self.tableView reloadData];
    } andFail:^{
        [self dismissFlower];
    } isMe:isMe];
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak LookQuoteViewController *weakself = self;
    [weakself.tableView addPullToRefreshWithActionHandler:^{
        [netManage getQuoteArray:^(NSMutableArray *aArray) {
            [weakself.tableView.pullToRefreshView stopAnimating];
            self.tableViewArray = aArray;
            [self.tableView reloadData];
        } andFail:^{
            [weakself.tableView.pullToRefreshView stopAnimating];
        } isMe:isMe];
    }];
    
    
    [weakself.tableView addInfiniteScrollingWithActionHandler:^{
        if(self.tableViewArray.count%20==0&&self.tableViewArray.count>0)
        {
            [netManage getNextQuoteArray:^(NSMutableArray *aArray) {
                [weakself.tableView.infiniteScrollingView stopAnimating];
                NSMutableArray *insertIndexPaths = [NSMutableArray new];
                for (unsigned long i=self.tableViewArray.count; i<self.tableViewArray.count+aArray.count; i++)
                {
                    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                    [insertIndexPaths addObject:indexpath];
                }
                [self.tableViewArray addObjectsFromArray:aArray];
                [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
            } andFail:^{
                [weakself.tableView.infiniteScrollingView stopAnimating];

            }];
        }
        else
        {
            [weakself.tableView.infiniteScrollingView stopAnimating];
        }
    }];
}

- (void)touchTopViewBtn:(UIButton *)aBtn
{
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.contentOffset = CGPointMake(0, 0);
    }];
    if (isMe)
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
    isMe = !isMe;
    [self showFlower];
    [self getFirstData];
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
    static NSString *cellIdentifier = @"cell";
    QuoteTableViewCell *cell = [[QuoteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    if (isMe)
    {
        QuoteMeRslist *meModel = [self.tableViewArray objectAtIndex:indexPath.row];
        [cell setCellWithModelWithModel:meModel andModel:nil isMe:YES];
    }
    else
    {
        QuoteRslist *model = [self.tableViewArray objectAtIndex:indexPath.row];
        [cell setCellWithModelWithModel:nil andModel:model isMe:NO];
        cell.lookQuoteBtn.tag = 100+indexPath.row;
        [cell.lookQuoteBtn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)touchBtn:(UIButton *)aBtn
{
    int index = (int)aBtn.tag-100;
    QuoteRslist *model = [self.tableViewArray objectAtIndex:index];
    PriceDetailViewController *vc = [[PriceDetailViewController alloc] initWithItemid:(int)model.itemid];
    [self.navigationController pushViewController:vc animated:YES];
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

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.tableViewArray.count==0)
    {
        [self dismissFlower];
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
