//
//  YHBShopMallViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/18.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShopMallViewController.h"
#import "YHBBannerVeiw.h"
#import "YHBShopMallHeadView.h"
#import "YHBShopMallCell.h"
#import "YHBStoreViewController.h"
#import "YHBShopIndexManager.h"
#import "YHBCompanyIndex.h"
#import "YHBMalllist.h"
#import "YHBHotlist.h"
#import "YHBSlidelist.h"
#import "YHBShoplist.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "IntroduceViewController.h"
#import "YHBSerchCell.h"
#import "YHBShopMallCell.h"
#import "YHBShopListsCell.h"
#import "YHBProductDetailVC.h"
#import "SecondViewController.h"

#define kSearchTag 200
#define kBannerHeight (kMainScreenWidth * 397/1075.0f)

@interface YHBShopMallViewController ()<YHBBannerDelegate,UITableViewDelegate,UITableViewDataSource,ShopMallCellDelegate,YHBShopListCellDelegate,UITextFieldDelegate>

@property (strong, nonatomic) YHBBannerVeiw *bannerView;//顶部广告
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) YHBCompanyIndex *indexModel;
@property (strong, nonatomic) YHBShopIndexManager *indexManager;
@property (strong, nonatomic) YHBSerchCell *searchCell;
@property (strong, nonatomic) NSMutableArray *headersArray;

@end

@implementation YHBShopMallViewController

#pragma mark - getter and setter
- (NSMutableArray *)headersArray
{
    if (!_headersArray) {
        _headersArray = [NSMutableArray arrayWithCapacity:3];
        YHBShopMallHeadView *sellhead = [[YHBShopMallHeadView alloc] init];
        sellhead.imageView.image = [UIImage imageNamed:@"clockL"];
        sellhead.rightTitle = @"促销产品";
        _headersArray[0] = sellhead;
        
        YHBShopMallHeadView *shopHead = [[YHBShopMallHeadView alloc] init];
        shopHead.title = @"推荐店铺";
        _headersArray[1] = shopHead;
        
        YHBShopMallHeadView *productHead = [[YHBShopMallHeadView alloc] init];
        productHead.title = @"产品推荐";
        _headersArray[2] = productHead;
    }
    return _headersArray;
}

- (YHBSerchCell *)searchCell
{
    if (!_searchCell) {
        _searchCell = [[YHBSerchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchCell"];
        _searchCell.textFiled.tag = kSearchTag;
        _searchCell.textFiled.delegate = self;
    }
    return _searchCell;
}

- (YHBShopIndexManager *)indexManager
{
    if (!_indexManager) {
        _indexManager = [[YHBShopIndexManager alloc] init];
    }
    return _indexManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商城";
    
    //UI
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.bannerView = [[YHBBannerVeiw alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kBannerHeight)];
    self.bannerView.delegate = self;
    self.tableView.tableHeaderView = self.bannerView;
    [self setExtraCellLineHidden:self.tableView]; //隐藏多需的cell线

    //网络请求 刷新数据
    __weak YHBShopMallViewController *weakself = self;
    [self.indexManager getCompanyIndexWithSuccess:^(YHBCompanyIndex *model) {
        weakself.indexModel = model;
        [weakself refreshAddView];
        [weakself.tableView reloadData];
    } failure:^(int result, NSString *errorString) {
        [SVProgressHUD showErrorWithStatus:errorString cover:NO offsetY:0];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.navigationController.navigationBar.hidden) {
        self.navigationController.navigationBarHidden = NO;
    }
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

#pragma mark - tableView delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){//促销产品
        return self.indexModel.hotlist.count/3 + self.indexModel.hotlist.count%3 ? 1 : 0;
    }else if (section == 2){//推荐店铺
        return self.indexModel.shoplist.count ? 1:0;
    }else if (section == 3){//产品推荐
        return self.indexModel.malllist.count/3 + self.indexModel.malllist.count%3 ? 1 : 0;
    }
    else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else return kHeadViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kSearchCellHeight;
    }else if (indexPath.section == 2){//推荐店铺
        return self.indexModel.shoplist.count ? 5+((self.indexModel.shoplist.count-1)/4 + 1)*(kslBlankWidth + kslImgHeight) : 0;
    }
    else return kcellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else{
        return self.headersArray[section-1];
    }
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *productCellidentifier = @"product";
    switch (indexPath.section) {
        case 0://搜索栏
        {
            return self.searchCell;
        }
            break;
        case 1://促销产品
        {
            YHBShopMallCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellidentifier];
            if (!cell) {
                cell = [[YHBShopMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellidentifier andType:0];
                cell.delegate = self;
            }
            [cell clearCellContentParts];
            YHBHotlist *list;
            for (int i=0; i < 3; i ++) {
                //设置cell左中右三部分ui内容
                if (indexPath.row*3+i < self.indexModel.hotlist.count) {
                    list = self.indexModel.hotlist[indexPath.row*3+i];
                    [cell setImage:list.thumb title:list.title price:list.price part:i];
                }else [cell setImage:nil title:@"" price:nil part:i];
            }
            cell.cellIndexPath = indexPath;
            return cell;
        }
        case 2:
        {
            //推荐店铺
            static NSString *shopCellIdentifier = @"shop";
            YHBShopListsCell *cell = [tableView dequeueReusableCellWithIdentifier:shopCellIdentifier];
            if (!cell) {
                cell = [[YHBShopListsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopCellIdentifier];
            }
            cell.delegate = self;
            //cell.contentView.backgroundColor = [UIColor grayColor];
            [cell clearImageButtons];
            [cell setCellWithShopListArray:self.indexModel.shoplist];
            return cell;
        }
        case 3:
        {
            YHBShopMallCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellidentifier];
            if (!cell) {
                cell = [[YHBShopMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellidentifier andType:0];
                cell.delegate = self;
            }
            [cell clearCellContentParts];
            YHBMalllist *list;
            for (int i=0; i < 3; i ++) {
                //设置cell左中右三部分ui内容
                if (indexPath.row*3+i < self.indexModel.malllist.count) {
                    list = self.indexModel.malllist[indexPath.row*3+i];
                    [cell setImage:list.thumb title:list.title price:list.price part:i];
                }else [cell setBlankWithPart:i];
            }
            cell.cellIndexPath = indexPath;
            return cell;
        }
        default:
            return nil;
    }
    
    
}

//载入banners的网络数据
- (void)refreshAddView
{
    NSInteger imageNum = self.indexModel.slidelist.count;

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:imageNum];
    for (NSInteger i = 0; i < imageNum; i++) {
        YHBSlidelist *slide = self.indexModel.slidelist[i];
        //设置image
        array[i] = slide.thumb;
    }
    self.bannerView.isNeedCycle = YES;
    [self.bannerView resetUIWithUrlStrArray:[NSArray arrayWithArray:array]];
}


#pragma mark - Action
#pragma mark 点击店铺/商品
- (void)selectCellPartWithIndexPath:(NSIndexPath *)indexPath part:(NSInteger)part
{
    //MLOG(@"section:%ld row:%ld part:%ld",(long)indexPath.section,(long)indexPath.row,(long)part);
    if (indexPath.section == 1) {
        //促销产品
        YHBHotlist *hot = self.indexModel.hotlist[indexPath.row * 3 + part];
        YHBProductDetailVC *vc = [[YHBProductDetailVC alloc] initWithProductID:(NSInteger)hot.itemid];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 3){
        //产品推荐
        YHBMalllist *mall  = self.indexModel.malllist[indexPath.row * 3 + part];
        YHBProductDetailVC *vc = [[YHBProductDetailVC alloc] initWithProductID:(NSInteger)mall.itemid];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 点击推荐店铺
- (void)touchShopWithTag:(NSInteger)tag
{
    if (self.indexModel.shoplist.count > tag) {
        YHBShoplist *shop = self.indexModel.shoplist[tag];
        YHBStoreViewController *storeVC = [[YHBStoreViewController alloc] initWithShopID:(int)shop.itemid];
        storeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:storeVC animated:YES];
    }
}

#pragma mark 点击head的Banner 广告
- (void)touchBannerWithNum:(NSInteger)num;
{
    if (num < self.indexModel.slidelist.count) {
        YHBSlidelist *slideModel = self.indexModel.slidelist[num];
        if (slideModel.linkurl.length > 1) {
            IntroduceViewController *iVC = [[IntroduceViewController alloc] init];
            [self presentViewController:iVC animated:YES completion:^{
                
            }];
            /*
             iVC.isSysPush = YES;
             iVC.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:iVC animated:YES];
             */
            [iVC setUrl:slideModel.linkurl title:@""];
        }
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    if (textField.tag == kSearchTag) {
        SecondViewController *vc = [[SecondViewController alloc] initFromMall];
        [self.navigationController pushViewController:vc animated:YES];
        
        return NO;
    }
    return YES;
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
