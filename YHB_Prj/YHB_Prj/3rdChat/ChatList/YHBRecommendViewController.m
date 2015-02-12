//
//  YHBRecommendViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/29.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBRecommendViewController.h"
#import "SVPullToRefresh.h"
#import "YHBGetPushBuylist.h"
#import "YHBDataService.h"
#import "RecommendTableViewCell.h"
#import "YHBBuyDetailViewController.h"

@interface YHBRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation YHBRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"商机推荐"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    YHBDataService *dataService = [YHBDataService sharedYHBDataSevice];
    NSArray *buylist = [dataService getBuylist];
    NSArray *resultList = [NSArray new];
    if (buylist.count>20)
    {
        NSRange range = NSMakeRange(0, 20);
        resultList = [buylist subarrayWithRange:range];
    }
    else
    {
        resultList = buylist;
    }
    self.dataSource = [resultList mutableCopy];
    
    [self addTableViewTrag];
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak YHBRecommendViewController *weakself = self;
//    [weakself.tableView addPullToRefreshWithActionHandler:^{
////                [weakself.tableView.pullToRefreshView stopAnimating];
// 
//        
//    }];
    
    
    [weakself.tableView addInfiniteScrollingWithActionHandler:^{
        if(self.dataSource.count%20==0&&self.dataSource.count>0)
        {
            YHBDataService *dataService = [YHBDataService sharedYHBDataSevice];
            NSArray *buylist = [dataService getBuylist];
            if (buylist.count>self.dataSource.count)
            {
                [weakself.tableView.infiniteScrollingView stopAnimating];
                int count = (int)self.dataSource.count;
                if (buylist.count>self.dataSource.count+20)
                {
                    self.dataSource = [[buylist subarrayWithRange:NSMakeRange(0, count+20)] mutableCopy];
                }
                else
                {
                    NSArray *resultList = [NSArray new];
                    NSRange range = NSMakeRange(count-1, buylist.count-count);
                    resultList = [buylist subarrayWithRange:range];
                    [self.dataSource addObjectsFromArray:resultList];
                }
                [self.tableView reloadData];
            }
            else
            {
                [weakself.tableView.infiniteScrollingView stopAnimating];
            }
        }
        else
        {
            [weakself.tableView.infiniteScrollingView stopAnimating];
        }

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RecommendTableViewCell tableView:self.tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<self.dataSource.count)
    {
        static NSString *cellIdentifer = @"cell";
        RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
        if (!cell) {
            cell = [[RecommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        }
        YHBGetPushBuylist *model = [self.dataSource objectAtIndex:indexPath.row];
        [cell setCellWithModel:model];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHBGetPushBuylist *model = [self.dataSource objectAtIndex:indexPath.row];
    if ([model.isread isEqualToString:@"NO"])
    {
        model.isread = @"YES";
        [[YHBDataService sharedYHBDataSevice] saveChangedBuyList:self.dataSource];
    }
    RecommendTableViewCell *cell = (RecommendTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell hideRedView];
    YHBBuyDetailViewController *vc = [[YHBBuyDetailViewController alloc] initWithItemId:(int)model.itemid andIsMine:NO isModal:NO];
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
