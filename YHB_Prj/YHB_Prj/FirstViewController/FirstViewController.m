//
//  FirstViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 14-11-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "FirstViewController.h"
#import "YHBShopMallViewController.h"
#import "YHBPublishSupplyViewController.h"
#import "YHBPublishBuyViewController.h"
#import "YHBLookSupplyViewController.h"
#import "YHBFirstPageIndex.h"
#import "YHBMalllist.h"
#import "YHBSelllist.h"
#import "YHBSlidelist.h"
#import "YHBShopIndexManager.h"
#import "YHBBannerVeiw.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "IntroduceViewController.h"
#import "YHBFunctionCell.h"
#import "YHBFuncBlockCell.h"
#import "YHBHotTagsCell.h"
#import "YHBShopMallCell.h"
#import "YHBProductDetailVC.h"
#import "YHBUser.h"
#import "YHBOrderListViewController.h"
#import "YHBBuyDetailViewController.h"
#import "CategoryViewController.h"
#import "YHBCatSubcate.h"

#define kBannerHeight (kMainScreenWidth * 397/1080.0f)
#define kFuncCellHeight 80
#define kFooterHeigt 14
#define kFuncBlockCellHeight (439*kMainScreenWidth/2.0/540.0f)
@interface FirstViewController ()<YHBBannerDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,YHBFunctionCellDelegate,YHBFuncBlockCellDelegate,YHBHotTagsDelegate,ShopMallCellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) YHBBannerVeiw *bannerView;//顶部广告
@property (strong, nonatomic) YHBFirstPageIndex *pageIndexMdoel;
@property (strong, nonatomic) YHBShopIndexManager *shopIndexManager;
@property (strong, nonatomic) YHBFunctionCell *functionCell;
@property (strong, nonatomic) YHBFuncBlockCell *funcBlockCell;
@property (strong, nonatomic) NSMutableArray *headersArray;

@end

@implementation FirstViewController

#pragma mark - getter and setter
- (NSMutableArray *)headersArray
{
    if (!_headersArray) {
        _headersArray = [NSMutableArray arrayWithCapacity:3];
        NSArray *titleArray = @[@"热门标签",@"产品推荐",@"采购推荐"];
        for (int i=0; i < 3; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 25)];
            view.backgroundColor = [UIColor whiteColor];
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
            title.font = [UIFont systemFontOfSize:14];
            title.text = titleArray[i];
            [view addSubview:title];
            _headersArray[i] = view;
        }
    }
    return _headersArray;
}

- (YHBFuncBlockCell *)funcBlockCell
{
    if (!_funcBlockCell) {
        _funcBlockCell = [[YHBFuncBlockCell alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kFuncBlockCellHeight)];
        _funcBlockCell.delegate = self;
    }
    return _funcBlockCell;
}

- (YHBFunctionCell *)functionCell
{
    if (!_functionCell) {
        _functionCell = [[YHBFunctionCell alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kFuncCellHeight)];
        _functionCell.delegate = self;
    }
    return _functionCell;
}

- (YHBShopIndexManager *)shopIndexManager
{
    if (!_shopIndexManager) {
        _shopIndexManager = [[YHBShopIndexManager alloc] init];
    }
    return _shopIndexManager;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //UI
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kMainScreenWidth, kMainScreenHeight-49-20) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = kViewBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.bannerView = [[YHBBannerVeiw alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kBannerHeight)];
    self.bannerView.delegate = self;
    self.tableView.tableHeaderView = self.bannerView;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setExtraCellLineHidden:self.tableView]; //隐藏多需的cell线
    
    
    //网络请求
    __weak FirstViewController *weakself = self;
    [self.shopIndexManager getFirstPageIndexWithSuccess:^(YHBFirstPageIndex *model) {
        weakself.pageIndexMdoel = model;
        //MLOG(@"%@",model);
        [weakself refreshAddView];
        [weakself.tableView reloadData];
    } failure:^(int result, NSString *errorString) {
        [SVProgressHUD showErrorWithStatus:errorString cover:YES offsetY:0];
    }];
    
    //测试
    //[self touchShopsBtn];
    
    
}

#pragma mark - UITabelViewDelegate and DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section > 1) {
        return 25;
    }else return 0.5;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        //热门标签
        return self.pageIndexMdoel.taglist.count/6 + self.pageIndexMdoel.taglist.count%6 ? 1 : 0;
    }else if (section == 3){
        //产品推荐
        return self.pageIndexMdoel.malllist.count/3 + self.pageIndexMdoel.malllist.count%3 ? 1 : 0;
    }else if(section == 4){
        //采购推荐
        return self.pageIndexMdoel.selllist.count/3 + self.pageIndexMdoel.selllist.count%3 ? 1 : 0;
    }else return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.pageIndexMdoel && section > 1 && section < 5) {
        return self.headersArray[section-2];
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kFooterHeigt)];
    footer.backgroundColor = [UIColor blueColor];//kViewBackgroundColor;//RGBCOLOR(238, 238, 238);
    footer.layer.borderColor = [kLineColor CGColor];
    footer.layer.borderWidth = 0.5f;
    return footer;
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return kFuncCellHeight;
            break;
        case 1:
            return kFuncBlockCellHeight;
            break;
        case 2:
            return kHotTagCellHeight;
            break;
        case 3:
        case 4:
            return kcellHeight;
        default:
            return 0;
            break;
    }
}
#pragma mark - Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return self.functionCell;
        }
            break;
        case 1:
        {
            return self.funcBlockCell;
        }
            break;
        case 2: //热门标签
        {
            static NSString *tagCellIdentifier = @"tagCell";
            YHBHotTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellIdentifier];
            if (!cell) {
                cell = [[YHBHotTagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tagCellIdentifier];
                //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.delegate = self;
            }
            int i = 0;
            NSInteger max = self.pageIndexMdoel.taglist.count > 10 ? 10 : self.pageIndexMdoel.taglist.count;
            for (i = 0; i < max ;i++) {
                UIButton *button = cell.tagsArray[i];
                [button setTitle:self.pageIndexMdoel.taglist[i] forState:UIControlStateNormal];
                button.hidden = NO;
            }
            for (; i < 10; i++)  ((UIButton *)cell.tagsArray[i]).hidden = YES;
            return cell;
            
        }
            break;
        case 3: //产品推荐
        {
            static NSString *productCell = @"product";
            YHBShopMallCell *cell = [tableView dequeueReusableCellWithIdentifier:productCell];
            if (!cell) {
                cell = [[YHBShopMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCell andType:0];
                cell.delegate = self;
            }
            [cell clearCellContentParts];
            cell.cellIndexPath = indexPath;
            YHBMalllist *list;
            for (int i=0; i < 3; i ++) {
                //设置cell左中右三部分ui内容
                if (indexPath.row*3+i < self.pageIndexMdoel.malllist.count) {
                    list = self.pageIndexMdoel.malllist[indexPath.row*3+i];
                    MLOG(@"thumb:--->%@",list.thumb);
                    [cell setImage:list.thumb title:list.title price:list.price part:i];
                }else [cell setImage:nil title:@"" price:nil part:i];
            }
            return cell;
        }
            break;
        case 4: //采购推荐
        {
            static NSString *businessCell = @"business";
            YHBShopMallCell *cell = [tableView dequeueReusableCellWithIdentifier:businessCell];
            if (!cell) {
                cell = [[YHBShopMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:businessCell andType:1];
                cell.delegate = self;
            }
            cell.cellIndexPath = indexPath;
            [cell clearCellContentParts];
            for (int i=0; i < 3; i ++) {
                YHBSelllist *list;
                //设置cell左中右三部分ui内容
                if (indexPath.row*3+i < self.pageIndexMdoel.selllist.count) {
                    list = self.pageIndexMdoel.selllist[indexPath.row*3+i];
                    [cell setImage:list.thumb title:list.title time:list.editdate hits:list.hits part:i];
                }else [cell setBlankWithPart:i];
            }
            return cell;
        }
        default:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            return cell;
        }
            break;
    }
    return nil;
}

//载入banners的网络数据
- (void)refreshAddView
{
    NSInteger imageNum = self.pageIndexMdoel.slidelist.count;
    //[self.bannerView.headScrollView setContentSize:CGSizeMake(imageNum * kMainScreenWidth, self.bannerView.headScrollView.height)];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:imageNum];
    for (NSInteger i = 0; i < imageNum; i++) {
        YHBSelllist *slide = self.pageIndexMdoel.slidelist[i];
        array[i] = slide.thumb;
    }
    
    self.bannerView.isNeedCycle = (imageNum>1 ? YES : NO);
    [self.bannerView resetUIWithUrlStrArray:[NSArray arrayWithArray:array]];
}

#pragma mark - Action with Delegate
#pragma mark 点击消息，订单，供应等
- (void)touchedFunctionButtonWithTag:(NSInteger)tag
{
    switch (tag) {
        case button_cate:
        {
            //类目
            UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:[CategoryViewController sharedInstancetype]];
            __weak FirstViewController *weakself = self;
            [CategoryViewController sharedInstancetype].hidesBottomBarWhenPushed = YES;
            [CategoryViewController sharedInstancetype].isSingleSelect = YES;
            [[CategoryViewController sharedInstancetype] setBlock:^(NSArray *aArray) {
                [CategoryViewController sharedInstancetype].isSingleSelect = NO;
                YHBCatSubcate *cate = (YHBCatSubcate *)[aArray lastObject];
                self.tabBarController.selectedIndex = 1;
                NSDictionary * dic = [NSDictionary dictionaryWithObject:cate forKey:kSearchCateMessage];
                [[NSNotificationCenter defaultCenter] postNotificationName:kSearchCateMessage object:nil userInfo:dic];
                [[CategoryViewController sharedInstancetype] cleanAll];
            }];
            [self presentViewController:navVc animated:YES completion:nil];
        }
            break;
        case button_groupBuy:
        {
            //团购
            YHBLookSupplyViewController *vc = [[YHBLookSupplyViewController alloc] initWithIsSupplyYesAndTypeid:3];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case button_sell:
        {
            //查看供应
//            if ([self userLoginConfirm]) {
                YHBLookSupplyViewController *vc = [[YHBLookSupplyViewController alloc] initWithIsSupply:YES];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
//            }
        }
            break;
        case button_buy:
        {
            //查看采购
//            if ([self userLoginConfirm]) {
                YHBLookSupplyViewController *vc = [[YHBLookSupplyViewController alloc] initWithIsSupply:NO];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
//            }
        }
            break;
        default:
            break;
    }
}
#pragma mark 点击商城、卖步、找步
- (void)touchFuncBlockWithTag:(NSInteger)tag
{
    switch (tag) {
        case button_shopMall:
        {
            //商城
            YHBShopMallViewController *shopMallVC = [[YHBShopMallViewController alloc] init];
            shopMallVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shopMallVC animated:YES];
        }
            break;
        case button_sellWeave:
        {
            //卖步
            if ([self userLoginConfirm]) {

            YHBPublishSupplyViewController *supplyVC = [[YHBPublishSupplyViewController alloc] init];
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:supplyVC] animated:YES completion:^{
                
            }];
            }
        }
            break;
        case button_findWeave:
        {
            //找步
            if ([self userLoginConfirm]) {

            YHBPublishBuyViewController *supplyVC = [[YHBPublishBuyViewController alloc] init];
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:supplyVC] animated:YES completion:^{
                
            }];
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark 点击产品推荐、商机推荐部分
- (void)selectCellPartWithIndexPath : (NSIndexPath*)indexPath part:(NSInteger)part
{
    
    if (indexPath.section == 3) {
        YHBMalllist *list = self.pageIndexMdoel.malllist[indexPath.row*3+part];
        YHBProductDetailVC *vc = [[YHBProductDetailVC alloc] initWithProductID:(NSInteger)list.itemid];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 4){
        YHBSelllist *list = self.pageIndexMdoel.malllist[indexPath.row*3+part];
        YHBBuyDetailViewController *vc = [[YHBBuyDetailViewController alloc] initWithItemId:(int)list.itemid andIsMine:NO isModal:NO];
        vc.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark 点击hot tag
- (void)touchHotTagsWithTag:(NSInteger)tag
{
    if (self.pageIndexMdoel.taglist.count > tag) {
        NSString *hotTag = self.pageIndexMdoel.taglist[tag];
        self.tabBarController.selectedIndex = 1;
        NSDictionary * dic = [NSDictionary dictionaryWithObject:(hotTag?:@"") forKey:kSearchMessage];
        [[NSNotificationCenter defaultCenter] postNotificationName:kSearchMessage object:nil userInfo:dic];
        
        
    }
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


#pragma mark 点击head的Banner 广告
- (void)touchBannerWithNum:(NSInteger)num;
{
    if (num < self.pageIndexMdoel.slidelist.count) {
        YHBSlidelist *slideModel = self.pageIndexMdoel.slidelist[num];
        if (slideModel.linkurl.length > 1) {
            IntroduceViewController *iVC = [[IntroduceViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:iVC];
            iVC.isSysPresent = YES;
           
            [self presentViewController:nav animated:YES completion:^{
                
            }];

            [iVC setUrl:slideModel.linkurl title:slideModel.title];
        }
    }
}

#pragma mark - 登陆状态校验
- (BOOL)userLoginConfirm
{
    if ([YHBUser sharedYHBUser].isLogin) {
        return YES;
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginForUserMessage object:[NSNumber numberWithBool:NO]];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessItem) name:kLoginSuccessMessae object:nil];
        return NO;
    }
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
