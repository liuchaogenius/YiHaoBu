//
//  SecondViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 14-11-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "SecondViewController.h"
#import "GoodsTableViewCell.h"
#import "YHBRslist.h"
#import "YHBCRslist.h"
#import "YHBCatSubcate.h"
#import "YHBPage.h"
#import "SVProgressHUD.h"
#import "YHBInfoListManager.h"
#import "SVPullToRefresh.h"
#import "YHBProductListsCell.h"
#import "YHBShopslistCell.h"
#import "CategoryViewController.h"
#import "YHBSortTagsCell.h"
#import "YHBStoreViewController.h"
#import "YHBProductDetailVC.h"

#define ksegBtnWidth (kMainScreenWidth/4.0)
#define kFilBtnWidth (kMainScreenWidth/3.0)
#define kSearchViewHeight 40
#define kSegViewHeight 40
#define kSearchBtnWidth 50
#define kFilterHeight 34
#define kFilTagBase 100
#define kGoodsCellHeight 80
#define kPageSize 30
typedef enum : NSUInteger {
    Search_buy = 0, //采购
    Search_sell,//供应
    Search_mall,//店铺
    Search_product//产品
} SearchType;

typedef enum : NSUInteger {
    Filter_all = kFilTagBase,//全部
    Filter_vip,//vip
    Filter_filt,//筛选
} FilterType;

@interface SecondViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,YHBSortTagDelegate>
{
    UIButton *_selectSegBtn;//选择的segButton
    SearchType _selectSearchType;//选择的搜索类型-采购等
    UIButton *_selectFilBtn;
    FilterType _selectFilType;
    YHBPage *_currentPage;
    
    UIButton *_secondBtn;
}

@property (strong, nonatomic) UIView *segmentView;//顶部选择分类seg
@property (strong, nonatomic) UIView *searchView;//搜索view
@property (weak, nonatomic) UITextField *searchTextField;//搜索框
@property (strong, nonatomic) UIView *filterView;//筛选-查看全部、仅看vip、筛选
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *modelsDic;//数据字典-存放数据模型数组 key为tag
@property (strong, nonatomic) NSMutableDictionary *pageDic;
@property (strong, nonatomic) NSMutableArray *tagsArray;//标签数组
@property (strong, nonatomic) YHBInfoListManager *listManager;

@end

@implementation SecondViewController

#pragma mark - getter and setter
- (YHBInfoListManager *)listManager
{
    if (!_listManager) {
        _listManager = [[YHBInfoListManager alloc] init];
    }
    return _listManager;
}

//获取当前的现实是第一页，无显示时返回0
- (NSInteger)getCurrentPageID
{
    if (_currentPage) {
        return _currentPage.pageid;
    }else return 0;
}

- (NSMutableArray *)tagsArray
{
    if (!_tagsArray) {
        _tagsArray = [NSMutableArray arrayWithCapacity:8];
    }
    return _tagsArray;
}

- (NSMutableDictionary *)modelsDic
{
    if (!_modelsDic) {
        _modelsDic = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return _modelsDic;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.filterView.bottom, kMainScreenWidth, kMainScreenHeight-49-self.filterView.bottom) style:UITableViewStylePlain];
        _tableView.backgroundColor = kViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.estimatedRowHeight = kGoodsCellHeight;
    }
    return _tableView;
}

- (UIView *)filterView
{
    if (!_filterView) {
        _filterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.searchView.bottom, kMainScreenWidth, kFilterHeight)];
        _filterView.backgroundColor = [UIColor whiteColor];
        _filterView.layer.borderColor = [kLineColor CGColor];
        _filterView.layer.borderWidth = 1.0f;
        NSArray *titleArray = @[@"查看全部",@"仅看VIP",@"筛选"];
        for (int i = 0; i < 3; i++) {
            UIButton * button = [self customFilterButtonWithTitle:titleArray[i] Tag:i+kFilTagBase Frame:CGRectMake(i*kFilBtnWidth, 0, kFilBtnWidth, _filterView.height)];
            [_filterView addSubview:button];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake((i+1)*kFilBtnWidth-1, 3, 0.5, _filterView.height-6)];
            line.backgroundColor = kLineColor;
            [_filterView addSubview:line];
            if (i == 0) {
                button.selected = YES;
                _selectFilBtn = button;
                _selectFilType = button.tag;
            }
            if(i ==1 ) _secondBtn = button;
        }
    }
    return _filterView;
}

- (UIView *)searchView
{
    if (!_searchView) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, self.segmentView.bottom, kMainScreenWidth, kSearchViewHeight)];
        _searchView.backgroundColor = KColor;
    
        UITextField *searchTf = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, kMainScreenWidth-10-kSearchBtnWidth, kSearchViewHeight-10)];
        [searchTf setBorderStyle:UITextBorderStyleRoundedRect];
        searchTf.placeholder = @"请输入关键字";
        [searchTf setClearButtonMode:UITextFieldViewModeAlways];
        searchTf.delegate = self;
        [searchTf setReturnKeyType:UIReturnKeySearch];
        _searchTextField = searchTf;
        [_searchView addSubview:searchTf];
        
        UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(searchTf.right, searchTf.top, kSearchBtnWidth, searchTf.height)];
        [searchBtn setBackgroundColor:[UIColor clearColor]];
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        searchBtn.titleLabel.font = kFont16;
        [searchBtn addTarget:self action:@selector(touchSearchButton) forControlEvents:UIControlEventTouchUpInside];
        [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [_searchView addSubview:searchBtn];
    }
    return _searchView;
}

- (UIView *)segmentView
{
    if (!_segmentView) {
        _segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kMainScreenWidth, kSegViewHeight)];
        _segmentView.backgroundColor = [UIColor whiteColor];
        //_segmentView.layer.borderColor = [kLineColor CGColor];
        //_segmentView.layer.borderWidth = 1.0;
        NSArray *titleArray = @[@"采购",@"供应",@"店铺",@"产品"];
        for (int i=0; i<titleArray.count; i++) {
            UIButton *button = [self customSegmentButtonWithTitle:titleArray[i] andTag:i Frame:CGRectMake(i*ksegBtnWidth, 0, ksegBtnWidth, _segmentView.height)];
            [_segmentView addSubview:button];
            if (i == 0) {
                button.selected = YES;
                _selectSegBtn = button;
                _selectSegBtn.backgroundColor = KColor;
                _selectSearchType = Search_buy;
            }
        }
    }
    return _segmentView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldSearch:) name:kSearchMessage object:nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ui
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.filterView];
    [self.view addSubview:self.tableView];
    [self setExtraCellLineHidden:self.tableView];
    
    [self addTableViewTragWithTableView:self.tableView];
    

}

- (NSString *)getCateID
{
    if (self.tagsArray) {
        NSMutableString *str= [NSMutableString stringWithCapacity:20];
        YHBCatSubcate *cate;
        for (int i=0;i<self.tagsArray.count;i++) {
            [str stringByAppendingString:(i+1==self.tagsArray.count ? [NSString stringWithFormat:@"%d,",(int)cate.catid] : [NSString stringWithFormat:@"%d",(int)cate.catid])];
        }
        return str;
    }else return nil;
}

#pragma mark 网络请求
- (void)getDataWithPageID:(NSInteger)pageid
{
    switch (_selectSearchType) {
        case Search_buy:
        {
            [self.listManager searchBuyListWithUserID:kAll KeyWord:self.searchTextField.text cateID:[self getCateID] pageID:pageid Vip:(_selectFilType == Filter_all ? kAll:1) pageSize:kPageSize Success:^(NSMutableArray *modelArray, YHBPage *page) {
                [self.pageDic setObject:page forKey:[NSString stringWithFormat:@"%lu",(unsigned long)Search_buy * _selectFilType]];
                if (pageid == 1) {
                    [self.modelsDic setObject:modelArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)Search_buy * _selectFilType]];
                }else{
                    NSMutableArray *array = self.modelsDic[[NSString stringWithFormat:@"%lu",(unsigned long)Search_buy * _selectFilType]];
                    [array addObjectsFromArray:modelArray];
                }
                
                [self.tableView reloadData];
            } failure:^{
                [SVProgressHUD showErrorWithStatus:@"搜索失败，请稍后再试！" cover:NO offsetY:0];
            }];
        }
            break;
        case Search_sell:
        {
            [self.listManager searchSellListWithUserID:kAll KeyWord:self.searchTextField.text cateID:[self getCateID] Vip:(_selectFilType == Filter_all ? kAll:1) pageID:pageid pageSize:kPageSize Success:^(NSMutableArray *modelArray, YHBPage *page) {
                self.pageDic[[NSString stringWithFormat:@"%lu",(unsigned long)Search_sell * _selectFilType]] = page;
                if (pageid == 1) {
                    [self.modelsDic setObject:modelArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)Search_sell * _selectFilType]];
                }else{
                    NSMutableArray *array = self.modelsDic[[NSString stringWithFormat:@"%lu",(unsigned long)Search_sell * _selectFilType]];
                    [array addObjectsFromArray:modelArray];
                }
                [self.tableView reloadData];
            } failure:^{
                [SVProgressHUD showErrorWithStatus:@"搜索失败，请稍后再试！" cover:NO offsetY:0];
            }];
        }
            break;
        case Search_product:
        {
            [self.listManager searchProductListWithUserID:kAll typeID:(_selectFilType == Filter_all ? kAll:1) KeyWord:self.searchTextField.text cateID:[self getCateID] PageID:pageid pageSize:kPageSize Success:^(NSMutableArray *modelArray, YHBPage *page) {
                self.pageDic[[NSString stringWithFormat:@"%lu",(unsigned long)Search_product * _selectFilType]] = page;
                if (pageid == 1) {
                    [self.modelsDic setObject:modelArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)Search_product * _selectFilType]];
                }else{
                    NSMutableArray *array = self.modelsDic[[NSString stringWithFormat:@"%lu",(unsigned long)Search_product * _selectFilType]];
                    [array addObjectsFromArray:modelArray];
                }

                [self.tableView reloadData];
            } failure:^{
                [SVProgressHUD showErrorWithStatus:@"搜索失败，请稍后再试！" cover:NO offsetY:0];
            }];
        }
            break;
        case Search_mall:
        {
            [self.listManager searchCompanyListWithKeyWord:self.searchTextField.text cateID:[self getCateID] Vip:(_selectFilType == Filter_all ? kAll:1) pageID:pageid pageSize:kPageSize Success:^(NSMutableArray *modelArray, YHBPage *page) {
                self.pageDic[[NSString stringWithFormat:@"%lu",(unsigned long)Search_mall * _selectFilType]] = page;
                if (pageid == 1) {
                    [self.modelsDic setObject:modelArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)Search_mall * _selectFilType]];
                }else{
                    NSMutableArray *array = self.modelsDic[[NSString stringWithFormat:@"%lu",(unsigned long)Search_mall * _selectFilType]];
                    [array addObjectsFromArray:modelArray];
                }
                [self.tableView reloadData];

            } failure:^{
                [SVProgressHUD showErrorWithStatus:@"搜索失败，请稍后再试！" cover:NO offsetY:0];
            }];
        }
            break;
        default:
            break;
    }
}

- (void)getFirstPageData
{
    [self getDataWithPageID:1];
}

#pragma mark 上拉下拉
- (void)addTableViewTragWithTableView:(UITableView *)tableView
{
    __weak SecondViewController *weakself = self;
    __weak UITableView *weakTableView = tableView;
    [tableView addPullToRefreshWithActionHandler:^{
        int16_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakTableView.pullToRefreshView stopAnimating];
            if ([weakself isNeedSearch]) {
                [weakself getFirstPageData];
            }else{
                [SVProgressHUD showErrorWithStatus:@"至少输入关键字或者选择筛选条件！" cover:NO offsetY:0];
            }
            
        });
    }];
    
     [tableView addInfiniteScrollingWithActionHandler:^{
         YHBPage *page = weakself.pageDic[[NSString stringWithFormat:@"%ld",_selectSearchType*_selectFilType]];
         NSMutableArray *array = weakself.modelsDic[[NSString stringWithFormat:@"%ld",_selectSearchType*_selectFilType]];
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
    return 2;
}


#pragma mark 数据行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.tagsArray.count/4 + self.tagsArray.count%4 ? 1 : 0;
    }else{
        NSArray *modelArray = self.modelsDic[[NSString stringWithFormat:@"%lu",_selectSearchType*_selectFilType]];
        return modelArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSInteger count = self.tagsArray.count;
        CGFloat heught = kBlankWidth+(kBlankWidth+kTagHeight)*(count/4+(count%4?1:0));
        return heught;

    }else
        return kGoodsCellHeight;
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //筛选cell
        static NSString *cellIdentifier = @"tag";
        YHBSortTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[YHBSortTagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.delegate = self;
        }
        NSInteger count = self.tagsArray.count;
        cell.frame = CGRectMake(0, 0, kMainScreenWidth, kBlankWidth+(kBlankWidth+kTagHeight)*(count/4+(count%4 ? 1 : 0)));
        MLOG(@"height = %lf",cell.height);
        [cell setUIWithCateArray:self.tagsArray];
        return cell;
    }else{
        NSMutableArray *dataArray = self.modelsDic[[NSString stringWithFormat:@"%lu",_selectSearchType*_selectFilType]];
        switch (_selectSearchType) {
            case Search_buy:
            {
                static NSString *cellIdentifier1 = @"Buy";
                GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
                if (!cell) {
                    cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
                }
                YHBRslist *list = dataArray[indexPath.row];
                [cell setCellWithGoodImage:list.thumb title:list.title catName:list.catname typeName:list.typename editTime:list.editdate isVip:list.vip];
                //[cell setCellWithGoodImage:list.thumb title:list.title catName:list.catname typeName:list editTime:list.editdate skimCount:list.hits paidPrice:0 isVip:list.vip];
                return cell;
            }
                break;
            case Search_sell:
            {
                static NSString *cellIdentifier2 = @"Sell";
                GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
                if (!cell) {
                    cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
                }
                YHBRslist *list = dataArray[indexPath.row];
                [cell setCellWithGoodImage:list.thumb title:list.title catName:list.catname typeName:list.typename editTime:list.editdate isVip:list.vip];
                return cell;
            }
                break;
            case Search_mall:
            {
                static NSString *cellIdentifier3 = @"mall";
                YHBShopsListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
                if (!cell) {
                    cell = [[YHBShopsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3];
                }
                YHBCRslist *list = dataArray[indexPath.row];
                [cell setUIWithImage:list.avatar title:list.company Name:list.truename Star1:list.star1 Star2:list.star2 GroupID:(int)list.groupid];
                return cell;
            }
                break;
            case Search_product:
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
    return nil;
}

#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        NSMutableArray *modelArray = self.modelsDic[[NSString stringWithFormat:@"%lu",_selectFilType * _selectSearchType]];
        if (modelArray.count > indexPath.row) {
            YHBRslist *model = modelArray[indexPath.row];
            switch (_selectSearchType) {
                case Search_buy:
                {
                    //求购
                }
                    break;
                case Search_sell:
                {
                    //供应
                }
                    break;
                case Search_mall:
                {
                    //店铺
                    YHBStoreViewController *vc = [[YHBStoreViewController alloc] initWithShopID:(int)((YHBCRslist *)model).userid];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case Search_product:
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

#pragma mark - Action

#pragma mark 通知搜索
- (void)shouldSearch:(NSNotification *)notf
{
    NSString *content = notf.userInfo[kSearchMessage];
    MLOG(@"%@",notf.userInfo);
    if (content.length) {
        UIButton *btn = (UIButton *)[self.segmentView viewWithTag:Search_product];
        if (btn && self.searchView) {
            [self touchSegButton:btn];
            self.searchTextField.text = content;
            MLOG(@"%@",content);
            [self touchSearchButton];
        }
    }
}

- (void)touchSegButton : (UIButton *)sender
{
    if (sender != _selectSegBtn) {
        if (_selectSegBtn) {
            _selectSegBtn.selected = NO;
            _selectSegBtn.backgroundColor = [UIColor whiteColor];
            NSArray *array;
            if ((array = self.modelsDic[[NSString stringWithFormat:@"%lu",_selectSearchType*_selectFilType]]) != nil) {
                [self.modelsDic removeObjectForKey:[NSString stringWithFormat:@"%lu",_selectSearchType*_selectFilType]];
                [self.tableView reloadData];
            }
        }
        [_secondBtn setTitle:(sender.tag == Search_product ? @"样板":@"仅看VIP") forState:UIControlStateNormal];
        _selectSegBtn = sender;
        _selectSegBtn.selected = YES;
        _selectSegBtn.backgroundColor = KColor;
        _selectSearchType = sender.tag;
        
    }
}

- (void)touchFilterButton : (UIButton *)sender
{
    if (sender != _selectFilBtn) {
        if (sender.tag == Filter_filt) {
#warning 弹出筛选页面
            UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:[CategoryViewController sharedInstancetype]];
            navVc.navigationBar.tintColor = KColor;
            __weak SecondViewController *weakself = self;
            [CategoryViewController sharedInstancetype].hidesBottomBarWhenPushed = YES;
            //navVc.hidesBottomBarWhenPushed = YES;
            [[CategoryViewController sharedInstancetype] setBlock:^(NSArray *aArray) {
                weakself.tagsArray = [NSMutableArray arrayWithArray:aArray];
                [weakself.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                MLOG(@"%@",weakself.tagsArray);
            }];
            [self.navigationController pushViewController:[CategoryViewController sharedInstancetype] animated:YES];
        }else{
            _selectFilBtn.selected = NO;
            _selectFilBtn = sender;
            _selectFilBtn.selected = YES;
            _selectFilType = _selectFilBtn.tag;
            NSArray *array;
            if ((array = self.modelsDic[[NSString stringWithFormat:@"%lu",_selectSearchType * _selectFilType]]) != nil) {
                [self.modelsDic removeObjectForKey:[NSString stringWithFormat:@"%lu",_selectSearchType * _selectFilType]];
                [self getFirstPageData];
            }
            
        }
    }
}
#pragma mark 点击搜索
- (void)touchSearchButton
{
    if ([self.searchTextField isFirstResponder]) {
        [self.searchTextField resignFirstResponder];
    }
    if ([self isNeedSearch]) {
        [self getFirstPageData];
    }else{
        [SVProgressHUD showErrorWithStatus:@"至少输入关键字或者选择筛选条件！" cover:NO offsetY:0];
    }
    
}

- (void)deleteSortTagWithTag:(NSInteger)tag
{
    [[CategoryViewController sharedInstancetype] deleteItemWithItemID:(int)tag];
    self.tagsArray = [[[CategoryViewController sharedInstancetype] getChooseArray] copy];
    MLOG(@"%@",self.tagsArray);
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - uitextfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (UIButton *)customSegmentButtonWithTitle:(NSString *)title andTag:(NSInteger)tag Frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    //[button setTitle:title forState:UIControlStateSelected];
    button.titleLabel.font = kFont18;
    button.tag = tag;
    button.selected = NO;
    [button addTarget:self action:@selector(touchSegButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UIButton *)customFilterButtonWithTitle:(NSString *)title Tag:(NSInteger)tag Frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = RGBCOLOR(254, 254, 254);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:KColor forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    //[button setTitle:title forState:UIControlStateSelected];
    button.titleLabel.font = kFont16;
    button.tag = tag;
    button.selected = NO;
    [button addTarget:self action:@selector(touchFilterButton:) forControlEvents:UIControlEventTouchUpInside];
    button.selected = NO;
    return button;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (BOOL)isNeedSearch
{
    if (self.searchTextField.text.length || self.tagsArray.count) {
        return YES;
    }else
        return NO;
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
