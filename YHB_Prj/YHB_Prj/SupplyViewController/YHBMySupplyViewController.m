//
//  YHBMySupplyViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/26.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBMySupplyViewController.h"
#import "DAContextMenuCell.h"
#import "SVPullToRefresh.h"
#import "SVProgressHUD.h"
#import "YHBSupplyModel.h"
#import "YHBSupplyDetailViewController.h"
#import "YHBBuyDetailViewController.h"
#import "YHBPublishSupplyViewController.h"
#import "YHBPublishBuyViewController.h"
#import "YHBMySupplyManage.h"
#import "DAOverlayView.h"
#import "YHBPostSell.h"
#import "LSNavigationController.h"

#define topViewHeight 40

@interface YHBMySupplyViewController ()<UITableViewDataSource, UITableViewDelegate,DAContextMenuCellDelegate,DAOverlayViewDelegate,UIAlertViewDelegate>
{
    BOOL isSupply;
    YHBMySupplyManage *manage;
    BOOL isFind;
    UIView *underLine;
    
    int userId;
    YHBPostSell *postManage;
    int selRow;
}

@property(nonatomic, strong) UITableView *supplyTableView;
@property(nonatomic, strong) NSMutableArray *tableViewArray;
@property(nonatomic, strong) UIButton *selectAllBtn;
@property(nonatomic, strong) UIButton *selectVipBtn;
@property (assign, nonatomic) BOOL customEditing;
@property (assign, nonatomic) BOOL customEditingAnimationInProgress;
@property (strong, nonatomic) DAContextMenuCell *cellDisplayingMenuOptions;
@property (strong, nonatomic) DAOverlayView *overlayView;
@end

@implementation YHBMySupplyViewController

- (instancetype)initWithIsSupply:(BOOL)aIsSupply
{
    if (self = [super init]) {
        isSupply = aIsSupply;
    }
    return self;
}

- (instancetype)initWithUserid:(int)aUserid
{
    if (self = [super init]) {
        isSupply = NO;
        userId = aUserid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customEditing = self.customEditingAnimationInProgress = NO;
    if (isSupply)
    {
        self.title = @"我的供应";
        self.supplyTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    }
    else
    {
        if (userId>0)
        {
            self.title = @"他的采购";
        }
        else
        {
            self.title = @"我的采购";
        }
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
        
        self.supplyTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        self.supplyTableView.tableHeaderView = topView;
    }
    
    if (userId>0)
    {
        
    }
    else
    {
        [self setRightButton:nil title:@"添加+" target:self action:@selector(addSupply)];
    }
#pragma mark 建立tableview
    self.supplyTableView.delegate = self;
    self.supplyTableView.dataSource = self;
    self.supplyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.supplyTableView];
    
    [self addTableViewTrag];
    [self showFlower];
    
    manage = [[YHBMySupplyManage alloc] init];
    [self getFirstDataWithIsSupply:isSupply andIsFind:isFind];
    
    postManage = [[YHBPostSell alloc] init];
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
    } isSupply:isSupply isFind:isFind userid:userId];
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
        } isSupply:isSupply isFind:isFind userid:userId];
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
        [self presentViewController:[[LSNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
            
        }];
    }
    else
    {
        YHBPublishBuyViewController *vc = [[YHBPublishBuyViewController alloc] init];
        [self presentViewController:[[LSNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
            
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
    return [DAContextMenuCell returnCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[DAContextMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (!userId>0)
    {
        cell.delegate = self;
    }
    if (isSupply)
    {
        cell.moreOptionsButtonTitle = @"刷新";
    }
    else
    {
        cell.moreOptionsButtonTitle = @"状态";
    }
    cell.row = (int)indexPath.row;
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
        BOOL isMine = userId>0?NO:YES;
        YHBBuyDetailViewController *vc = [[YHBBuyDetailViewController alloc] initWithItemId:model.itemid andIsMine:isMine isModal:NO];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Private

- (void)hideMenuOptionsAnimated:(BOOL)animated
{
    __block YHBMySupplyViewController *weakSelf = self;
    [self.cellDisplayingMenuOptions setMenuOptionsViewHidden:YES animated:animated completionHandler:^{
        weakSelf.customEditing = NO;
    }];
}

- (void)setCustomEditing:(BOOL)customEditing
{
    if (_customEditing != customEditing) {
        _customEditing = customEditing;
        self.supplyTableView.scrollEnabled = !customEditing;
        if (customEditing) {
            if (!_overlayView) {
                _overlayView = [[DAOverlayView alloc] initWithFrame:self.view.bounds];
                _overlayView.backgroundColor = [UIColor clearColor];
                _overlayView.delegate = self;
            }
            self.overlayView.frame = self.view.bounds;
            [self.view addSubview:_overlayView];
            if (self.shouldDisableUserInteractionWhileEditing) {
                for (UIView *view in self.supplyTableView.subviews) {
                    if ((view.gestureRecognizers.count == 0) && view != self.cellDisplayingMenuOptions && view != self.overlayView) {
                        view.userInteractionEnabled = NO;
                    }
                }
            }
        } else {
            self.cellDisplayingMenuOptions = nil;
            [self.overlayView removeFromSuperview];
            for (UIView *view in self.supplyTableView.subviews) {
                if ((view.gestureRecognizers.count == 0) && view != self.cellDisplayingMenuOptions && view != self.overlayView) {
                    view.userInteractionEnabled = YES;
                }
            }
        }
    }
}

#pragma mark * DAContextMenuCell delegate

- (void)contextMenuCellDidSelectMoreOption:(DAContextMenuCell *)cell
{
//    NSAssert(NO, @"Should be implemented in subclasses");
    selRow = cell.row;
    YHBSupplyModel *model = [self.tableViewArray objectAtIndex:selRow];
    if (isSupply==YES)
    {
        [postManage postItemid:model.itemid action:@"refresh" typeid:0 succBlock:^{
            [SVProgressHUD showSuccessWithStatus:@"刷新成功" cover:YES offsetY:kMainScreenHeight/2.0];
            [self hideMenuOptionsAnimated:YES];
        } failBlock:^(NSString *aStr) {
            [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
        }];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"设置状态" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"寻找中",@"已找到", nil];
        [alertView show];
    }
    MLOG(@"more");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((isFind==NO&&buttonIndex==1) || (isFind==YES&&buttonIndex==0))
    {
        YHBSupplyModel *model = [self.tableViewArray objectAtIndex:selRow];
        [postManage postItemid:model.itemid action:@"type" typeid:(int)buttonIndex succBlock:^{
            [self.tableViewArray removeObjectAtIndex:selRow];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selRow inSection:0];
            [self.supplyTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationRight];
            [self.supplyTableView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"修改成功" cover:YES offsetY:kMainScreenHeight/2.0];
            self.customEditing = NO;
        } failBlock:^(NSString *aStr) {
            [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
        }];
    }
    else
    {
        [self hideMenuOptionsAnimated:YES];
    }
}

- (void)contextMenuCellDidSelectDeleteOption:(DAContextMenuCell *)cell
{
//    [cell.superview sendSubviewToBack:cell];
    selRow = cell.row;
    YHBSupplyModel *model = [self.tableViewArray objectAtIndex:selRow];
    [postManage deleteItemWithItemid:model.itemid andIsSupply:isSupply succBlock:^{
        [self.tableViewArray removeObjectAtIndex:selRow];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cell.row inSection:0];
        [self.supplyTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationRight];
        [self.supplyTableView reloadData];
        self.customEditing = NO;
        [SVProgressHUD showSuccessWithStatus:@"删除成功" cover:YES offsetY:kMainScreenHeight/2.0];
    } failBlock:^(NSString *aStr) {
        [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
    }];
    MLOG(@"delete");
}

- (void)contextMenuDidHideInCell:(DAContextMenuCell *)cell
{
    self.customEditing = NO;
    self.customEditingAnimationInProgress = NO;
}

- (void)contextMenuDidShowInCell:(DAContextMenuCell *)cell
{
    self.cellDisplayingMenuOptions = cell;
    self.customEditing = YES;
    self.customEditingAnimationInProgress = NO;
}

- (void)contextMenuWillHideInCell:(DAContextMenuCell *)cell
{
    self.customEditingAnimationInProgress = YES;
}

- (void)contextMenuWillShowInCell:(DAContextMenuCell *)cell
{
    self.customEditingAnimationInProgress = YES;
}

- (BOOL)shouldShowMenuOptionsViewInCell:(DAContextMenuCell *)cell
{
    return self.customEditing && !self.customEditingAnimationInProgress;
}

#pragma mark * DAOverlayView delegate

- (UIView *)overlayView:(DAOverlayView *)view didHitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL shouldIterceptTouches = YES;
    CGPoint location = [self.supplyTableView convertPoint:point fromView:view];
    CGRect rect = [self.supplyTableView convertRect:self.cellDisplayingMenuOptions.frame toView:self.supplyTableView];
    shouldIterceptTouches = CGRectContainsPoint(rect, location);
    if (!shouldIterceptTouches) {
        [self hideMenuOptionsAnimated:YES];
    }
    return (shouldIterceptTouches) ? [self.cellDisplayingMenuOptions hitTest:point withEvent:event] : view;
}

#pragma mark * UITableView delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView cellForRowAtIndexPath:indexPath] == self.cellDisplayingMenuOptions) {
        [self hideMenuOptionsAnimated:YES];
        return NO;
    }
    return YES;
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
