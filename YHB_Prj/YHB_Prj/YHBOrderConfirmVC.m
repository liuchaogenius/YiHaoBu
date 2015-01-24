//
//  YHBOrderConfirmVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderConfirmVC.h"
#import "YHBOrderAddressView.h"
#import "YHBOrderShopHeadView.h"
#import "YHBOrderConfirmCell.h"
#import "YHBOConfirmModel.h"
#import "YHBOrderManager.h"
#import "YHBOrderShopHeadView.h"
#import "YHBUser.h"
#import "SVProgressHUD.h"
#import "YHBOConfirmMalllist.h"
#import "YHBOConfirmRslist.h"
#import "YHBOConfirmExpress.h"
#import "CCEditTextView.h"
#define kBarHeight 80
#define kPriceFont 17
@interface YHBOrderConfirmVC ()<UITableViewDataSource,UITableViewDelegate,YHBOrderConfirmCellDelegate>
{
    NSString *_priceStr;
    UILabel *_titleLabel;
    NSArray *_payPathArr;
    double _price;
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) YHBOrderAddressView *addressView;
@property (strong, nonatomic) YHBOConfirmModel *orderConfirmModel;
@property (strong, nonatomic) YHBOrderManager *orderManager;
@property (strong, nonatomic) UIView *priceBar;
@property (strong, nonatomic) UIButton *payBtn;
@property (strong, nonatomic) UILabel *priceLabel;


@property (strong, nonatomic) NSString *sourse;
@property (strong, nonatomic) NSArray *requestArray;
@property (strong, nonatomic) NSMutableDictionary *expressSelDic;
@property (strong, nonatomic) NSMutableDictionary *messagesDic;

@property (nonatomic,strong) UIImageView *alipayLogoImgview;


@end

@implementation YHBOrderConfirmVC
#pragma mark - Getter and Setter

- (NSMutableDictionary *)messagesDic
{
    if (!_messagesDic) {
        _messagesDic = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return _messagesDic;
}

- (UIView *)priceBar
{
    if (!_priceBar) {
        _priceBar = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight-20-44-kBarHeight, kMainScreenWidth, kBarHeight)];
        _priceBar.backgroundColor = [UIColor whiteColor];
        _priceBar.layer.borderWidth = 1.0;
        _priceBar.layer.borderColor = [kLineColor CGColor];
        
        self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.frame = CGRectMake(10, kBarHeight-35-10, kMainScreenWidth-20, 35);
        [_payBtn setBackgroundColor:KColor];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(touchPayBtn) forControlEvents:UIControlEventTouchUpInside];
        [_priceBar addSubview:_payBtn];
        _payBtn.enabled = NO;
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-20, 10, 10, kPriceFont)];
        self.priceLabel.font = [UIFont systemFontOfSize:kPriceFont];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.textColor = KColor;
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        [self resetPriceLabel];
        [_priceBar addSubview:self.priceLabel];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLabel.left-65, 17, 75, 12)];
        _titleLabel.text = @"合计(含运费)：";
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = KColor;
        _titleLabel.font = kFont10;
        [_priceBar addSubview:_titleLabel];
        
    }
    return _priceBar;
}

- (YHBOrderAddressView *)addressView
{
    if (!_addressView) {
        _addressView = [[YHBOrderAddressView alloc] init];
    }
    return _addressView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20-44-kBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = kShopHeadHeight;
    }
    return _tableView;
}

- (YHBOrderManager *)orderManager
{
    if (!_orderManager) {
        _orderManager = [YHBOrderManager sharedManager];
    }
    return _orderManager;
}
- (instancetype)initWithSource:(NSString *)source requestArray:(NSArray *)rArray
{
    self = [super init];
    if (self) {
        self.sourse = source?:@"";
        self.requestArray = rArray;
        _priceStr = @"￥0.0";
        _payPathArr = @[@"      支付宝支付"];
        _price = 0;
        self.title = @"确认订单";
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self registerForKeyboradNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.priceBar];
    self.tableView.tableHeaderView = self.addressView;
    self.view.backgroundColor = kViewBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];

    if (self.requestArray.count) {
        __weak YHBOrderConfirmVC *weakself = self;
        [self.orderManager getOrderConfirmWithToken:([YHBUser sharedYHBUser].token ? :@"") source:self.sourse?:@"" ListArray:self.requestArray?:@[@""] Success:^(YHBOConfirmModel *model) {
            weakself.orderConfirmModel = model;
            [weakself.tableView reloadData];
            [weakself reloadHeader];
            [weakself priceCalculate];
            weakself.payBtn.enabled = YES;
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"读取订单信息失败，请重新尝试！" cover:YES offsetY:0];
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"发生错误!" cover:YES offsetY:0];
    }
    
}

- (void)reloadHeader
{
    if (self.orderConfirmModel.buyerAddress.length) {
        [self.addressView setUIWithName:self.orderConfirmModel.buyerName Address:self.orderConfirmModel.buyerAddress Phone:self.orderConfirmModel.buyerMobile];
    }else{
#warning 弹出地址页面，用户添加地址-cc
    }
    
}

#pragma mark - 数据源方法
#pragma mark 数据行数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.orderConfirmModel) {
        return self.orderConfirmModel.rslist.count+1;
    }else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.orderConfirmModel) {
        return self.orderConfirmModel.rslist.count == indexPath.section ?  44 : kOrderCellHeight;
    }else return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.orderConfirmModel) {
        if (self.orderConfirmModel.rslist.count == section) {
            return _payPathArr.count;
        }else{
            NSArray *listArray = ((YHBOConfirmRslist *)self.orderConfirmModel.rslist[section]).malllist;
            return listArray.count;
        }
        
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headIdentifier = @"head";
    
    YHBOrderShopHeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    if (!view) {
        view = [[YHBOrderShopHeadView alloc] initWithReuseIdentifier:headIdentifier];
    }
    if(section < self.orderConfirmModel.rslist.count){
        YHBOConfirmRslist *model = self.orderConfirmModel.rslist[section];
        [view setUIWithTitle:(model.sellcom?:@"")];
    }else{
        [view setUIWithTitle:@"选择支付方式："];
    }
   
    return view;
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.orderConfirmModel.rslist.count) {
        static NSString *cellIdentifier = @"Cell";
        YHBOrderConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[YHBOrderConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.delegate = self;
        }
        cell.cellIndexPath = indexPath;
        NSArray *listArray = ((YHBOConfirmRslist *)self.orderConfirmModel.rslist[indexPath.section]).malllist;
        YHBOConfirmMalllist *model = listArray[indexPath.row];
        
        [cell setUIWithTitle:model.title sku:model.skuname price:model.price number:model.number isFloat:[model.unit1 isEqualToString:@"米"] message:self.messagesDic[[self expressKeyWithI:(int)indexPath.section andJ:(int)indexPath.row]]];
        
        return cell;
    }else{
        static NSString *payCell = @"payCell"; //支付
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payCell];
            UIButton *selectButton = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-20-30, (44-20)/2.0f, 20, 20)];
            selectButton.tag = 100;
            [selectButton setBackgroundImage:[UIImage imageNamed:@"selectOff"] forState:UIControlStateNormal];
            [selectButton addTarget:self action:@selector(touchSelBtn) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:selectButton];
        }
        
        UIButton *selectButton = (UIButton *)[cell viewWithTag:100];
#warning 今后待需要更多支付方式时在此 处理默认支付方式
        if(indexPath.row == 0)
        {
            [selectButton setBackgroundImage:[UIImage imageNamed:@"selectOn"] forState:UIControlStateNormal];
        }
        //
        cell.textLabel.text = [_payPathArr objectAtIndex:indexPath.row];
        if(!self.alipayLogoImgview)
        {
            UIImage *img = [UIImage imageNamed:@"alipay_logo"];
            self.alipayLogoImgview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
            self.alipayLogoImgview.contentMode = UIViewContentModeScaleAspectFill;
            [self.alipayLogoImgview setImage:img];
            [cell addSubview:self.alipayLogoImgview];
        }
        return cell;

    }
    
}

#pragma mark - Action
#pragma mark 点击支付
- (void)touchPayBtn
{

}

- (void)touchSelBtn
{
    //选择支付方式
}
#pragma mark - 产品数量改变
- (void)numberChangedWithValue:(NSString *)num IndexPath:(NSIndexPath *)indexPath
{
    YHBOConfirmMalllist *model = ((YHBOConfirmRslist *)(self.orderConfirmModel.rslist[indexPath.section])).malllist[indexPath.row];
    model.number = num;
    [self priceCalculate];
    
}

#pragma mark 价格计算
- (void)priceCalculate
{
    _price = 0;
    for (int i = 0; i <self.orderConfirmModel.rslist.count; i++) {
        YHBOConfirmRslist *rlist = self.orderConfirmModel.rslist[i];
        for (int j = 0; j < rlist.malllist.count; j++) {
            YHBOConfirmMalllist *mall = rlist.malllist[j];
            NSInteger index = 0;
            if (self.expressSelDic[[self expressKeyWithI:i andJ:j]]) {
                index = [self.expressSelDic[[self expressKeyWithI:i andJ:j]] integerValue];
            }
            YHBOConfirmExpress *express = mall.express[index];
            double number = [mall.number doubleValue];
            double start = [express.start doubleValue];
            double step = [express.step doubleValue];
            MLOG(@"%f %f",number, [mall.price doubleValue]);
            _price += ([mall.price doubleValue] * number + (number<1.0 ? start : ((number - 1.0) * step + start)));
            MLOG(@"%lf",_price);
        }
    }
    _priceStr = [NSString stringWithFormat:@"￥%.1lf",_price];
    [self resetPriceLabel];
}



-(void)resetPriceLabel
{
    CGSize size = [_priceStr sizeWithFont:[UIFont systemFontOfSize:kPriceFont] constrainedToSize:CGSizeMake(kMainScreenWidth-20, _priceLabel.height)];
    [_priceLabel setFrame:CGRectMake(kMainScreenWidth-10-size.width, 10, size.width, size.height)];
    _priceLabel.text = _priceStr;
    if (_titleLabel) {
        _titleLabel.right = _priceLabel.left;
    }
}

#pragma mark - 留言 delagte Action

- (void)touchMessageTextField:(UITextField *)textField IndexPath:(NSIndexPath *)indexPath
{
    __weak YHBOrderConfirmVC *weakself = self;
    [[CCEditTextView sharedView] showEditTextViewWithTitle:@"买家留言" textfieldText:textField.text comfirmBlock:^(NSString *text) {
        weakself.messagesDic[[weakself expressKeyWithI:(int)indexPath.section andJ:(int)indexPath.row]] = text;
        textField.text = text;
    } cancelBlock:^{
        
    }];
}

#pragma mark - keyboard notification

- (void)keybordWillShow:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    MLOG(@"通知--%@",(UITextField *)value);
    
    
}

- (void)keyboardDidShow:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    self.tableView.centerY -= keyboardSize.height-kBarHeight;
    
}

- (void)keyboardWillHid:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    self.tableView.top = 0;
}

- (void)keyboardDidHid:(NSNotification *)notif
{
    
}

- (void)registerForKeyboradNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHid:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHid:) name:UIKeyboardDidHideNotification object:nil];
}

- (NSString *)expressKeyWithI:(int)i andJ:(int)j
{
    return [NSString stringWithFormat:@"%d",100*i+j];
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
