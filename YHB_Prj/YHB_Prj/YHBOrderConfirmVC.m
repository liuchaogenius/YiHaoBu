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
#import "YHBAddressModel.h"
#import "YHBAddressEditViewController.h"
#import "YHBAdressListViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JSONKit.h"
#import "YHBPaySuccessVC.h"
#import "YHBOrderDetailViewController.h"
//#import "AlixPayResult.h"
#define kBarHeight 80
#define kPriceFont 17
#define kButtonTag_Cancel 202
@interface YHBOrderConfirmVC ()<UITableViewDataSource,UITableViewDelegate,YHBOrderConfirmCellDelegate,UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,YHBAddressListDelegate,UIAlertViewDelegate>
{
    NSString *_priceStr;
    UILabel *_titleLabel;
    NSArray *_payPathArr;
    double _price;
    UIButton *_cancelBtn;
    NSIndexPath *_selIndexPath;
    YHBOConfirmExpress *_selExpress;
    NSString *_payMoneyInfo;//需支付价格信息
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) YHBOrderAddressView *addressView;
@property (strong, nonatomic) YHBOConfirmModel *orderConfirmModel;
@property (strong, nonatomic) YHBOrderManager *orderManager;
@property (strong, nonatomic) UIView *priceBar;
@property (strong, nonatomic) UIButton *payBtn;
@property (strong, nonatomic) UILabel *priceLabel;


@property (strong, nonatomic) NSString *sourse;//来源 购物车 产品页
@property (strong, nonatomic) NSArray *requestArray;
@property (strong, nonatomic) NSMutableDictionary *expressSelDic;//快递选择结果s字典
@property (strong, nonatomic) NSMutableDictionary *messagesDic;//留言s字典
@property (strong, nonatomic) UIView *clearView;
@property (strong, nonatomic) UIButton *tool;
@property (strong, nonatomic) UIPickerView *expressPicker;

@property (nonatomic,strong) UIImageView *alipayLogoImgview;
@property (strong, nonatomic) NSMutableDictionary *postDic; //请求提交字典

@property (strong, nonatomic) NSArray *orderIDArray;//订单id数组

@end

@implementation YHBOrderConfirmVC
#pragma mark - Getter and Setter
- (UIPickerView *)expressPicker
{
    if (!_expressPicker) {
        _expressPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight, kMainScreenWidth, 200)];
        _expressPicker.backgroundColor = [UIColor whiteColor];
        _expressPicker.dataSource =self;
        _expressPicker.delegate = self;
        _expressPicker.showsSelectionIndicator = YES;
    }
    return _expressPicker;
}

- (NSMutableDictionary *)messagesDic
{
    if (!_messagesDic) {
        _messagesDic = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return _messagesDic;
}

- (NSMutableDictionary *)expressSelDic
{
    if (!_expressSelDic) {
        _expressSelDic = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return _expressSelDic;
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
        [_payBtn setBackgroundColor:[UIColor lightGrayColor]];
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
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAddressHead)];
        [_addressView addGestureRecognizer:gr];
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayresult:) name:kAlipayOrderResultMessage object:nil];
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
    if (_payBtn && self.orderConfirmModel.addAddress.length<1) {
        _payBtn.enabled = NO;
        _payBtn.backgroundColor = [UIColor lightGrayColor];
    }
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.priceBar];
    self.tableView.tableHeaderView = self.addressView;
    self.view.backgroundColor = kViewBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
    [self getDataAndSetUI];
}

#pragma mark - 网络数据请求 并设置UI

- (void)getDataAndSetUI
{
    self.orderConfirmModel = nil;
    if (self.requestArray.count) {
        __weak YHBOrderConfirmVC *weakself = self;
        [self.orderManager getOrderConfirmWithToken:([YHBUser sharedYHBUser].token ? :@"") source:self.sourse?:@"" ListArray:self.requestArray?:@[@""] Success:^(YHBOConfirmModel *model) {
            weakself.orderConfirmModel = model;
            [weakself.tableView reloadData];
            [weakself reloadHeader];
            [weakself priceCalculate];
        } failure:^(NSInteger result, NSString *error) {
            if (result == -1) {
                //没有默认地址
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还没有设置收货地址" message:@"现在就添加收货地址？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"添加", nil];
                [alertView show];
            }else{
                [SVProgressHUD showErrorWithStatus:error cover:YES offsetY:0];
            }
            
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"发生错误!" cover:YES offsetY:0];
    }
}
//刷新地址view
- (void)reloadHeader
{
    [self.addressView setUIWithName:self.orderConfirmModel.addTruename Address:self.orderConfirmModel.addAddress Phone:self.orderConfirmModel.addMobile];
    [self.payBtn setBackgroundColor:KColor];
    self.payBtn.enabled = YES;
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
        YHBOConfirmExpress *express = self.expressSelDic[[self expressKeyWithI:(int)indexPath.section andJ:(int)indexPath.row]];
        if (!express && model.express.count) {
            express = model.express[0];
        }
        NSString *exPricie = [NSString stringWithFormat:@"%d",(int)[self expressPriceWithExpress:express andNum:[model.number doubleValue]]];
        [cell setUIWithTitle:model.title sku:model.skuname price:model.price number:model.number isFloat:!(int)model.typeid message:self.messagesDic[[self expressKeyWithI:(int)indexPath.section andJ:(int)indexPath.row]] Express:express.name exPrice:exPricie];
        
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
    MLOG(@"pay");
    if (self.postDic) {
        [SVProgressHUD showWithStatus:@"下单中..." cover:YES offsetY:0];
        self.orderIDArray = nil;
        [self.orderManager postOrderWithPostDic:self.postDic Success:^(NSString *info, NSArray *itemArray, NSString *ordermoney, NSString *overmoney, NSString *realmoney) {
            //info 拼接好的支付宝字段
            [SVProgressHUD dismissWithSuccess:@"下单成功"];
            self.orderIDArray = [itemArray copy];
            _payMoneyInfo = [NSString stringWithFormat:@"订单总金额:%@ 余额支付:%@ 实际支付金额:%@",ordermoney,overmoney,realmoney];
            //MLOG(@"info:%@",info);
            if ([realmoney isEqualToString:@"0.00"]) {
                //余额支付
                YHBPaySuccessVC *sVc = [[YHBPaySuccessVC alloc] initWithAppendInfo:_payMoneyInfo];
                [self.navigationController pushViewController:sVc animated:YES];
            }else if (info) {
                //支付宝支付
                static NSString *strSchem = @"com.yibu.kuaibu";
                [[AlipaySDK defaultService] payOrder:info fromScheme:strSchem callback:^(NSDictionary *resultDic) {
                    MLOG(@"%@",resultDic);
                    [[NSNotificationCenter defaultCenter] postNotificationName:kAlipayOrderResultMessage object:resultDic];
                }];
            }
        } failure:^(NSString *error) {
            
            [SVProgressHUD dismissWithError:error];
        }];
    }
    
}


- (void)aliPayresult:(NSNotification *)aNotification
{
    MLOG(@"resultDic :  %@",aNotification);
    
    NSDictionary *resultDic = [aNotification object];
    
    if(resultDic && resultDic.count)
    {
        MLOG(@"notificationDict = %@",resultDic);
        int resultStatus = [[resultDic objectForKey:@"resultStatus"] intValue];
        NSString *resultDesc = [resultDic objectForKey:@"result"];
        if(resultStatus == 9000)///支付成功
        {
            YHBPaySuccessVC *sVc = [[YHBPaySuccessVC alloc] initWithAppendInfo:_payMoneyInfo];
            [self.navigationController pushViewController:sVc animated:YES];
            
        }
        else if(resultStatus == 8000)///正在处理也当支付成功
        {
            YHBPaySuccessVC *sVc = [[YHBPaySuccessVC alloc] initWithAppendInfo:_payMoneyInfo];
            [self.navigationController pushViewController:sVc animated:YES];
            
        }
        else///支付失败
        {
            [SVProgressHUD showErrorWithStatus:@"支付失败，请在订单页面重新支付" cover:YES offsetY:kMainScreenHeight/2.0];
            [[NSNotificationCenter defaultCenter] postNotificationName:kPayFail object:self];
            
            if (self.orderIDArray) {
                NSInteger orderID = [self.orderIDArray.firstObject integerValue];
                YHBOrderDetailViewController *vc = [[YHBOrderDetailViewController alloc] initWithItemId:orderID];
                vc.isPopToRoot = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
    }
    
}

- (void)touchSelBtn
{
    //选择支付方式
}

- (void)touchAddressHead
{
    //选择地址
    YHBAdressListViewController *vc = [[YHBAdressListViewController alloc] init];
    vc.isfromOrder = YES;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)choosedAddressModel:(YHBAddressModel *)model
{
    self.orderConfirmModel.addAddress = model.address;
    self.orderConfirmModel.addItemid = model.itemid;
    self.orderConfirmModel.addMobile = model.mobile;
    self.orderConfirmModel.addTruename = model.truename;
    
    
    [self reloadHeader];
}

- (void)touchExpressCellWithIndexPath:(NSIndexPath *)indexPath
{
    _selIndexPath = indexPath;
    [self showExpressPickView];
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

    if (!_postDic) {
        _postDic = [NSMutableDictionary dictionaryWithCapacity:4];
        [_postDic setObject:([YHBUser sharedYHBUser].token?:@"") forKey:@"token"];
        
    }
    [_postDic setObject:[NSNumber numberWithInt:(int)self.orderConfirmModel.addItemid] forKey:@"add_itemid"];
    
    NSMutableArray *listArray = [NSMutableArray arrayWithCapacity:7];
    [listArray removeAllObjects];
    
    for (int i = 0; i <self.orderConfirmModel.rslist.count; i++) {
        YHBOConfirmRslist *rlist = self.orderConfirmModel.rslist[i];
        for (int j = 0; j < rlist.malllist.count; j++) {
            YHBOConfirmMalllist *mall = rlist.malllist[j];
            YHBOConfirmExpress *express = self.expressSelDic[[self expressKeyWithI:i andJ:j]];
            if (express == nil && mall.express.count) {
                express = mall.express[0];
                self.expressSelDic[[self expressKeyWithI:i andJ:j]] = express;
            }
            NSInteger expressId = (NSInteger)express.internalBaseClassIdentifier;
            
            double expressPrice =  [self expressPriceWithExpress:express andNum:[mall.number doubleValue]];
            NSString *note = ((NSString *)self.messagesDic[[self expressKeyWithI:i andJ:j]] ? : @"");
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:mall.itemid],@"itemid",mall.number?:@"",@"number",[NSString stringWithFormat:@"%d",(int)mall.skuid],@"skuid",express? [NSNumber numberWithInteger:expressId] : @"",@"expressid",(express.name?:@""),@"fee_name",express ? [NSString stringWithFormat:@"%.2lf",expressPrice] : @"",@"fee",note,@"note", nil];
            
            [listArray addObject:dic];
            
            double number = [mall.number doubleValue];
            _price += ([mall.price doubleValue] * number + (mall.express.count ? [self expressPriceWithExpress:express andNum:number] : 0));
            MLOG(@"%lf",_price);
        }
    }
    [_postDic setObject:listArray forKey:@"rslist"];
    
    _priceStr = [NSString stringWithFormat:@"￥%.2lf",_price];
    [self resetPriceLabel];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithDictionary:self.postDic];
    [postDic setObject:@"money" forKey:@"action"];
    [self.orderManager getOrderTotalPriceWithPostDic:postDic Success:^(NSString *totalPriceStr) {
        _price = [totalPriceStr doubleValue];
        [self resetPriceLabel];
    } failure:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error cover:YES offsetY:0];
    }];
    
}
//运费计算
- (double)expressPriceWithExpress:(YHBOConfirmExpress *)express andNum:(double)number
{
    MLOG(@"name = %@",express.name);
    double start = [express.start doubleValue];
    double step = [express.step doubleValue];
    int calNum= (number-(int)number)>0.099 ? number+1 : number;
    return (calNum <= 1 ? start : ((calNum - 1) * step + start));
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
////将index转化为留言dic 与 快递dic的key
//- (NSString *)keyWithSection:(NSInteger)aSection Row:(NSInteger)aRow
//{
//    return [NSString stringWithFormat:@"%ld",aSection * 1000 + aRow];
//}

#pragma mark - 留言 delagte Action

- (void)touchMessageTextField:(UITextField *)textField IndexPath:(NSIndexPath *)indexPath
{
    __weak YHBOrderConfirmVC *weakself = self;
    [[CCEditTextView sharedView] showEditTextViewWithTitle:@"买家留言" textfieldText:textField.text comfirmBlock:^(NSString *text) {
        if (text.length > 0) {
            weakself.messagesDic[[weakself expressKeyWithI:(int)indexPath.section andJ:(int)indexPath.row]] = text;
            textField.text = text;
            
            NSMutableArray *array = weakself.postDic[@"rslist"];
            NSMutableDictionary *dic = array[indexPath.row + indexPath.section];
            dic[@"note"] = text;
        }
        
        
    } cancelBlock:^{
        
    }];
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        //支付
        
    }else{
        if (buttonIndex == 1) {
            __weak YHBOrderConfirmVC *weakself = self;
            YHBAddressEditViewController *vc = [[YHBAddressEditViewController alloc] initWithAddressModel:nil isNew:YES SuccessHandle:^{
                [weakself getDataAndSetUI];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}


- (NSString *)expressKeyWithI:(int)i andJ:(int)j
{
    return [NSString stringWithFormat:@"%d",1000*i+j];
}

#pragma mark - Picker View

- (void)showExpressPickView
{
    if (![self.expressPicker superview]) {
        UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, _expressPicker.top-30, kMainScreenWidth, 40)];
        toolView.backgroundColor = [UIColor lightGrayColor];
        _tool = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 60, 0, 60, 40)];
        [_tool setTitle:@"完成" forState:UIControlStateNormal];
        _tool.titleLabel.textAlignment = NSTextAlignmentCenter;
        _tool.titleLabel.font = kFont15;
        _tool.backgroundColor = [UIColor clearColor];
        [_tool addTarget:self action:@selector(pickerPickEnd:) forControlEvents:UIControlEventTouchDown];
        [toolView addSubview:_tool];
        
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.tag = kButtonTag_Cancel;
        _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cancelBtn.titleLabel.font = kFont15;
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn addTarget:self action:@selector(pickerPickEnd:) forControlEvents:UIControlEventTouchDown];
        [toolView addSubview:_cancelBtn];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.clearView];
        [[UIApplication sharedApplication].keyWindow addSubview:self.expressPicker];
        [[UIApplication sharedApplication].keyWindow addSubview:toolView];
        
        [UIView animateWithDuration:0.2 animations:^{
            _expressPicker.top = kMainScreenHeight - 180;
            toolView.top = _expressPicker.top - 30;
        }];
    }
}



#pragma 快递选择结果更新模型 ui
- (void)pickedExpressToModelAndUI
{
    if (_selExpress) {
        MLOG(@"_selex:%@",_selExpress.name);
        self.expressSelDic[[self expressKeyWithI:_selIndexPath.section andJ:_selIndexPath.row]] = _selExpress;
        [self.tableView reloadRowsAtIndexPaths:@[_selIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self priceCalculate];
    }
}

#pragma mark - pickerView delegate and datasource

- (void)pickerPickEnd:(UIButton *)sender{
    [self.clearView removeFromSuperview];
    if ([_expressPicker superview]) {
        if (sender.tag != kButtonTag_Cancel) {
            [self pickedExpressToModelAndUI];
        }else{
            //[_areaPicker selectRow:0 inComponent:0 animated:NO];
            //[_areaPicker selectRow:0 inComponent:1 animated:NO];
        }
        _selIndexPath = nil;
        _selExpress = nil;
        [UIView animateWithDuration:0.2 animations:^{
            _expressPicker.top = kMainScreenHeight;
            [_expressPicker  removeFromSuperview];
            [sender.superview removeFromSuperview];
        }];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return  1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    YHBOConfirmRslist *rlist = self.orderConfirmModel.rslist[_selIndexPath.section];
    YHBOConfirmMalllist *mallist = rlist.malllist[_selIndexPath.row];
    return mallist.express.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 280;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    YHBOConfirmRslist *rlist = self.orderConfirmModel.rslist[_selIndexPath.section];
    YHBOConfirmMalllist *mallist = rlist.malllist[_selIndexPath.row];
    YHBOConfirmExpress *ex = mallist.express[row];
    return [NSString stringWithFormat:@"%@  起步价：%@",ex.name,ex.start];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    YHBOConfirmRslist *rlist = self.orderConfirmModel.rslist[_selIndexPath.section];
    YHBOConfirmMalllist *mallist = rlist.malllist[_selIndexPath.row];
    _selExpress = mallist.express[row];
}


#pragma mark - keyboard notification

- (void)keybordWillShow:(NSNotification *)notif
{
//    MLOG(@"object:%@",notif.object);
//    NSDictionary *info = [notif userInfo];
//    MLOG(@"%@",info);
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
//    MLOG(@"通知--%@",(UITextField *)value);
    
    
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
    //    NSDictionary *info = [notif userInfo];
    //    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    //    CGSize keyboardSize = [value CGRectValue].size;
    
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAlipayOrderResultMessage object:nil];
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
