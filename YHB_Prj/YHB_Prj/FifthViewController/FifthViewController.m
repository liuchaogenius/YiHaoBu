//
//  FifthViewController.m
//  YHB_Prj
//
//  Created by  striveliu on 14-11-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "FifthViewController.h"
#import "YHBShoppingCartTableViewCell.h"
#import "TableSectionFooterView.h"
#import "YHBShopCartManage.h"
#import "YHBShopCartRslist.h"
#import "YHBShopCartCartlist.h"
#import "SVProgressHUD.h"
#import "YHBProductDetailVC.h"
#import "TableSectionHeaderView.h"
#import "SVPullToRefresh.h"
#import "YHBOrderConfirmVC.h"

#define bottomHeight 60
@interface FifthViewController ()<UITableViewDataSource, UITableViewDelegate, ShoppingCartCellDelegate, TableViewHeaderViewDelegate>
{
    YHBShoppingCartTableViewCell *selectedCell;
    BOOL isAllSelected;
    UIButton *chooseBtn;
    NSMutableDictionary *selectedDict;
    NSMutableArray *selectedHeaderViewArray;
    UILabel *priceLabel;
    float price;
    BOOL isEdit;
    UIButton *editBtn;
    UIButton *accontBtn;
    UILabel *yunlabel;
//    UIButton *moveToFavoriteBtn;
    NSMutableArray *changeItemArray;
    NSMutableArray *changeModelArray;
}
@property(nonatomic, strong) YHBShopCartManage *netManage;
@property(nonatomic, strong) NSMutableArray *tableViewArray;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *bottomView;
@end

@implementation FifthViewController

- (void)viewWillAppear:(BOOL)animated
{
    if (self.tableViewArray.count==0)
    {
        [self showFlower];
        [self.netManage getShopCartArray:^(NSMutableArray *aArray) {
            self.tableViewArray = aArray;
            [self.tableView reloadData];
            [self dismissFlower];
        } andFail:^{
            [self dismissFlower];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedDict = [NSMutableDictionary new];
    selectedHeaderViewArray = [NSMutableArray new];
    isAllSelected = NO;
    [self settitleLabel:@"购物车"];
    self.netManage = [[YHBShopCartManage alloc] init];
    self.tableViewArray = [NSMutableArray new];
    changeItemArray = [NSMutableArray new];
    changeModelArray = [NSMutableArray new];
    price = 0;
    isEdit = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-62-49-bottomHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = RGBCOLOR(239, 239, 239);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
//右上编辑按钮
    editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = editButtonItem;
    
#pragma mark 下面的View
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, kMainScreenWidth, bottomHeight)];

    UIView *toplineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 0.5)];
    toplineView.backgroundColor = [UIColor lightGrayColor];
    [self.bottomView addSubview:toplineView];
    
    chooseBtn = [[UIButton alloc]
                           initWithFrame:CGRectMake(10, (bottomHeight-25)/2, 25, 25)];
    [chooseBtn addTarget:self action:@selector(allSelected) forControlEvents:UIControlEventTouchUpInside];
//    chooseBtn.layer.borderColor = [[UIColor blackColor] CGColor];
//    chooseBtn.layer.borderWidth = 0.5;
    [chooseBtn setImage:[UIImage imageNamed:@"shopNotChooseImg"] forState:UIControlStateNormal];
    [self.bottomView addSubview:chooseBtn];
    
    UILabel *allLabel = [[UILabel alloc] initWithFrame:CGRectMake(chooseBtn.right+5, chooseBtn.top, 40, 20)];
    allLabel.font = kFont14;
    allLabel.textColor = [UIColor lightGrayColor];
    allLabel.text = @"全选";
    [self.bottomView addSubview:allLabel];

    accontBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-90, (bottomHeight-30)/2, 80, 30)];
    accontBtn.backgroundColor = KColor;
    [accontBtn setTitle:@"结算" forState:UIControlStateNormal];
    [accontBtn addTarget:self action:@selector(touchAccontBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:accontBtn];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(accontBtn.left-150, accontBtn.top+3, 110, 15)];
    priceLabel.font = kFont14;
    priceLabel.textColor = [UIColor redColor];
    priceLabel.text = @"合计 : 0.00";
    priceLabel.textAlignment = NSTextAlignmentRight;
    [self.bottomView addSubview:priceLabel];
    
    yunlabel = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.right-60, priceLabel.bottom+3, 60, 12)];
    yunlabel.font = kFont12;
    yunlabel.textColor = [UIColor lightGrayColor];
    yunlabel.text = @"不含运费";
    yunlabel.textAlignment = NSTextAlignmentRight;
    [self.bottomView addSubview:yunlabel];
    
//    moveToFavoriteBtn = [[UIButton alloc] initWithFrame:CGRectMake(accontBtn.left-160, accontBtn.top, 140, 30)];
//    [moveToFavoriteBtn setTitle:@"移动至收藏夹" forState:UIControlStateNormal];
//    moveToFavoriteBtn.backgroundColor = KColor;
//    moveToFavoriteBtn.titleLabel.font = kFont15;
//    [moveToFavoriteBtn addTarget:self action:@selector(moveToFavorite) forControlEvents:UIControlEventTouchUpInside];
//    moveToFavoriteBtn.hidden = YES;
//    [self.bottomView addSubview:moveToFavoriteBtn];
    
    [self.view addSubview:self.bottomView];
//以上是bottomView
    
    [self showFlower];
    [self addTableViewTrag];
    [self.netManage getShopCartArray:^(NSMutableArray *aArray) {
        self.tableViewArray = aArray;
        [self.tableView reloadData];
        [self dismissFlower];
    } andFail:^{
        [self dismissFlower];
    }];
}
#pragma mark 移动至收藏夹
- (void)moveToFavorite
{
    
}

#pragma mark 编辑
- (void)edit
{
    [chooseBtn setImage:[UIImage imageNamed:@"shopNotChooseImg"] forState:UIControlStateNormal];
    [selectedDict removeAllObjects];
    [selectedHeaderViewArray removeAllObjects];
    price=0;
    isAllSelected = NO;
    [self changePrice:price];
    if (isEdit)
    {
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [accontBtn setTitle:@"结算" forState:UIControlStateNormal];
        priceLabel.hidden = NO;
        yunlabel.hidden = NO;
        self.tableView.allowsSelection = YES;
        if (changeModelArray.count>0)
        {
            for(NSDictionary *paramDict in changeModelArray)
            {
                int section = [[paramDict objectForKey:@"section"] intValue];
                NSString *number = [paramDict objectForKey:@"number"];
                int row = [[paramDict objectForKey:@"row"] intValue];
                YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:section];
                YHBShopCartCartlist *cartModel = [model.cartlist objectAtIndex:row];
                cartModel.number = number;
            }
            [self.netManage changeShopCartWithArray:changeItemArray andSuccBlock:^{
                changeItemArray = [NSMutableArray new];
                changeModelArray = [NSMutableArray new];
            } failBlock:^{
                
            }];
        }
//        moveToFavoriteBtn.hidden = YES;
    }
    else
    {
        [editBtn setTitle:@"完成" forState:UIControlStateNormal];
        [accontBtn setTitle:@"删除" forState:UIControlStateNormal];
        priceLabel.hidden = YES;
        yunlabel.hidden = YES;
        self.tableView.allowsSelection = NO;
//        moveToFavoriteBtn.hidden = NO;

    }
    isEdit = !isEdit;
    [self.tableView reloadData];
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak FifthViewController *weakself = self;
    [weakself.tableView addPullToRefreshWithActionHandler:^{
        [self.netManage getShopCartArray:^(NSMutableArray *aArray) {
            [weakself.tableView.pullToRefreshView stopAnimating];
            self.tableViewArray = aArray;
            [self.tableView reloadData];
        } andFail:^{
            [weakself.tableView.pullToRefreshView stopAnimating];
        }];
    }];
    
    
    [weakself.tableView addInfiniteScrollingWithActionHandler:^{
        if(self.tableViewArray.count%10==0&&self.tableViewArray.count>0)
        {
            [self.netManage getNextShopCartArray:^(NSMutableArray *aArray) {
                [weakself.tableView.infiniteScrollingView stopAnimating];
                [self.tableViewArray addObjectsFromArray:aArray];
                [self.tableView reloadData];
            } andFail:^{
                [weakself.tableView.infiniteScrollingView stopAnimating];
            }];
        }
        else
        {
            [weakself.tableView.infiniteScrollingView stopAnimating];
        }
    }];
}


#pragma mark AllSelected
- (void)allSelected
{
    if (self.tableViewArray.count>0)
    {
        price=0;
        if (isAllSelected)
        {
            [chooseBtn setImage:[UIImage imageNamed:@"shopNotChooseImg"] forState:UIControlStateNormal];
            [selectedDict removeAllObjects];
            [selectedHeaderViewArray removeAllObjects];
            price=0;
        }
        else
        {
            [chooseBtn setImage:[UIImage imageNamed:@"shopChooseImg"] forState:UIControlStateNormal];
            selectedHeaderViewArray = [NSMutableArray new];
            for (int i=0; i<self.tableViewArray.count; i++) {
                [selectedHeaderViewArray addObject:[NSString stringWithFormat:@"%d", i]];
                NSMutableArray *mutableArray = [NSMutableArray new];
                YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:i];
                NSArray *array = model.cartlist;
                for (int j=0; j<array.count; j++) {
                    [mutableArray addObject:[NSString stringWithFormat:@"%d", j]];
                    YHBShopCartCartlist *cartModel = [array objectAtIndex:j];
                    price += [cartModel.price floatValue]*[cartModel.number floatValue];
                }
                [selectedDict setObject:mutableArray forKey:[NSString stringWithFormat:@"%d", i]];
            }
        }
        isAllSelected = !isAllSelected;
        [self changePrice:price];
        [self.tableView reloadData];
    }
}

- (void)allSelectedNo
{
    [chooseBtn setImage:[UIImage imageNamed:@"shopNotChooseImg"] forState:UIControlStateNormal];
    isAllSelected=NO;
}

- (void)allSelectedYes
{
    [chooseBtn setImage:[UIImage imageNamed:@"shopChooseImg"] forState:UIControlStateNormal];
    isAllSelected = YES;
}

#pragma mark tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableSectionHeaderView *view = [[TableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 10, kMainScreenWidth, 40)];
    view.index = section;
    view.headerViewDelegate = self;
    for (int i=0; i<selectedHeaderViewArray.count; i++) {
        NSString *str = [selectedHeaderViewArray objectAtIndex:i];
        if (section==[str intValue]) {
            view.isSelected = YES;
            [view chooseBtnYes];
            break;
        }
    }
    YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:section];
    [view setName:model.company];
    return view;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 30;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    TableSectionFooterView *view = [[TableSectionFooterView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
//    YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:section];
//    [view setViewWith:model];
//    return view;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:section];
    return model.cartlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHBShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[YHBShoppingCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    cell.section = (int)indexPath.section;
    cell.row = (int)indexPath.row;
    [cell selectedBtnNo];
    if (isAllSelected)
    {
        [cell selectedBtnYes];
    }
    else
    {
        NSMutableArray *mutableArray = [selectedDict objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.section]];
        if (mutableArray) {
            for (int i=0; i<mutableArray.count; i++) {
                NSString *str = [mutableArray objectAtIndex:i];
                if (indexPath.row == [str integerValue]) {
                    [cell selectedBtnYes];
                }
            }
        }
    }
    YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:indexPath.section];
    YHBShopCartCartlist *cartModel = [model.cartlist objectAtIndex:indexPath.row];
    [cell setCellWithModel:cartModel];
    [cell isEdit:isEdit];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:indexPath.section];
    YHBShopCartCartlist *cartModel = [model.cartlist objectAtIndex:indexPath.row];
    YHBProductDetailVC *vc = [[YHBProductDetailVC alloc] initWithProductID:(int)cartModel.itemid];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 自己的delegate
- (void)changeCountWithItemId:(NSString *)aItemid andCount:(float)aCount WithSection:(int)aSection row:(int)aRow isStay:(BOOL)aBool
{
    int j=0;
    for(int i=0; i<changeItemArray.count; i++)
    {
        NSDictionary *paramDict = [changeItemArray objectAtIndex:i];
        NSString *paramItemid = [paramDict objectForKey:@"itemid"];
        j++;
        if ([paramItemid isEqualToString:aItemid])
        {
            if (aBool)
            {
                [changeItemArray removeObjectAtIndex:i];
                [changeModelArray removeObjectAtIndex:i];
                break;
            }
            else
            {
                [changeItemArray removeObjectAtIndex:i];
                [changeModelArray removeObjectAtIndex:i];
                NSDictionary *itemDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%.1f", aCount],@"number",aItemid,@"itemid", nil];
                NSDictionary *modelDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%.1f", aCount],@"number",[NSString stringWithFormat:@"%d", aSection],@"section",[NSString stringWithFormat:@"%d", aRow],@"row",nil];
                [changeItemArray addObject:itemDict];
                [changeModelArray addObject:modelDict];
                break;
            }
        }
    }
    if (j==changeItemArray.count)
    {
        NSDictionary *itemDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%.1f", aCount],@"number",aItemid,@"itemid", nil];
        NSDictionary *modelDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%.1f", aCount],@"number",[NSString stringWithFormat:@"%d", aSection],@"section",[NSString stringWithFormat:@"%d", aRow],@"row",nil];
        [changeItemArray addObject:itemDict];
        [changeModelArray addObject:modelDict];
    }
}

- (void)touchCell:(YHBShoppingCartTableViewCell *)aCell WithSection:(int)aSection row:(int)aRow
{
    YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:aSection];
    NSArray *array = model.cartlist;
    YHBShopCartCartlist *cartModel = [array objectAtIndex:aRow];
    if (aCell.isSelected)
    {
        [self allSelectedNo];
        [selectedHeaderViewArray removeObject:[NSString stringWithFormat:@"%d", aSection]];
        NSMutableArray *mutableArray = [selectedDict objectForKey:[NSString stringWithFormat:@"%d", aSection]];
        [mutableArray removeObject:[NSString stringWithFormat:@"%d", aRow]];
        [selectedDict setObject:mutableArray forKey:[NSString stringWithFormat:@"%d", aSection]];
        price -= [cartModel.price floatValue]*[cartModel.number floatValue];
    }
    else
    {
        price+=[cartModel.price floatValue]*[cartModel.number floatValue];
        NSMutableArray *mutableArray = [selectedDict objectForKey:[NSString stringWithFormat:@"%d", aSection]];
        if (!mutableArray) {
            mutableArray = [NSMutableArray new];
        }
        [mutableArray addObject:[NSString stringWithFormat:@"%d", aRow]];
        [selectedDict setObject:mutableArray forKey:[NSString stringWithFormat:@"%d", aSection]];
        YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:aSection];
        NSArray *array = model.cartlist;
        if (array.count==mutableArray.count)
        {
            [selectedHeaderViewArray addObject:[NSString stringWithFormat:@"%d", aSection]];
        }
        [self toSeeIsAllSelected];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:aSection] withRowAnimation:UITableViewRowAnimationNone];
    [self changePrice:price];
}

#pragma mark tabelHeaderViewDelegate
- (void)selectHeadViewWithView:(TableSectionHeaderView *)aView Index:(long)aIndex
{
    YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:aIndex];
    NSArray *array = model.cartlist;
    float temPrice = 0;
    for (int i=0; i<array.count; i++) {
        YHBShopCartCartlist *cartModel = [array objectAtIndex:i];
        temPrice += [cartModel.price floatValue]*[cartModel.number floatValue];
    }
    if (aView.isSelected)
    {
        [self allSelectedNo];
        [selectedDict removeObjectForKey:[NSString stringWithFormat:@"%ld", aIndex]];
        [selectedHeaderViewArray removeObject:[NSString stringWithFormat:@"%ld", aIndex]];
        price -= temPrice;
        [self changePrice:price];
    }
    else
    {
        price += temPrice;
        [selectedHeaderViewArray addObject:[NSString stringWithFormat:@"%ld", aIndex]];
        YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:aIndex];
        NSArray *array = model.cartlist;
        NSMutableArray *temArray = [selectedDict objectForKey:[NSString stringWithFormat:@"%ld", aIndex]];
        for (int i=0; i<temArray.count; i++)
        {
            NSString *str = [temArray objectAtIndex:i];
            YHBShopCartCartlist *cartModel = [array objectAtIndex:[str intValue]];
            price -= [cartModel.price floatValue]*[cartModel.number floatValue];
        }
        NSMutableArray *mutableArray = [NSMutableArray new];
        for (int j=0; j<array.count; j++) {
            [mutableArray addObject:[NSString stringWithFormat:@"%d", j]];
        }
        [selectedDict setObject:mutableArray forKey:[NSString stringWithFormat:@"%ld", aIndex]];
        [self changePrice:price];
        [self toSeeIsAllSelected];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:aIndex] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 判定是否全选
- (void)toSeeIsAllSelected
{
    int j=0;
    for (int i=0; i<self.tableViewArray.count; i++)
    {
        YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:i];
        NSArray *array = model.cartlist;
        NSMutableArray *mutableArray = [selectedDict objectForKey:[NSString stringWithFormat:@"%d", i]];
        if (array.count!=mutableArray.count || !mutableArray) {
            break;
        }
        j++;
    }
    if (j==self.tableViewArray.count) {
        [self allSelectedYes];
    }
}

#pragma mark 改变价格
- (void)changePrice:(float)aPrice
{
    priceLabel.text = [NSString stringWithFormat:@"合计 : %.2f", aPrice];
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

#pragma mark 完成
- (void)touchAccontBtn
{
    if (isEdit)
    {
        NSMutableArray *itemidArray = [NSMutableArray new];
        NSArray *keyArray = [selectedDict allKeys];
        for (int i=0; i<keyArray.count; i++)
        {
            NSString *section = [keyArray objectAtIndex:i];
            NSArray *temarray = [selectedDict objectForKey:section];
            NSArray *array = [temarray sortedArrayUsingSelector:@selector(compare:)];
            for (int j=(int)array.count-1; j>=0; j--)
            {
                NSString *row = [array objectAtIndex:j];
                YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:[section intValue]];
                YHBShopCartCartlist *cartModel = [model.cartlist objectAtIndex:[row intValue]];
                NSString *itemid = [NSString stringWithFormat:@"%d", (int)cartModel.itemid];
                [itemidArray addObject:itemid];
                [model.cartlist removeObject:cartModel];
                if (model.cartlist.count==0)
                {
                    [self.tableViewArray removeObject:model];
                }
            }
        }
        [selectedDict removeAllObjects];
        [selectedHeaderViewArray removeAllObjects];
        isAllSelected = NO;
        [self.tableView reloadData];
        [self.netManage deleteShopCartWithArray:itemidArray andSuccBlock:^{
            
        } failBlock:^{
            
        }];
    }
    else
    {
        NSMutableArray *resultArray = [NSMutableArray new];
        NSArray *keyArray = [selectedDict allKeys];
        for (NSString *str in keyArray)
        {
            NSArray *array = [selectedDict objectForKey:str];
            YHBShopCartRslist *model = [self.tableViewArray objectAtIndex:[str intValue]];
            for (NSString *itemStr in array)
            {
                YHBShopCartCartlist *cartModel = [model.cartlist objectAtIndex:[itemStr intValue]];
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", (int)cartModel.itemid],@"itemid",cartModel.number,@"number",[NSString stringWithFormat:@"%d", (int)cartModel.skuid],@"skuid",nil];

                [resultArray addObject:dict];
            }
        }
        YHBOrderConfirmVC *vc = [[YHBOrderConfirmVC alloc] initWithSource:@"cart" requestArray:resultArray];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        }
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
