//
//  YHBShopMallViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/18.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShopMallViewController.h"
#import "YHBShopMallHeadView.h"
#import "YHBShopMallCell.h"
#import "YHBStoreViewController.h"

#define KimageHeight kMainScreenWidth*362/1080.0f

@interface YHBShopMallViewController ()<UITableViewDelegate,UITableViewDataSource,ShopMallCellDelegate>

@property (weak, nonatomic) UIPageControl *pageControl; //分页
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIScrollView *headScrollView;
@end

@implementation YHBShopMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商城";
    
    //UI
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //self.tableView.backgroundColor = kViewBackgroundColor;
    [self creatAddViewWithImageNum:1];
    self.tableView.tableHeaderView = _headScrollView;

    //网络请求 刷新数据
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.navigationController.navigationBar.hidden) {
        self.navigationController.navigationBarHidden = NO;
    }
}

#pragma mark - tableView delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeadViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kcellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YHBShopMallHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (!headView) {
        headView = [[YHBShopMallHeadView alloc] init];
    }
    headView.title = section ? @"店铺推荐" : @"产品推荐";
    return headView;
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    YHBShopMallCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[YHBShopMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    //TODO：设备cell内容
    cell.cellIndexPath = indexPath;
#warning 带载入数据
   //[cell clearCellContentParts];
    
    return cell;
}

//顶部浮动广告view
- (void)creatAddViewWithImageNum:(NSInteger)imageNum
{
    UIScrollView *headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, KimageHeight)];
    [headScrollView setBounces:NO];
    headScrollView.backgroundColor = RGBCOLOR(58, 155, 9);
    [headScrollView setShowsHorizontalScrollIndicator:NO];
    [headScrollView setContentSize:CGSizeMake(imageNum * kMainScreenWidth, KimageHeight)];
    headScrollView.delegate = self;
    for (NSInteger i = 1; i <= imageNum; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i-1) * kMainScreenWidth, 0, kMainScreenWidth, KimageHeight)];
        //设置image
        //imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"headAd%ld",(long)i]];
        [headScrollView addSubview:imageView];
        imageView.backgroundColor = RGBCOLOR(58, 155, 9);
        [headScrollView setPagingEnabled:YES];
        
    }
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [pageControl setBounds:CGRectMake(0, 0, 150.0, 50.0)];
    [pageControl setBounds:CGRectMake(0, 0, 150.0, 50.0)];
    [pageControl setCenter:CGPointMake(kMainScreenWidth/2, KimageHeight - 10)];
    [pageControl setNumberOfPages:imageNum];
    [pageControl setCurrentPage:0];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [pageControl setPageIndicatorTintColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.7 alpha:0.8]];
    [headScrollView addSubview:pageControl];
    self.pageControl = pageControl;
    self.headScrollView = headScrollView;
}

#pragma mark - Action
#pragma mark 点击店铺/商品
- (void)selectCellPartWithIndexPath:(NSIndexPath *)indexPath part:(NSInteger)part
{
    //MLOG(@"section:%ld row:%ld part:%ld",(long)indexPath.section,(long)indexPath.row,(long)part);
    if (indexPath.section == 1) {
        //店铺
#warning 待获取选择的店铺模型
        YHBStoreViewController *storeVC = [[YHBStoreViewController alloc] init];
        storeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:storeVC animated:YES];
        
    }else if (indexPath.section == 0){
        //商品
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
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
