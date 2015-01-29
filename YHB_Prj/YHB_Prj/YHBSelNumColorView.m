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
#import "YHBAlbum.h"
#import "YHBNumControl.h"
#define kInfoHeight 50
#define kImageheight 30
#define kHeadHeight 25
#define kFooterHeight 50
#define kTitleFont 12
#define kCellHeight 100
#define kbtnHeight 25
#define kBackColor [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]

@interface YHBSelNumColorView()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,YHBSelColorCellDelefate,YHBNumControlDelegate>
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
//@property (strong, nonatomic) UIView *numControlView;//数量控件
@property (strong, nonatomic) YHBNumControl *numControl;//数量控件
//@property (strong, nonatomic) UITextField *numberTextfield;

@property (assign, nonatomic) double totalPrice;//价格
@property (assign, nonatomic) BOOL isNumFloat;//是否需要小数 数量
@property (strong, nonatomic) UIView *keybordTool;

@end

@implementation YHBSelNumColorView

#pragma mark - getter and setter

- (BOOL)isNumFloat
{
    return self.numControl.isNumFloat;
}

- (void)setIsNumFloat:(BOOL)isNumFloat
{
    self.numControl.isNumFloat = isNumFloat;
}

- (double)number
{
    return self.numControl.number;
}

- (void)setNumber:(double)number
{
    self.numControl.number = number;
}

- (YHBNumControl *)numControl
{
    if (!_numControl) {
        _numControl = [[YHBNumControl alloc] init];
        _numControl.delegate = self;
    }
    return _numControl;
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
        
        //self.numControlView.left = label.right + 10;
        self.numControl.left = label.right + 10;
        self.numControl.centerY = _numbFooterView.height/2.0;
        //[_numbFooterView addSubview:self.numControlView];
        [_numbFooterView addSubview:self.numControl];
        
        UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(self.numControl.right+10, _numControl.bottom-kTitleFont, 100, kTitleFont)];
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
        self.isNumFloat = NO;
        if ([self.productModel.unit1 isEqualToString:@"米"]) {
            self.isNumFloat = YES;
        }
        _selectSkuIndex = -1;
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
    
    if ([self.numControl.numberTextfield isFirstResponder]) {
        [self.numControl.numberTextfield resignFirstResponder];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if ([self.delegate respondsToSelector:@selector(selViewShouldDismissWithSelNum:andSelSku:)]) {
        [self.delegate selViewShouldDismissWithSelNum:self.number andSelSku:self.selSku];
    }
}

- (void)numberControlValueDidChanged
{
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
        self.selSku = sku;
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
    MLOG(@"%@",self.numControl.numberTextfield);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHid:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHid:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keybordWillShow:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    MLOG(@"通知--%@",(UITextField *)value);
    //[self.numControl keyBoardShowActionWithKeybordHeight:keyboardSize.height];
}

- (void)keyboardDidShow:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    self.centerY -= keyboardSize.height+kTextFieldToolHeight;
}

- (void)keyboardWillHid:(NSNotification *)notif
{
//    NSDictionary *info = [notif userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
    self.bottom = kMainScreenHeight;
}

- (void)keyboardDidHid:(NSNotification *)notif
{
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
