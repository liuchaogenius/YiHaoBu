//
//  YHBStoreViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/11.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//  特定的一个商场vc

#import "YHBStoreViewController.h"
#import "YHBUserHeadView.h"
#import "YHBShopMallCell.h"
#import "YHBShopInfoViewController.h"
#import "YHBUserInfo.h"
#import "YHBUserManager.h"
#import "YHBInfoListManager.h"
#import "SVProgressHUD.h"
#import "YHBPage.h"
#import "YHBRslist.h"
#import "SVPullToRefresh.h"
#import "YHBStoreDetailViewController.h"
#import "YHBPrivateManager.h"
#import "YHBUser.h"
#import "YHBProductDetailVC.h"
#import "YHBSupplyModel.h"
#import "YHBSupplyDetailViewController.h"

#define kSgmBtnHeight 50
#define kSelectTagBase 100
#define kNumberFont 14
#define kButtonFont 15
#define kPageSize 21 //分页-每页的数量

enum SgmLabel_tag
{
    SgmLabel_number = 200,
    SgmLabel_title
};

enum SgmBtn_tag
{
    SgmBtn_productInfo = kSelectTagBase, //产品信息
    SgmBtn_sellInfo,//供应信息
    SgmBtn_templetInfo//样板信息
};

@interface YHBStoreViewController ()<UserHeadDelegate,UITableViewDataSource,UITableViewDelegate,ShopMallCellDelegate,UIScrollViewDelegate>
{
    UIButton *_selectSgmButton;
}
@property (strong, nonatomic) YHBUserHeadView *shopHeadView;
@property (strong, nonatomic) UIScrollView *sgmBtmScrollView;
@property (assign, nonatomic) NSInteger sgmCount;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UITableView *sellTableView;//供应信息tableview
@property (strong, nonatomic) UITableView *productTableView;//产品信息tableview
@property (strong, nonatomic) UITableView *templetTableView;//样板信息tableview
@property (assign, nonatomic) int shopID;
@property (strong, nonatomic) UIScrollView *backScrollView;
@property (strong, nonatomic) YHBUserInfo *shopInfo;
@property (strong, nonatomic) YHBInfoListManager *listManger;
@property (strong, nonatomic) YHBUserManager *infoManger;
@property (strong, nonatomic) NSMutableDictionary  *rslistDic;
@property (strong, nonatomic) NSMutableDictionary *pageDic;
@property (strong, nonatomic) YHBPrivateManager *privateManager;


@end

@implementation YHBStoreViewController
#pragma mark - getter and setter
- (YHBPrivateManager *)privateManager
{
    if (!_privateManager) {
        _privateManager = [[YHBPrivateManager alloc] init];
    }
    return _privateManager;
}

- (NSMutableDictionary *)rslistDic
{
    if (!_rslistDic) {
        _rslistDic = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _rslistDic;
}

- (NSMutableDictionary *)pageDic
{
    if (!_pageDic) {
        _pageDic = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _pageDic;
}

- (UITableView *)sellTableView
{
    if (!_sellTableView) {
        _sellTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, _backScrollView.height) style:UITableViewStylePlain];
        _sellTableView.tag = SgmBtn_sellInfo;
        _sellTableView.delegate = self;
        _sellTableView.dataSource = self;
        _sellTableView.backgroundColor = kViewBackgroundColor;
        _sellTableView.rowHeight = kcellHeight;
    }
    return _sellTableView;
}

- (UITableView *)productTableView
{
    if (!_productTableView) {
        _productTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, _backScrollView.height) style:UITableViewStylePlain];
        _productTableView.tag = SgmBtn_productInfo;
        _productTableView.delegate = self;
        _productTableView.dataSource = self;
        _productTableView.backgroundColor = kViewBackgroundColor;
        _productTableView.rowHeight = kcellHeight;
    }
    return _productTableView;
}

- (UITableView *)templetTableView
{
    if (!_templetTableView) {
        _templetTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, _backScrollView.height) style:UITableViewStylePlain];
        _templetTableView.tag = SgmBtn_templetInfo;
        _templetTableView.delegate = self;
        _templetTableView.dataSource = self;
        _templetTableView.backgroundColor = kViewBackgroundColor;
        _templetTableView.rowHeight = kcellHeight;
    }
    return _templetTableView;
}

- (UIScrollView *)backScrollView
{
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeadHeight+kSgmBtnHeight, kMainScreenWidth, kMainScreenHeight-44-kHeadHeight-kSgmBtnHeight)];
        _backScrollView.backgroundColor = kViewBackgroundColor;
        [_backScrollView setBounces:NO];
        [_backScrollView setPagingEnabled:YES];
        [_backScrollView setContentSize:CGSizeMake(kMainScreenWidth, _backScrollView.height)];
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.delegate = self;
    }
    return _backScrollView;
}

- (YHBUserManager *)infoManger
{
    if (!_infoManger) {
        _infoManger = [[YHBUserManager alloc] init];
    }
    return _infoManger;
}

- (YHBInfoListManager *)listManger
{
    if (!_listManger) {
        _listManger = [YHBInfoListManager sharedManager];
    }
    return _listManger;
}


- (UIScrollView *)sgmBtmScrollView
{
    if (!_sgmBtmScrollView) {
        _sgmBtmScrollView = [[UIScrollView alloc] init];
        _sgmBtmScrollView.layer.borderColor = [RGBCOLOR(207, 207, 207) CGColor];
        _sgmBtmScrollView.layer.borderWidth = 0.7f;
        _sgmBtmScrollView.layer.masksToBounds = YES;
        _sgmBtmScrollView.showsHorizontalScrollIndicator = NO;
        [_sgmBtmScrollView setFrame:CGRectMake(0, kHeadHeight, kMainScreenWidth, kSgmBtnHeight)];
        _sgmBtmScrollView.backgroundColor = [UIColor whiteColor];
        //_sgmBtmScrollView.delegate = self;
        //通过分栏数量调整content宽度
        
        [self refreshSgmBtmScrollView];
    }
    return _sgmBtmScrollView;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

- (instancetype)initWithShopID:(int)shopID
{
    self = [super init];
    if (self) {
        self.shopID = shopID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settitleLabel:@"商场"];
    
    //UI
    self.view.backgroundColor = kViewBackgroundColor;
    [self creatHeadView];
    [self.shopHeadView refreshSelfHeadWithIsLogin:YES name:@"姓名" avator:nil thumb:nil group:0 company:@"公司名"];
    
    _titleArray = nil;
    [self.view addSubview:self.sgmBtmScrollView];
    [self.view addSubview:self.backScrollView];
    
    //网络请求
    __weak YHBStoreViewController *weakself = self;
    [self.infoManger getUserInfoWithToken:nil orUserId:[NSString stringWithFormat:@"%d",self.shopID] Success:^(NSDictionary *dataDic){
        weakself.shopInfo = [YHBUserInfo modelObjectWithDictionary:dataDic];
        MLOG(@"%@",weakself.shopInfo);
        if ((int)weakself.shopInfo.groupid > 5) {
            //刷新页面
            weakself.titleArray =( (int)weakself.shopInfo.groupid == 7 ? @[@"产品信息",@"供应信息",@"样板信息"] : @[@"供应信息"]);
            [weakself refreshUI];
            if ((int)weakself.shopInfo.groupid == 6) {
                weakself.sellTableView.left = 0;
                [weakself.backScrollView addSubview:weakself.sellTableView];
                [weakself.backScrollView setContentSize:CGSizeMake(kMainScreenWidth, _backScrollView.height)];
                [weakself getDataWithPageID:1 andInfoListTypr:SgmBtn_sellInfo];
                [weakself addTableViewTragWithTableView:weakself.sellTableView];
            }else if ((int)weakself.shopInfo.groupid == 7){
                [weakself.backScrollView setContentSize:CGSizeMake(kMainScreenWidth*3, _backScrollView.height)];
                weakself.productTableView.left = 0;
                [weakself.backScrollView addSubview:weakself.productTableView];
                [weakself getDataWithPageID:1 andInfoListTypr:SgmBtn_productInfo];
                
                weakself.sellTableView.left = kMainScreenWidth;
                [weakself.backScrollView addSubview:weakself.sellTableView];
                [weakself getDataWithPageID:1 andInfoListTypr:SgmBtn_sellInfo];
                
                weakself.templetTableView.left = 2*kMainScreenWidth;
                [weakself.backScrollView addSubview:weakself.templetTableView];
                [weakself getDataWithPageID:1 andInfoListTypr:SgmBtn_templetInfo];

                [weakself addTableViewTragWithTableView:weakself.productTableView];
                [weakself addTableViewTragWithTableView:weakself.sellTableView];
                [weakself addTableViewTragWithTableView:weakself.templetTableView];
            }
        }
    } failure:^{
        [SVProgressHUD showErrorWithStatus:@"获取信息失败,请稍后再试！" cover:YES offsetY:0];
    }];
    
}

#pragma mark - UI
- (void)creatHeadView {
    if (!_shopHeadView) {
        _shopHeadView = [[YHBUserHeadView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kHeadHeight)];
        _shopHeadView.delegate = self;
    }
    //[self refreshUserHeadView];
    [self.view addSubview:self.shopHeadView];
}

- (void)refreshUI
{
    [self.shopHeadView refreshViewWithIslogin:YES group:(NSInteger)self.shopInfo.groupid name:self.shopInfo.truename avator:self.shopInfo.avatar thumb:self.shopInfo.thumb company:self.shopInfo.company friend:(NSInteger)self.shopInfo.friend];
    [self refreshSgmBtmScrollView];
}

- (void)refreshSgmBtmScrollView
{
    if (_sgmBtmScrollView) {
        self.sgmCount = self.titleArray.count;
        [_sgmBtmScrollView removeSubviews];
        CGFloat contentWidth = (self.sgmCount > 5 ? self.sgmCount*kMainScreenWidth/5.0f : kMainScreenWidth);
        [_sgmBtmScrollView setContentSize:CGSizeMake(contentWidth, kSgmBtnHeight)];
        
        //添加sgmButton
        CGFloat buttonWidth = (self.sgmCount>=5 ? kMainScreenWidth/5.0f : kMainScreenWidth/(float)self.sgmCount);
        for (int i = 0; i < self.sgmCount; i++) {
            UIButton *sgmButton = [self customButtonWithFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, kSgmBtnHeight) andTitle:self.titleArray[i] andNumber:@""];
            sgmButton.tag = i + kSelectTagBase;//用tag%kSelectTagBase 来记录选中的分类
            if (i == 0) {
                sgmButton.selected = YES; //默认选择第一个
                [self setSelectOfButton:sgmButton andisSelect:YES];
                _selectSgmButton = sgmButton;
            }
            [_sgmBtmScrollView addSubview:sgmButton];
        }
    }
}
#pragma - 获取产品、供应、样本信息列表,并刷新tableview
- (void)getDataWithPageID:(NSInteger)pageID andInfoListTypr:(NSInteger)type
{
    switch (type) {
        case SgmBtn_productInfo: //产品信息
        case SgmBtn_templetInfo://样板信息
        {
            [self.listManger getProductListWithUserID:self.shopID typeID:0 pageID:(type==SgmBtn_productInfo?0:1) pageSize:kPageSize Success:^(NSMutableArray *modelArray, YHBPage *page) {
                if (pageID == 1) {
                    [self.rslistDic setObject:modelArray forKey:[NSString stringWithFormat:@"%ld",type-kSelectTagBase]];
                }else{
                    NSMutableArray *array = self.rslistDic[[NSString stringWithFormat:@"%ld",type-kSelectTagBase]];
                    if (array) {
                        [array addObjectsFromArray:modelArray];
                    }
                }
                [self.pageDic setObject:page forKey:[NSString stringWithFormat:@"%ld",type-kSelectTagBase]];
                type == SgmBtn_productInfo ? [self.productTableView reloadData] : [self.templetTableView reloadData];
            } failure:^(NSString *error) {
                [SVProgressHUD showErrorWithStatus:error cover:YES offsetY:0];
            }];
        }
            break;
        case SgmBtn_sellInfo://供应信息
        {
            [self.listManger getSellListWithUserID:self.shopID pageID:pageID pageSize:kPageSize Success:^(NSMutableArray *modelArray, YHBPage *page) {
                if (pageID == 1) {
                    [self.rslistDic setObject:modelArray forKey:[NSString stringWithFormat:@"%ld",type-kSelectTagBase]];
                }else{
                    NSMutableArray *array = self.rslistDic[[NSString stringWithFormat:@"%ld",type-kSelectTagBase]];
                    if (array) {
                        [array addObjectsFromArray:modelArray];
                    }
                }
                [self.pageDic setObject:page forKey:[NSString stringWithFormat:@"%ld",type-kSelectTagBase]];
                [self.sellTableView reloadData];
            } failure:^(NSString *error) {
                [SVProgressHUD showErrorWithStatus:error cover:YES offsetY:0];
            }];
        }
            break;
        
        default:
            break;
    }
}

#pragma mark 上拉下拉
- (void)addTableViewTragWithTableView:(UITableView *)tableView
{
    __weak YHBStoreViewController *weakself = self;
    __weak UITableView *weakTableView = tableView;
    NSInteger type = tableView.tag;
    [tableView addPullToRefreshWithActionHandler:^{
        int16_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakTableView.pullToRefreshView stopAnimating];
            [weakself getDataWithPageID:1 andInfoListTypr:type];
        });
    }];
    
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
    }];
}

#pragma mark - tableView DataSource and Delegaet
#pragma mark 数据行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger type = tableView.tag;
    NSMutableArray *array = self.rslistDic[[NSString stringWithFormat:@"%ld",type-kSelectTagBase]];
    MLOG(@"%@",array);
    return array ? (array.count/3 + (array.count%3 ?1 : 0)) : 0;
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.rslistDic[[NSString stringWithFormat:@"%ld",tableView.tag-kSelectTagBase]];
    NSInteger count = array.count;
    switch (tableView.tag) {
        case SgmBtn_productInfo:
        case SgmBtn_templetInfo:{
            static NSString *cellIdentifier1 = @"Cell1";
            YHBShopMallCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (!cell) {
                cell = [[YHBShopMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1 andType:0];
                cell.delegate = self;
            }
            [cell clearCellContentParts];
            for (int i=0; i < 3; i++ ) {
                if(indexPath.row * 3 + i >= count){//空白部分
                    [cell setBlankWithPart:i];
                }else{
                    YHBRslist *list = array[indexPath.row *3 + i];
                    [cell setImage:list.thumb title:list.title price:list.price part:i];
                }
            }
            cell.cellIndexPath = indexPath;
            return cell;
        }
            break;
        case SgmBtn_sellInfo:{
            static NSString * cellIdentifier2 = @"Cell2";
            YHBShopMallCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
            [cell clearCellContentParts];
            if (!cell) {
                cell = [[YHBShopMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2 andType:1];
                cell.delegate = self;
            }
            for (int i=0; i < 3; i++ ) {
                if(indexPath.row * 3 + i >= count){//空白部分
                    [cell setBlankWithPart:i];
                }else{
                    YHBSupplyModel *list = array[indexPath.row *3 + i];
                    [cell setImage:list.thumb title:list.title time:list.editdate hits:list.hits part:i];
                }
            }
            cell.cellIndexPath = indexPath;
            return cell;
        }
        default:
            return nil;
            break;
    }
}

#pragma mark - action
- (void)touchSgmButton:(UIButton *)sender
{
#warning 待刷新tableview -cc
    if(_selectSgmButton.tag != sender.tag){
        _selectSgmButton.selected = NO;
        [self setSelectOfButton:_selectSgmButton andisSelect:NO];
        
        _selectSgmButton = sender;
        [self setSelectOfButton:sender andisSelect:YES];
        sender.selected = YES;

        switch (sender.tag) {
            case SgmBtn_productInfo:
            {
                //产品信息
                [self.backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
                break;
            case SgmBtn_sellInfo:
            {
                //供应信息
                [self.backScrollView setContentOffset:CGPointMake(kMainScreenWidth, 0) animated:YES];
            }
                break;
            case SgmBtn_templetInfo:
            {
                //样板信息
                /*
                YHBShopInfoViewController *infoVC = [[YHBShopInfoViewController alloc] init];
                infoVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:infoVC animated:YES];*/
                [self.backScrollView setContentOffset:CGPointMake(kMainScreenWidth*2, 0) animated:YES];
            }
                break;
            default:
                break;
        }
    }
}



#pragma mark - delegate
#pragma mark - 点击进入产品、供应详情
- (void)selectCellPartWithIndexPath : (NSIndexPath*)indexPath part:(NSInteger)part
{
    NSMutableArray *array = self.rslistDic[[NSString stringWithFormat:@"%ld",_selectSgmButton.tag-kSelectTagBase]];
    
    YHBRslist *model = array[indexPath.row * 3 + part];
    
    switch (_selectSgmButton.tag) {
        case SgmBtn_productInfo:
        {
            //产品
            YHBProductDetailVC *vc = [[YHBProductDetailVC alloc] initWithProductID:(int)model.itemid];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SgmBtn_sellInfo:
        {
            //供应
            YHBSupplyDetailViewController *vc = [[YHBSupplyDetailViewController alloc] initWithItemId:((YHBSupplyModel *)model).itemid andIsMine:NO isModal:NO];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SgmBtn_templetInfo:
        {
            //样板
            YHBProductDetailVC *vc = [[YHBProductDetailVC alloc] initWithProductID:(int)model.itemid];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)touchPrivateBtn:(UIButton *)sender
{
    if ([YHBUser sharedYHBUser].isLogin) {
        sender.selected = !sender.selected;
        [self.privateManager privateOrDisPrivateWithItemID:[NSString stringWithFormat:@"%d",self.shopID] privateType:private_company token:[YHBUser sharedYHBUser].token Success:^{
            
        } failure:^(NSString *error) {
            [SVProgressHUD showErrorWithStatus:error cover:YES offsetY:0];
            sender.selected = !sender.selected;
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"你还没有登陆" cover:YES offsetY:0];
    }
    
}

#pragma mark 点击头像
- (void)touchHeadImagBtn
{
    if (self.shopInfo){
        YHBStoreDetailViewController *vc = [[YHBStoreDetailViewController alloc] initWithStoreInfo:self.shopInfo];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark scrollView delegat
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.backScrollView && (int)self.shopInfo.groupid == 7) {
        NSInteger tag = scrollView.contentOffset.x / kMainScreenWidth + kSelectTagBase;
        UIButton *button = (UIButton *)[self.sgmBtmScrollView viewWithTag:tag];
        //MLOG(@"%@",button.currentTitle);
        [self touchSgmButton:button];
    }
   
}

#pragma mark - customButtom构造
- (UIButton *)customButtonWithFrame:(CGRect)frame andTitle:(NSString *)title andNumber:(NSString *)number
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, button.width, kNumberFont)];
    numberLabel.backgroundColor  = [UIColor clearColor];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.textColor = [UIColor blackColor];
    numberLabel.tag = SgmLabel_number;
    [numberLabel setFont:[UIFont systemFontOfSize:kNumberFont]];
    numberLabel.text = @"0";
    [button addSubview:numberLabel];
    
    UILabel *titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, button.height/2.0+5, button.width, kButtonFont)];
    titleLabel.backgroundColor  = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.tag = SgmLabel_title;
    [titleLabel setFont:[UIFont systemFontOfSize:kButtonFont]];
    titleLabel.text = title;
    [button addSubview:titleLabel];
    
    //[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[button setTitleColor:KColor forState:UIControlStateSelected];
    //[button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    button.titleLabel.font = kFont16;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(button.width+0.2, 0, 0.6f, button.height)];
    line.backgroundColor = kLineColor;
    [button addSubview:line];
    //button.layer.borderWidth = 0.7f;
    //button.layer.borderColor = [RGBCOLOR(207, 207, 207) CGColor];
    button.selected = NO;
    [button addTarget:self action:@selector(touchSgmButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)setSelectOfButton:(UIButton *)button andisSelect : (BOOL)isSelect
{
    UILabel *numLabel = (UILabel *)[button viewWithTag:SgmLabel_number];
    UILabel *titleLabel = (UILabel *)[button viewWithTag:SgmLabel_title];
    numLabel.textColor = isSelect ? KColor : [UIColor blackColor];
    titleLabel.textColor = isSelect ? KColor : [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
