//
//  YHBSelectNumColorVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/13.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBSelectNumColorVC.h"
#import "YHBProductDetail.h"
#define kInfoHeight 50
#define kImageheight 30
#define kHeadHeight 25
#define kFooterHeight 50
#define kTitleFont 12
#define kCellHeight 110
#define kbtnHeight 30
#define kBackColor [UIColor colorWithRed:237 green:237 blue:237 alpha:1.0]
@interface YHBSelectNumColorVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) YHBProductDetail *productModel;
@property (strong, nonatomic) UIView *infoView;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *priceLabel;//价格label
@property (strong, nonatomic) UILabel *tipLabel;//提示信息label
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *numbFooterView;
@property (strong, nonatomic) UIView *numControlView;//数量控件
@property (assign, nonatomic) double number;//数量
@property (assign, nonatomic) double totalPrice;//价格
@property (assign, nonatomic) BOOL isNumFloat;//是否需要小数 数量

@end

@implementation YHBSelectNumColorVC
#pragma mark - getter and setter
- (UIView *)numControlView
{
    if (!_numControlView) {
        _numControlView = [[UIView alloc] initWithFrame:CGRectMake(0, (kFooterHeight-kbtnHeight)/2.0, 150, kbtnHeight)];
        _numControlView.backgroundColor = [UIColor clearColor];
        
        UIButton *decButton = [UIButton buttonWithType:UIButtonTypeCustom];
        decButton.frame = CGRectMake(0, 0, kbtnHeight, kbtnHeight);
        decButton.layer.borderWidth = 0.5f;
        decButton.layer.borderColor = [kLineColor CGColor];
        [decButton addTarget:self.view action:@selector(decNum) forControlEvents:UIControlEventTouchUpInside];
        [decButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        decButton.titleLabel.font = kFont12;
        [_numControlView addSubview:decButton];
        
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(kbtnHeight+45, 0, kbtnHeight, kbtnHeight);
        addButton.layer.borderWidth = 0.5f;
        addButton.layer.borderColor = [kLineColor CGColor];
        [addButton addTarget:self.view action:@selector(addNum) forControlEvents:UIControlEventTouchUpInside];
        [addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        addButton.titleLabel.font = kFont12;
        [_numControlView addSubview:addButton];
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(kbtnHeight, 0, 45, kbtnHeight)];
        tf.layer.borderWidth = 0.5f;
        tf.layer.borderColor = [kLineColor CGColor];
        tf.textAlignment = NSTextAlignmentCenter;
        tf.delegate = self;
        tf.textColor = [UIColor lightGrayColor];
        tf.font = [UIFont systemFontOfSize:kTitleFont];
        tf.text = self.isNumFloat ? [NSString stringWithFormat:@"%.1f",self.number] : [NSString stringWithFormat:@"%d",(int)self.number];
        [_numControlView addSubview:tf];
    }
    return _numControlView;
}

- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kHeadHeight)];
        _headView.backgroundColor = kBackColor;
        _headView.layer.borderColor = [kLineColor CGColor];
        _headView.layer.borderWidth = 0.5;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, (kHeadHeight-kTitleFont)/2.0, 100, kTitleFont)];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:kTitleFont];
        label.text = @"色块 (长按显示大图)";
        [_headView addSubview:label];
    }
    return _headView;
}

- (UIView *)numbFooterView
{
    if (!_numbFooterView) {
        _numbFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bottom-kFooterHeight, kMainScreenWidth, kFooterHeight)];
        _numbFooterView.backgroundColor = kBackColor;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, (kHeadHeight-kTitleFont)/2.0, 100, kTitleFont)];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:kTitleFont];
        label.text = @"数量";
        [_numbFooterView addSubview:label];
        
        self.numControlView.left = label.right + 10;
        [_numbFooterView addSubview:self.numControlView];
        
        UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(self.numControlView.right+!0, (kHeadHeight-kTitleFont)/2.0, 100, kTitleFont)];
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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    self.view = [[UIView alloc] init];
    self.view.frame = CGRectMake(0, 300, kMainScreenWidth, 400);
    self.view.backgroundColor = [UIColor clearColor];*/
    
    [self creatInfoHeadView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.infoView.bottom, kMainScreenWidth, self.view.height-kInfoHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kViewBackgroundColor;//kBackColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.sectionHeaderHeight = kHeadHeight;
    self.tableView.sectionFooterHeight = kFooterHeight;
    self.tableView.rowHeight = kCellHeight;
    
    [self.view addSubview:self.tableView];
}

//UI
- (void)creatInfoHeadView
{
    self.infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kInfoHeight)];
    self.infoView.backgroundColor = [UIColor whiteColor];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kImageheight, kImageheight)];
    _headImageView.layer.borderWidth = 0.5f;
    _headImageView.layer.borderColor = [kLineColor CGColor];
    _headImageView.backgroundColor = [UIColor whiteColor];
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
    quitButton.frame = CGRectMake(kMainScreenWidth-60, 10, 60, 25);
    [quitButton setBackgroundImage:[UIImage imageNamed:@"quit"] forState:UIControlStateNormal];
    [quitButton setContentMode:UIViewContentModeScaleAspectFit];
    [quitButton addTarget:self action:@selector(touchQuitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.infoView addSubview:quitButton];
    
    [self.view addSubview:self.infoView];
}
#pragma mark - 数据源方法
#pragma mark 数据行数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.numbFooterView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productModel.sku.count/3 + self.productModel.sku.count%3 ? 1: 0;
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //TODO：设备cell内容
    return cell;
}


#pragma mark - Action
- (void)touchQuitButton
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//减
- (void)decNum
{
    
}
//加
- (void)addNum
{
    
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
