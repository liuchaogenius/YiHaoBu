//
//  YHBSelNumColorView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/13.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBSelNumColorView.h"
#import "YHBProductDetail.h"
#import "CCTextfieldToolView.h"
#import "YHBSelColorCell.h"
#import "UIImageView+WebCache.h"
#import "YHBSku.h"
#import "YHBAlbum.h"
#define kInfoHeight 50
#define kImageheight 30
#define kHeadHeight 25
#define kFooterHeight 50
#define kTitleFont 12
#define kCellHeight 100
#define kbtnHeight 25
#define kBackColor [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]

@interface YHBSelNumColorView()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,YHBSelColorCellDelefate>
{
    UIButton *_selectedBtn;
    NSInteger _selectSkuIndex; //已选色块的编号
}
@property (strong, nonatomic) YHBProductDetail *productModel;
@property (strong, nonatomic) UIView *infoView;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *priceLabel;//价格label
@property (strong, nonatomic) UILabel *tipLabel;//提示信息label
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *numbFooterView;
@property (strong, nonatomic) UIView *numControlView;//数量控件
@property (strong, nonatomic) UITextField *numberTextfield;
@property (assign, nonatomic) double number;//数量
@property (assign, nonatomic) double totalPrice;//价格
@property (assign, nonatomic) BOOL isNumFloat;//是否需要小数 数量
@property (strong, nonatomic) UIView *keybordTool;

@end

@implementation YHBSelNumColorView

#pragma mark - getter and setter

- (UIView *)numControlView
{
    if (!_numControlView) {
        _numControlView = [[UIView alloc] initWithFrame:CGRectMake(0, (kFooterHeight-kbtnHeight)/2.0, 45+2*kbtnHeight, kbtnHeight)];
        _numControlView.backgroundColor = [UIColor clearColor];
        
        UIButton *decButton = [UIButton buttonWithType:UIButtonTypeCustom];
        decButton.frame = CGRectMake(0, 0, kbtnHeight, kbtnHeight);
        decButton.layer.borderWidth = 0.5f;
        decButton.layer.borderColor = [kLineColor CGColor];
        [decButton setTitle:@"-" forState:UIControlStateNormal];
        [decButton addTarget:self action:@selector(decNum) forControlEvents:UIControlEventTouchUpInside];
        [decButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        decButton.titleLabel.font = kFont14;
        [_numControlView addSubview:decButton];
        
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(kbtnHeight+45, 0, kbtnHeight, kbtnHeight);
        addButton.layer.borderWidth = 0.5f;
        [addButton setTitle:@"+" forState:UIControlStateNormal];
        addButton.layer.borderColor = [kLineColor CGColor];
        [addButton addTarget:self action:@selector(addNum) forControlEvents:UIControlEventTouchUpInside];
        [addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        addButton.titleLabel.font = kFont14;
        [_numControlView addSubview:addButton];
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(kbtnHeight, 0, 45, kbtnHeight)];
        tf.layer.borderWidth = 0.5f;
        tf.layer.borderColor = [kLineColor CGColor];
        tf.textAlignment = NSTextAlignmentCenter;
        tf.delegate = self;
        tf.keyboardType = self.isNumFloat ? UIKeyboardTypeDecimalPad : UIKeyboardTypeNumberPad;
        tf.textColor = [UIColor lightGrayColor];
        tf.font = [UIFont systemFontOfSize:kTitleFont];
        tf.text = self.isNumFloat ? [NSString stringWithFormat:@"%.1f",self.number] : [NSString stringWithFormat:@"%d",(int)self.number];
        _numberTextfield = tf;
        [_numControlView addSubview:tf];
    }
    return _numControlView;
}

- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, kInfoHeight, kMainScreenWidth, kHeadHeight)];
        _headView.backgroundColor = kBackColor;
        _headView.layer.borderColor = [kLineColor CGColor];
        _headView.layer.borderWidth = 0.5;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, (kHeadHeight-kTitleFont)/2.0, 200, kTitleFont)];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:kTitleFont];
        label.text = @"色块 (长按显示大图)";
        _tipLabel = label;
        [_headView addSubview:label];
    }
    return _headView;
}

- (UIView *)numbFooterView
{
    if (!_numbFooterView) {
        _numbFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-kFooterHeight, kMainScreenWidth, kFooterHeight)];
        _numbFooterView.backgroundColor = kBackColor;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, (kFooterHeight-kTitleFont+5)/2.0, 25, kTitleFont)];
        
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:kTitleFont];
        label.text = @"数量";
        [_numbFooterView addSubview:label];
        
        self.numControlView.left = label.right + 10;
        [_numbFooterView addSubview:self.numControlView];
        
        UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(self.numControlView.right+10, _numControlView.bottom-kTitleFont, 100, kTitleFont)];
        unit.textColor = [UIColor lightGrayColor];
        unit.font = [UIFont systemFontOfSize:kTitleFont-2];
        unit.text = @"米";
        [_numbFooterView addSubview:unit];
    }
    return _numbFooterView;
}

- (instancetype)initWithProductModel:(YHBProductDetail *)model
{
    self = [super init];
    if (self) {
        self.productModel = model;
        self.number = 1.0;
        _isNumFloat = NO;
        if ([self.productModel.unit isEqualToString:@"米"]) {
            self.isNumFloat = YES;
        }
        _selectSkuIndex = -1;
        [self registerForKeyboradNotifications];
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, kMainScreenWidth, kHeadHeight+kInfoHeight+kFooterHeight+2*kCellHeight);
        [self creatUI];
        [self calulatePrice];
    }
    return self;
}

- (void)creatUI {
    
    [self creatInfoHeadView];
    [self addSubview:self.headView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headView.bottom, kMainScreenWidth, self.height-kInfoHeight-kHeadHeight-kFooterHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kBackColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = kCellHeight;
    
    [self addSubview:self.tableView];
    [self addSubview:self.numbFooterView];
}

//UI
- (void)creatInfoHeadView
{
    self.infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kInfoHeight)];
    self.infoView.backgroundColor = [UIColor whiteColor];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kImageheight, kImageheight)];
    _headImageView.layer.borderWidth = 0.5f;
    _headImageView.layer.borderColor = [kLineColor CGColor];
    _headImageView.layer.cornerRadius = 2.0f;
    _headImageView.backgroundColor = [UIColor whiteColor];
    if (self.productModel.album.count) {
        YHBAlbum *al = self.productModel.album.firstObject;
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:al.thumb]];
    }
    
    [self.infoView addSubview:self.headImageView];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+10, 10, 170, kTitleFont+2)];
    self.priceLabel.backgroundColor = [UIColor clearColor];
    self.priceLabel.textColor = [UIColor redColor];
    [self.priceLabel setFont:[UIFont systemFontOfSize:kTitleFont+2]];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2lf",self.totalPrice];
    [self.infoView addSubview:self.priceLabel];
    
    self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLabel.left, self.priceLabel.bottom+3, 200, kTitleFont)];
    self.tipLabel.font = [UIFont systemFontOfSize:kTitleFont];
    self.tipLabel.backgroundColor = [UIColor clearColor];
    self.tipLabel.textColor = [UIColor lightGrayColor];
    self.tipLabel.text = @"请选择色块、数量";
    [self.infoView addSubview:self.tipLabel];
    
    UIButton *quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    quitButton.frame = CGRectMake(kMainScreenWidth-30, 10, 20, 26);
    [quitButton setBackgroundImage:[UIImage imageNamed:@"quit"] forState:UIControlStateNormal];
    [quitButton setContentMode:UIViewContentModeScaleAspectFit];
    [quitButton addTarget:self action:@selector(touchQuitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.infoView addSubview:quitButton];
    
    [self addSubview:self.infoView];
}
#pragma mark - 数据源方法
#pragma mark 数据行数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.productModel.sku.count/3 + self.productModel.sku.count%3 ? 1: 0) > 2 ? :2;
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    YHBSelColorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[YHBSelColorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    cell.cellIndexPath = indexPath;
    for (int i=0; i < 3; i++) {
        if (self.productModel.sku.count > indexPath.row*3 + i) {
            YHBSku *sku = self.productModel.sku[indexPath.row + i];
            [cell setUIwithTitle:sku.title image:sku.middle part:i];
        }else
            [cell setUIwithTitle:nil image:nil part:i];
    }
    return cell;
}


#pragma mark - Action
- (void)touchQuitButton
{
    if ([self.numberTextfield isFirstResponder]) {
        [self.numberTextfield resignFirstResponder];
    }
    if ([self.delegate respondsToSelector:@selector(selViewShouldDismiss)]) {
        [self.delegate selViewShouldDismiss];
    }
}

//减
- (void)decNum
{
    if (self.isNumFloat && self.number > 0.11) {
        self.number -= 0.1;
        MLOG(@"%lf",self.number);
        self.numberTextfield.text = [NSString stringWithFormat:@"%.1f",self.number];
    }else if((int)self.number >= 1){
        self.number -= 1;
        self.numberTextfield.text = [NSString stringWithFormat:@"%d",(int)self.number];
    }
    [self calulatePrice];
}
//加
- (void)addNum
{
    if (self.isNumFloat) {
        self.number += 0.1;
        self.numberTextfield.text = [NSString stringWithFormat:@"%.1f",self.number];
    }else{
        self.number += 1;
        self.numberTextfield.text = [NSString stringWithFormat:@"%d",(int)self.number];
    }
    [self calulatePrice];
}

- (void)calulatePrice
{
    self.totalPrice = [self.productModel.price doubleValue] * self.number;
    self.priceLabel.text = self.isNumFloat ? [NSString stringWithFormat:@"%.1f",self.totalPrice] : [NSString stringWithFormat:@"%d",(int)self.totalPrice];
}

#pragma mark - cell Delegate
#pragma mark 点击色块
- (void)selectCellPartWithIndexPath:(NSIndexPath *)indexPath part:(NSInteger)part imgBtn:(UIButton *)btn
{
    MLOG(@"touch cell part");
    NSInteger index = indexPath.row *3 + part;
    if (self.productModel.sku.count > index) {
        YHBSku *sku = self.productModel.sku[index];
        self.tipLabel.text = [NSString stringWithFormat:@"已选“%@”",sku.title];
        if (_selectedBtn) {
            _selectedBtn.layer.borderColor = [kLineColor CGColor];
        }
        _selectedBtn = btn;
        _selectedBtn.layer.borderColor = [KColor CGColor];
        _selectSkuIndex = index;
    }
}
#pragma mark 长按色块
- (void)longPressCellPartWithIndexPath:(NSIndexPath *)indexPath part:(NSInteger)part
{
#warning 此处带打开图片浏览的界面
    MLOG(@"long press part");
}

#pragma mark - text delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)registerForKeyboradNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHid:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHid:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keybordWillShow:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size
    ;
    NSString *oldText = self.numberTextfield.text;
    [[CCTextfieldToolView sharedView] showToolWithY:kMainScreenHeight-keyboardSize.height-kTextFieldToolHeight comfirmBlock:^{
        [self.numberTextfield resignFirstResponder];
        self.number = [self.numberTextfield.text doubleValue];
        [self calulatePrice];
    } cancelBlock:^{
        [self.numberTextfield resignFirstResponder];
        self.numberTextfield.text = [oldText copy];
    }];
    self.center = CGPointMake(self.centerX, self.centerY - keyboardSize.height - kTextFieldToolHeight);
}

- (void)keyboardDidShow:(NSNotification *)notif
{
}

- (void)keyboardWillHid:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    self.center = CGPointMake(self.centerX, self.centerY + keyboardSize.height + kTextFieldToolHeight);
}

- (void)keyboardDidHid:(NSNotification *)notif
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
