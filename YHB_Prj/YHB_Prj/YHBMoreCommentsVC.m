//
//  YHBMoreCommentsVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBMoreCommentsVC.h"
#import "YHBCommentCellView.h"
#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"
#import "YHBCommentManager.h"
#import "YHBUser.h"
#import "YHBComment.h"
#define kCellViewTag 100
@interface YHBMoreCommentsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) YHBCommentManager *commentManager;
@property (assign, nonatomic) NSInteger itemID;
@property (strong, nonatomic) NSMutableArray *modelArray;

@end

@implementation YHBMoreCommentsVC

#pragma getter and setter
- (YHBCommentManager *)commentManager
{
    if (!_commentManager) {
        _commentManager = [[YHBCommentManager alloc] init];
    }
    return _commentManager;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20-44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kViewBackgroundColor;
        _tableView.rowHeight = kCommentCellHeight;
    }
    return _tableView;
}

- (instancetype)initWithItemID:(NSInteger)itemId
{
    self = [super init];
    if (self) {
        self.itemID = -1;
        self.itemID = itemId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UI
    [self settitleLabel:@"更多评论"];
    [self.view addSubview:self.tableView];
    [self addTableViewTragWithTableView:self.tableView];
    [self setExtraCellLineHidden:self.tableView];
    
    [self getFirstPage];
    
}

#pragma mark 网络请求
- (void)getFirstPage
{
    __weak YHBMoreCommentsVC *weakself = self;
    [self.commentManager getCommentListWithItemID:self.itemID token:[YHBUser sharedYHBUser].token Success:^(NSMutableArray *modelArray) {
        weakself.modelArray = modelArray;
        [weakself.tableView reloadData];
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"获取数据失败，请稍后再试！" cover:YES offsetY:0];
    }];
}

#pragma mark 上拉下拉
- (void)addTableViewTragWithTableView:(UITableView *)tableView
{
    __weak YHBMoreCommentsVC *weakself = self;
    __weak UITableView *weakTableView = tableView;
    [tableView addPullToRefreshWithActionHandler:^{
        int16_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakTableView.pullToRefreshView stopAnimating];
            [weakself getFirstPage];
        });
    }];
    /*
     [tableView addInfiniteScrollingWithActionHandler:^{
     
     YHBPage *page = weakself.pageDic[[NSString stringWithFormat:@"%ld",type-kSelectTagBase]];
     NSMutableArray *array = weakself.rslistDic[[NSString stringWithFormat:@"%ld",type-kSelectTagBase]];
     if (page && (int)page.pageid * kPageSize <= (int)page.pagetotal && array.count >= kPageSize) {
     int16_t delayInSeconds = 2.0;
     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
     dispatch_after(popTime, dispatch_get_main_queue(), ^{
     [weakTableView.infiniteScrollingView stopAnimating];
     [weakself getDataWithPageID:(int)page.pageid+1 andInfoListTypr:type];
     });
     }else [weakTableView.infiniteScrollingView stopAnimating];
     }];*/
}

#pragma mark - 数据源方法
#pragma mark 数据行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        YHBCommentCellView *view = [[YHBCommentCellView alloc] init];
        [cell.contentView addSubview:view];
        view.tag = kCellViewTag;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    YHBCommentCellView *view = (YHBCommentCellView *)[cell viewWithTag:kCellViewTag];
    YHBComment *comment = self.modelArray[indexPath.row];
    [view setUIWithName:comment.truename image:comment.avatar comment:comment.comment date:comment.adddate];
    
    return cell;
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
