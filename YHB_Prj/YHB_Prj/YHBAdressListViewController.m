//
//  YHBAdressListViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/23.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBAdressListViewController.h"
#import "YHBAddressModel.h"
#import "YHBAddressManager.h"
#import "SVProgressHUD.h"
#import "YHBAddressListsCell.h"
#import "YHBUser.h"
#import "YHBAddressEditViewController.h"

typedef enum : NSUInteger {
    action_edit = 0,
    action_default,
    action_deleate ,
    action_cancelOrChoose,
} ActionSheet_Action;

@interface YHBAdressListViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    YHBAddressModel *_selModel;
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *modelArray;
@property (strong, nonatomic) YHBAddressManager *addManager;

@end

@implementation YHBAdressListViewController
#pragma mark - getter and setter
- (YHBAddressManager *)addManager
{
    if (!_addManager) {
        _addManager = [[YHBAddressManager alloc] init];
    }
    return _addManager;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20-44) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBCOLOR(231, 231, 231);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selModel = nil;
    self.title = @"收货地址";
    [self setRightButton:nil title:@"添加" target:self action:@selector(addAddress)];
    //UI
    self.view.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:self.tableView];
    
   
    [self getOrRefreshDataWithIsNeedTips:YES];
    
}
//重新获取数据，并刷新UI
- (void)getOrRefreshDataWithIsNeedTips:(BOOL)isNeed
{
    if(isNeed)[SVProgressHUD showWithStatus:@"拼命加载中..." cover:YES offsetY:0];
    self.modelArray = nil;
    [self.addManager getAddresslistWithToken:([YHBUser sharedYHBUser].token ? :@"") WithSuccess:^(NSMutableArray *modelList) {
        if(isNeed) [SVProgressHUD dismiss];
        self.modelArray = modelList;
        [self.tableView reloadData];
    } failure:^(NSString *error) {
        if(isNeed) [SVProgressHUD dismissWithError:error];
    }];
}

#pragma mark - 数据源方法

#pragma mark 数据行数
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.modelArray ? 1:0);
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    YHBAddressListsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[YHBAddressListsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    YHBAddressModel *model = self.modelArray[indexPath.section];
    [cell setUIWithName:model.truename?:@"" Phone:model.mobile?:@"" address:model.address?:@"" isMain:((int)model.ismain?YES:NO)];
    
    return cell;
}

#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YHBAddressModel *model = self.modelArray[indexPath.section];
    _selModel = model;
    if (self.isfromOrder) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请问想怎么操作这条地址" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"查看或修改"otherButtonTitles:@"设为默认地址",@"删除",@"设为收货地址", nil];
        [actionSheet showInView:self.view];
    }else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请问想怎么操作这条地址" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"查看或修改" otherButtonTitles:@"设为默认地址",@"删除", nil];
        [actionSheet showInView:self.view];
    }
    
}

#pragma mark - Action
- (void)addAddress
{
    YHBAddressEditViewController *vc = [[YHBAddressEditViewController alloc] initWithAddressModel:nil isNew:YES SuccessHandle:^{
        [self getOrRefreshDataWithIsNeedTips:NO];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - avtionsheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak YHBAdressListViewController *weakself = self;
    switch (buttonIndex) {
        case action_deleate:
        {
            [self.addManager deleteAddressWithToken:[YHBUser sharedYHBUser].token?:@"" AndItemID:(int)_selModel.itemid WithSuccess:^{
                [weakself getOrRefreshDataWithIsNeedTips:NO];
            } failure:^(NSString *error) {
                [SVProgressHUD showErrorWithStatus:error cover:YES offsetY:0];
            }];
        }
            break;
        case action_edit:
        {
            YHBAddressEditViewController *vc = [[YHBAddressEditViewController alloc] initWithAddressModel:_selModel isNew:NO SuccessHandle:^{
                [weakself getOrRefreshDataWithIsNeedTips:NO];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case action_default:
        {
            _selModel.ismain = 1;
            [self.addManager addOrEditAddressWithAddModel:_selModel Token:[YHBUser sharedYHBUser].token?:@"" isNew:NO WithSuccess:^{
                [SVProgressHUD showSuccessWithStatus:@"修改默认收货地址成功！" cover:YES offsetY:0];
                [weakself getOrRefreshDataWithIsNeedTips:NO];
            } failure:^(NSString *error) {
                [SVProgressHUD showSuccessWithStatus:error cover:YES offsetY:0];
            }];
        }
            break;
        case action_cancelOrChoose:
        {
            if (self.isfromOrder && [self.delegate respondsToSelector:@selector(choosedAddressModel:)]) {
                [self.delegate choosedAddressModel:_selModel];
            }
        }
            break;
            break;
        default:
            break;
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
