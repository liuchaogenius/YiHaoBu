//
//  YHBMyPrivateViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBMyPrivateViewController.h"
#import "YHBInfoListManager.h"
#import "YHBRslist.h"
#import "YHBORslist.h"
#import "YHBCRslist.h"
#import "YHBPage.h"
#import "SVProgressHUD.h"
#import "YHBUser.h"
#import "SVPullToRefresh.h"
#import "GoodsTableViewCell.h"
#import "YHBShopsListCell.h"
#import "YHBProductListsCell.h"
#import "YHBBuyDetailViewController.h"
#import "YHBSupplyDetailViewController.h"
#import "YHBProductDetailVC.h"
#import "YHBStoreViewController.h"
#define kSgmBtnHeight 35
#define kPageSize 30
#define kGoodsCellHeight 80

@interface YHBMyPrivateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    GetPrivateTag _selTag;
}
@property (strong, nonatomic) UIScrollView *sgmBtmScrollView;
@property (strong, nonatomic) UIButton *selectSgmButton;
@property (assign, nonatomic) NSInteger sgmCount;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) YHBInfoListManager *listManager;
@property (strong, nonatomic) NSMutableDictionary *modelsDic;//数据字典-存放数据模型数组 key为tag
@property (strong, nonatomic) NSMutableDictionary *pageDic;


@end

@implementation YHBMyPrivateViewController

#pragma mark getter and setter

- (NSMutableDictionary *)pageDic
{
    if (!_pageDic) {
        _pageDic = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return _pageDic;
}

- (NSMutableDictionary *)modelsDic
{
    if (!_modelsDic) {
        _modelsDic = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return _modelsDic;
}

- (YHBInfoListManager *)listManager
{
    if (!_listManager) {
        _listManager = [[YHBInfoListManager alloc] init];
    }
    return _listManager;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.sgmBtmScrollView.bottom, kMainScreenWidth, kMainScreenHeight-49-self.sgmBtmScrollView.bottom) style:UITableViewStylePlain];
        _tableView.backgroundColor = kViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.estimatedRowHeight = kGoodsCellHeight;
    }
    return _tableView;
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"求购",@"供应",@"产品",@"商城"];
    }
    return _titleArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self.view addSubview:self.sgmBtmScrollView];
    _selTag = Get_Sell;
    self.view.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:self.tableView];
    [self setExtraCellLineHidden:self.tableView];
    [self getFirstPageData];
    [self addTableViewTragWithTableView:self.tableView];
}

#pragma mark 网络请求
- (void)getDataWithPageID:(NSInteger)pageid
{
    GetPrivateTag tag = _selTag;
    [self.listManager getMyFavoriteWithToken:[YHBUser sharedYHBUser].token?:@"" Action:tag PageID:pageid pageSize:kPageSize Success:^(NSMutableArray *modelArray, YHBPage *page) {
        [self.pageDic setObject:page forKey:[NSString stringWithFormat:@"%lu",(unsigned long)tag]];
        if (pageid == 1) {
            [self.modelsDic setObject:modelArray forKey:[NSString stringWithFormat:@"%lu",tag]];
        }else{
            NSMutableArray *array = self.modelsDic[[NSString stringWithFormat:@"%lu",tag]];
            [array addObjectsFromArray:modelArray];
        }
        [self.tableView reloadData];
        MLOG(@"%@",self.modelsDic);
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"获取收藏列表失败，请稍后再试！" cover:YES offsetY:0];
    }];
}

- (void)getFirstPageData
{
    [self getDataWithPageID:1];
}

#pragma mark 上拉下拉
- (void)addTableViewTragWithTableView:(UITableView *)tableView
{
    __weak YHBMyPrivateViewController *weakself = self;
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
        YHBPage *page = weakself.pageDic[[NSString stringWithFormat:@"%ld",_selTag]];
        NSMutableArray *array = weakself.modelsDic[[NSString stringWithFormat:@"%ld",_selTag]];
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

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark 数据行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSArray *modelArray = self.modelsDic[[NSString stringWithFormat:@"%lu",_selTag]];
    return modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kGoodsCellHeight;
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSMutableArray *dataArray = self.modelsDic[[NSString stringWithFormat:@"%lu",_selTag]];
        switch (_selTag) {
            case Get_Buy:
            {
                static NSString *cellIdentifier1 = @"Buy";
                GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
                if (!cell) {
                    cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
                }
                YHBSupplyModel *list = dataArray[indexPath.row];
                [cell setCellWithModel:list];
                return cell;
            }
                break;
            case Get_Sell:
            {
                static NSString *cellIdentifier2 = @"Sell";
                GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
                if (!cell) {
                    cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
                }
                YHBSupplyModel *list = dataArray[indexPath.row];
                [cell setCellWithModel:list];
                return cell;
            }
                break;
            case Get_Company:
            {
                static NSString *cellIdentifier3 = @"mall";
                YHBShopsListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
                if (!cell) {
                    cell = [[YHBShopsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3];
                }
                YHBCRslist *list = dataArray[indexPath.row];
                [cell setUIWithImage:list.avatar title:list.company Name:list.truename GroupID:(int)list.groupid];
                return cell;
            }
                break;
            case Get_Product:
            {
                static NSString *cellIdentifier4 = @"product";
                YHBProductListsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
                if (!cell) {
                    cell = [[YHBProductListsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier4];
                }
                YHBRslist *list = dataArray[indexPath.row];
                [cell setUIWithImage:list.thumb Title:list.title Price:[list.price doubleValue]];
                return cell;
            }
                break;
            default:
                return nil;
                break;

        }
}

#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        NSMutableArray *modelArray = self.modelsDic[[NSString stringWithFormat:@"%lu", _selTag]];
        if (modelArray.count > indexPath.row) {
            YHBRslist *model = modelArray[indexPath.row];
            switch (_selTag) {
                case Get_Buy:
                {
                    //求购
                    YHBBuyDetailViewController *vc = [[YHBBuyDetailViewController alloc] initWithItemId:((YHBSupplyModel *)model).itemid andIsMine:NO isModal:NO];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case Get_Sell:
                {
                    //供应
                    YHBSupplyDetailViewController *vc = [[YHBSupplyDetailViewController alloc] initWithItemId:((YHBSupplyModel *)model).itemid andIsMine:NO isModal:NO];
                    vc.hidesBottomBarWhenPushed  = YES;
                    vc.navigationController.navigationBar.hidden = NO;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case Get_Company:
                {
                    //店铺
                    YHBStoreViewController *vc = [[YHBStoreViewController alloc] initWithShopID:(int)((YHBCRslist *)model).userid];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.navigationController.navigationBar.hidden = NO;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case Get_Product:
                {
                    //产品
                    YHBProductDetailVC *vc = [[YHBProductDetailVC alloc] initWithProductID:(NSInteger)model.itemid];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                default:
                    break;
            }
        }
    }
    
    
}



#pragma mark - action
- (void)touchSgmButton:(UIButton *)sender
{
    if (sender != _selectSgmButton) {
        if (_selectSgmButton) {
            _selectSgmButton.selected = NO;
            _selectSgmButton = sender;
            _selectSgmButton.selected = YES;
            _selTag = sender.tag;
            NSArray *array;
            [self.tableView setContentOffset:CGPointMake(0, 0)];
            if ((array = self.modelsDic[[NSString stringWithFormat:@"%lu",_selTag]]) != nil) {
                
                [self.tableView reloadData];
            }else{
                [self getFirstPageData];
            }
        }
        
        
    }
}




- (UIScrollView *)sgmBtmScrollView
{
    if (!_sgmBtmScrollView) {
        _sgmBtmScrollView = [[UIScrollView alloc] init];
        self.sgmCount = self.titleArray.count;
        _sgmBtmScrollView.layer.borderColor = [RGBCOLOR(207, 207, 207) CGColor];
        _sgmBtmScrollView.layer.borderWidth = 0.7f;
        _sgmBtmScrollView.layer.masksToBounds = YES;
        _sgmBtmScrollView.showsHorizontalScrollIndicator = NO;
        [_sgmBtmScrollView setFrame:CGRectMake(0, 0, kMainScreenWidth, kSgmBtnHeight)];
        _sgmBtmScrollView.backgroundColor = RGBCOLOR(245, 245, 245);
        //通过分栏数量调整content宽度
        CGFloat contentWidth = (self.sgmCount > 5 ? self.sgmCount*kMainScreenWidth/5.0f : kMainScreenWidth);
        [_sgmBtmScrollView setContentSize:CGSizeMake(contentWidth, kSgmBtnHeight)];
        
        //添加sgmButton
        CGFloat buttonWidth = (self.sgmCount>=5 ? kMainScreenWidth/5.0f : kMainScreenWidth/(float)self.sgmCount);
        for (int i = 0; i < self.sgmCount; i++) {
            UIButton *sgmButton = [self customButtonWithFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, kSgmBtnHeight) andTitle:self.titleArray[i]];
            sgmButton.tag = i ;
            if (i == 0) {
                sgmButton.selected = YES; //默认选择第一个
                self.selectSgmButton = sgmButton;
                _selTag = 0;
            }
            [_sgmBtmScrollView addSubview:sgmButton];
        }
        
    }
    return _sgmBtmScrollView;
}

- (UIButton *)customButtonWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:KColor forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    button.titleLabel.font = kFont14;
    //button.layer.borderWidth = 0.7f;
    //button.layer.borderColor = [RGBCOLOR(207, 207, 207) CGColor];
    button.selected = NO;
    [button addTarget:self action:@selector(touchSgmButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
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
