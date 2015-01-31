//
//  PriceDetailViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/22.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "PriceDetailViewController.h"
#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"
#import "QuoteDetailManage.h"
#import "PriceDetailTableViewCell.h"
#import "PriceDetailRslist.h"
#import "PriceDetailContactView.h"
#import "ChatViewController.h"
#import "YHBStoreDetailViewController.h"

#define kContactViewHeight 60
@interface PriceDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    int myItemid;
    QuoteDetailManage *netManage;
    PriceDetailRslist *myModel;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *tableViewArray;
@end

@implementation PriceDetailViewController

- (instancetype)initWithItemid:(int)aItemid
{
    if (self = [super init]) {
        myItemid = aItemid;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"查看报价";
    self.tableViewArray = [NSMutableArray new];
#pragma mark tableview
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    netManage = [[QuoteDetailManage alloc] init];
    [self addTableViewTrag];
    [self showFlower];
    
    [self getFirstData];
}

- (void)getFirstData
{
    [netManage getQuoteDetailForItemid:myItemid succBlock:^(NSMutableArray *aArray) {
        [self dismissFlower];
        self.tableViewArray = aArray;
        [self.tableView reloadData];
    } andFail:^(NSString *aStr){
        [self dismissFlower];
        [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
    }];
}


#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak PriceDetailViewController *weakself = self;
    [weakself.tableView addPullToRefreshWithActionHandler:^{

        [netManage getQuoteDetailForItemid:myItemid succBlock:^(NSMutableArray *aArray) {
            [weakself.tableView.pullToRefreshView stopAnimating];
            self.tableViewArray = aArray;
            [self.tableView reloadData];
        } andFail:^(NSString *aStr){
            [weakself.tableView.pullToRefreshView stopAnimating];
            [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
        }];
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
            } andFail:^(NSString *aStr){
                [weakself.tableView.infiniteScrollingView stopAnimating];
                [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
            }];
        }
        else
        {
            [weakself.tableView.infiniteScrollingView stopAnimating];
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
    PriceDetailRslist *model = [self.tableViewArray objectAtIndex:indexPath.row];
    if (model.note)
    {
        return 95;
    }
    else
    {
        return 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    PriceDetailTableViewCell *cell = [[PriceDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    PriceDetailRslist *model = [self.tableViewArray objectAtIndex:indexPath.row];
    [cell setCellWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PriceDetailRslist *model = [self.tableViewArray objectAtIndex:indexPath.row];
    myModel = model;
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    maskView.tag = 1000;
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha=0.7;
    maskView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeMaskView)];
    [maskView addGestureRecognizer:tapGesture];
    [[[UIApplication sharedApplication] keyWindow] addSubview:maskView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, kMainScreenHeight/2.0-45, kMainScreenWidth-20, 95)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.tag = 10000;
    backView.layer.cornerRadius = 5;
    [[[UIApplication sharedApplication] keyWindow] addSubview:backView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth-20, 35)];
    topView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapStore = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toStore)];
    [topView addGestureRecognizer:tapStore];
    [backView addSubview:topView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, kMainScreenWidth-100, 17)];
    nameLabel.font = kFont15;
    nameLabel.text = model.company;
    [topView addSubview:nameLabel];
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-20-20, 10, 9, 15)];
    arrowImg.image = [UIImage imageNamed:@"arrowRight"];
    [topView addSubview:arrowImg];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 34.5, kMainScreenWidth-20, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:lineView];
    
    PriceDetailContactView *contactView = [[PriceDetailContactView alloc] initWithFrame:CGRectMake(0, 35, kMainScreenWidth-20, 60) andBlock:^{
        [self removeMaskView];
    }];
    contactView.layer.cornerRadius=10;
    [contactView.fourthView addTarget:self action:@selector(chatWithItemid:) forControlEvents:UIControlEventTouchUpInside];
    [contactView setPhoneNumber:model.mobile storeName:model.company itemId:myItemid];
    [backView addSubview:contactView];
}

- (void)toStore
{
    [self removeMaskView];
    YHBStoreDetailViewController *vc = [[YHBStoreDetailViewController alloc] initWithItemID:(int)myModel.userid];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeMaskView
{
    UIView *view = [[[UIApplication sharedApplication] keyWindow] viewWithTag:1000];
    [view removeSubviews];
    [view removeFromSuperview];
    UIView *view1 = [[[UIApplication sharedApplication] keyWindow] viewWithTag:10000];
    [view1 removeSubviews];
    [view1 removeFromSuperview];
}

- (void)chatWithItemid:(NSString *)aItemid
{
    MLOG(@"在线沟通");
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager registerNewAccount:@"8001" password:@"111111" error:&error];
    if (isSuccess && !isSuccess) {
        NSLog(@"注册成功");
    }
    NSDictionary *loginInfo = [[EaseMob sharedInstance].chatManager loginWithUsername:@"8001" password:@"111111" error:&error];
    if (!error && loginInfo) {
        NSLog(@"登陆成功");
    }
    NSString *userName = @"123";
    ChatViewController *vc = [[ChatViewController alloc] initWithChatter:userName isGroup:NO];
    vc.title = userName;
    [self removeMaskView];
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
