//
//  YHBProductListViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/28.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBProductListViewController.h"
#import "YHBInfoListManager.h"
#import "YHBPage.h"
#import "YHBUser.h"
#import "YHBUserInfo.h"
#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"
#import "YHBProductListsCell.h"
#import "YHBRslist.h"
#import "YHBProductDetailVC.h"

#define kGoodsCellHeight 80
#define kPageSize 30
@interface YHBProductListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) YHBInfoListManager *manager;
@property (strong, nonatomic) NSMutableArray *modelList;
@property (strong, nonatomic) YHBPage *page;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation YHBProductListViewController

#pragma mark - getter and setter
- (YHBInfoListManager *)manager
{
    if (!_manager) {
        _manager = [YHBInfoListManager sharedManager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的产品";
    self.view.backgroundColor = kViewBackgroundColor;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20-44) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kViewBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];

    [self getFirstPageData];
    [self addTableViewTragWithTableView:self.tableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

#pragma mark 网络请求
- (void)getDataWithPageID:(NSInteger)pageid
{
    __weak YHBProductListViewController *weakself = self;
    [self.manager getProductListWithUserID:[YHBUser sharedYHBUser].userInfo.userid typeID:kAll pageID:pageid pageSize:kPageSize Success:^(NSMutableArray *modelArray, YHBPage *page) {
        weakself.page = page;
        if ((int)page.pageid == 1) {
            weakself.modelList = modelArray;
        }else if(weakself.modelList){
            [weakself.modelList addObjectsFromArray:modelArray];
        }
        [self.tableView reloadData];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"获取我的产品失败，请稍后重试!" cover:YES offsetY:0];
    }];
}

- (void)getFirstPageData
{
    [self getDataWithPageID:1];
}

#pragma mark 上拉下拉
- (void)addTableViewTragWithTableView:(UITableView *)tableView
{
    __weak YHBProductListViewController *weakself = self;
    __weak UITableView *weakTableView = tableView;
    [tableView addPullToRefreshWithActionHandler:^{
        int16_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakTableView.pullToRefreshView stopAnimating];
            [weakself getFirstPageData];
        });
    }];
    
    [tableView addInfiniteScrollingWithActionHandler:^{
        YHBPage *page = weakself.page;
        NSMutableArray *array = weakself.modelList;
        if (page && (int)page.pageid * kPageSize <= (int)page.pagetotal && array.count >= kPageSize) {
            int16_t delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [weakTableView.infiniteScrollingView stopAnimating];
                [weakself getDataWithPageID:(int)page.pageid+1];
            });
        }else [weakTableView.infiniteScrollingView stopAnimating];
    }];
}

#pragma mark 数据行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.modelList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kGoodsCellHeight;
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier4 = @"product";
    YHBProductListsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
    if (!cell) {
        cell = [[YHBProductListsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier4];
    }
    YHBRslist *list = self.modelList[indexPath.row];
    [cell setUIWithImage:list.thumb Title:list.title Price:[list.price doubleValue]];
    return cell;
}

#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YHBRslist *model = self.modelList[indexPath.row];
    YHBProductDetailVC *vc = [[YHBProductDetailVC alloc] initWithProductID:(NSInteger)model.itemid];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
