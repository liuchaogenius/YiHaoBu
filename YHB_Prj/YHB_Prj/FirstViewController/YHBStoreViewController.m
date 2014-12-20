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

#define kSgmBtnHeight 35
#define kSelectTagBase 100
#define kToolBtnTagBase 200
#define kHeadHeight 110
#define kToolBarHeight 64
#define kToolItemImageWidth 25
#define kToolTitleFont 16
enum SgmBtn_tag
{
    SgmBtn_productInfo = kSelectTagBase, //产品信息
    SgmBtn_cellInfo,//供应信息
    SgmBtn_storeInfo//店铺信息
};
enum ToolButton_tag
{
    ToolBtn_phone = kToolBtnTagBase,//电话
    ToolBtn_message,//短信
    ToolBtn_online//在线交流
};

@interface YHBStoreViewController ()<UserHeadDelegate,UITableViewDataSource,UITableViewDelegate,ShopMallCellDelegate>
{
    UIButton *_selectSgmButton;
}
@property (strong, nonatomic) YHBUserHeadView *shopHeadView;
@property (strong, nonatomic) UIScrollView *sgmBtmScrollView;
@property (assign, nonatomic) NSInteger sgmCount;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UIView *toolBarView;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation YHBStoreViewController
#pragma mark - getter and setter

- (UIView *)toolBarView
{
    if (!_toolBarView) {
        _toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight-kToolBarHeight-64, kMainScreenWidth, kToolBarHeight)];
        _toolBarView.backgroundColor = [UIColor whiteColor];
        UIView *orangeLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 4)];
        orangeLine.backgroundColor = KColor;
        [_toolBarView addSubview:orangeLine];
        NSArray *titleArray = @[@"电话",@"短信",@"在线沟通"];
        CGFloat btnWidth = kMainScreenWidth/titleArray.count;
        for (int i = 0; i < titleArray.count; i++) {
            UIButton *btn = [self customToolButtonWithFrame:CGRectMake(i*btnWidth, orangeLine.bottom+8, btnWidth, _toolBarView.height-orangeLine.height) Image:[UIImage imageNamed:[NSString stringWithFormat:@"Comuticate_%d",i]] Title:titleArray[i]];
            btn.tag = i + kToolBtnTagBase;
            [btn addTarget:self action:@selector(touchToolBtn:) forControlEvents:UIControlEventTouchUpInside];
            //btn.backgroundColor = [UIColor greenColor];
            [_toolBarView addSubview:btn];
        }
    }
    return _toolBarView;
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"产品信息",@"供应信息",@"店铺信息"];
    }
    return _titleArray;
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
        [_sgmBtmScrollView setFrame:CGRectMake(0, kHeadHeight, kMainScreenWidth, kSgmBtnHeight)];
        _sgmBtmScrollView.backgroundColor = [UIColor whiteColor];
        //通过分栏数量调整content宽度
        CGFloat contentWidth = (self.sgmCount > 5 ? self.sgmCount*kMainScreenWidth/5.0f : kMainScreenWidth);
        [_sgmBtmScrollView setContentSize:CGSizeMake(contentWidth, kSgmBtnHeight)];
        
        //添加sgmButton
        CGFloat buttonWidth = (self.sgmCount>=5 ? kMainScreenWidth/5.0f : kMainScreenWidth/(float)self.sgmCount);
        for (int i = 0; i < self.sgmCount; i++) {
            UIButton *sgmButton = [self customButtonWithFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, kSgmBtnHeight) andTitle:self.titleArray[i]];
            sgmButton.tag = i + kSelectTagBase;//用tag%kSelectTagBase 来记录选中的分类
            if (i == 0) {
                sgmButton.selected = YES; //默认选择第一个
                _selectSgmButton = sgmButton;
            }
            [_sgmBtmScrollView addSubview:sgmButton];
        }
        
    }
    return _sgmBtmScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settitleLabel:@"商场"];
    
    //UI
    self.view.backgroundColor = kViewBackgroundColor;
    [self creatHeadView];
    [self.view addSubview:self.sgmBtmScrollView];
    [self.view addSubview:self.toolBarView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.sgmBtmScrollView.bottom, kMainScreenWidth, self.toolBarView.top-self.sgmBtmScrollView.bottom) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kViewBackgroundColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = kcellHeight;
    [self.view addSubview:self.tableView];
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

#pragma mark - tableView DataSource and Delegaet
#warning table待获取后台数据
#pragma mark 数据行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
    //[cell clearCellContentParts];
#warning 待载入数据 -cc
    
    return cell;
}

#pragma mark - action
- (void)touchSgmButton:(UIButton *)sender
{
#warning 待刷新tableview -cc
    if(_selectSgmButton.tag != sender.tag){
        if (sender.tag != SgmBtn_storeInfo) {
            _selectSgmButton.selected = NO;
            _selectSgmButton = sender;
            sender.selected = YES;
        }
        switch (sender.tag) {
            case SgmBtn_productInfo:
            {
                //产品信息
            }
                break;
            case SgmBtn_cellInfo:
            {
                //供应信息
            }
                break;
            case SgmBtn_storeInfo:
            {
                //店铺信息
                YHBShopInfoViewController *infoVC = [[YHBShopInfoViewController alloc] init];
                infoVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:infoVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

- (void)touchToolBtn:(UIButton *)sender
{
#warning 待验证用户登录状态,以及后续逻辑处理 -cc
    MLOG(@"touched");
    switch (sender.tag) {
        case ToolBtn_phone:
        {
            //电话
        }
            break;
        case ToolBtn_message:
        {
            //短信
        }
            break;
        case ToolBtn_online:
        {
            //在线沟通
        }
            break;
        default:
            break;
    }
}

#pragma mark - delegate

- (void)selectCellPartWithIndexPath : (NSIndexPath*)indexPath part:(NSInteger)part
{
    MLOG(@"touch Cell");
}


#pragma mark - customButtom构造
- (UIButton *)customButtonWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:KColor forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
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

- (UIButton *)customToolButtonWithFrame:(CGRect)frame Image:(UIImage *)image Title:(NSString *)title
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((button.width-kToolItemImageWidth)/2.0f, 0, kToolItemImageWidth, kToolItemImageWidth)];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    imageView.image = image;
    [button addSubview:imageView];
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom+5, button.width, kToolTitleFont)];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.textColor = [UIColor blackColor];
    titlelabel.font = [UIFont systemFontOfSize:kToolTitleFont];
    [titlelabel setTextAlignment:NSTextAlignmentCenter];
    titlelabel.text = title;
    [button addSubview:titlelabel];
    
    return button;
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
