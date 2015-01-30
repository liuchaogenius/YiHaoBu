//
//  YHBStoreDetailViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBStoreDetailViewController.h"
#import "YHBUserInfo.h"
#import "YHBUserManager.h"

#define kimgHeight 35
#define kDetailCellHeight 40
#define kBlankHeight 15
#define kTitleFont 13
#define kSmallFont 11
#define kStarWidth 25
#define isTest 0

@interface YHBStoreDetailViewController ()

@property (assign, nonatomic) NSInteger itemID;
@property (strong, nonatomic) YHBUserInfo *storeInfo;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *headImageView;//头像
@property (strong, nonatomic) UILabel *companyName;//店名
@property (strong, nonatomic) UILabel *trueName;//姓名
@property (assign, nonatomic) CGFloat *star1;//描述
@property (assign, nonatomic) CGFloat *star2;//服务态度
@property (strong, nonatomic) UILabel *star1label;
@property (strong, nonatomic) UILabel *star2label;
@property (strong, nonatomic) NSMutableArray *stars1Array;
@property (strong, nonatomic) NSMutableArray *stars2Array;

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *companyLabel;
@property (strong, nonatomic) UILabel *phoneLabel;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UILabel *majorProductTV;

@property (strong, nonatomic) UIView *fistSectionView;
@property (strong, nonatomic) UIView *secondSectionView;

@property (assign, nonatomic) CGFloat currentY;
@property (strong, nonatomic) YHBUserManager *manager;

@end

@implementation YHBStoreDetailViewController

#pragma mark - getter and setter
- (YHBUserManager *)manager
{
    if (!_manager) {
        _manager = [[YHBUserManager alloc] init];
    }
    return _manager;
}

- (UILabel *)star1label
{
    if (!_star1label) {
        _star1label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 13)];
        _star1label.font = [UIFont systemFontOfSize:14];
        _star1label.textColor = KColor;
        _star1label.textAlignment = NSTextAlignmentLeft;
    }
    return _star1label;
}
- (UILabel *)star2label
{
    if (!_star2label) {
        _star2label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 13)];
        _star2label.font = [UIFont systemFontOfSize:14];
        _star2label.textColor = KColor;
        _star2label.textAlignment = NSTextAlignmentLeft;
    }
    return _star2label;
}

- (NSMutableArray *)stars1Array
{
    if (!_stars1Array) {
        _stars1Array = [NSMutableArray arrayWithCapacity:5];
        for (NSInteger i = 0; i < 5; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10+(10+kStarWidth)*i, 0, kStarWidth, kStarWidth)];
            [btn setBackgroundImage:[UIImage imageNamed:@"scoreStarHigh"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"scoreStar"] forState:UIControlStateNormal];
            btn.selected = NO;
            [btn setContentMode:UIViewContentModeScaleAspectFit];
            _stars1Array[i] = btn;
        }
    }
    return _stars1Array;
}

- (NSMutableArray *)stars2Array
{
    if (!_stars2Array) {
        _stars2Array = [NSMutableArray arrayWithCapacity:5];
        for (NSInteger i = 0; i < 5; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10+(10+kStarWidth)*i, 0, kStarWidth, kStarWidth)];
            [btn setBackgroundImage:[UIImage imageNamed:@"scoreStarHigh"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"scoreStar"] forState:UIControlStateNormal];
            btn.selected = NO;
            [btn setContentMode:UIViewContentModeScaleAspectFit];
            _stars2Array[i] = btn;
        }
    }
    return _stars2Array;
}

- (UILabel *)companyName
{
    if (!_companyName) {
        _companyName = [[UILabel alloc] init];
        _companyName.font = [UIFont systemFontOfSize:kSmallFont];
        _companyName.textColor = [UIColor blackColor];
    }
    return _companyName;
}

- (UILabel *)trueName
{
    if (!_trueName) {
        _trueName = [[UILabel alloc] init];
        _trueName.font = [UIFont systemFontOfSize:kSmallFont];
        _trueName.textColor = [UIColor blackColor];
    }
    return _trueName;
}


- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kimgHeight, kimgHeight)];
        _headImageView.backgroundColor = [UIColor whiteColor];
        _headImageView.layer.borderColor = [kLineColor CGColor];
        _headImageView.layer.borderWidth = 0.5;
        _headImageView.layer.cornerRadius = 2.0f;
    }
    return _headImageView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20-44)];
        _scrollView.backgroundColor = kViewBackgroundColor;
        _scrollView.contentSize = CGSizeMake(kMainScreenWidth, 530);
    }
    return _scrollView;
}

- (UIView *)fistSectionView
{
    if (!_fistSectionView) {
        _fistSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kMainScreenWidth, 220)];
        _fistSectionView.backgroundColor = [UIColor whiteColor];
    }
    return _fistSectionView;
}

- (UIView *)secondSectionView
{
    if (!_secondSectionView) {
        _secondSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, self.fistSectionView.bottom+kBlankHeight, kMainScreenWidth, 270)];
        _secondSectionView.backgroundColor = [UIColor whiteColor];
    }
    return _secondSectionView;
}

- (instancetype)initWithStoreInfo:(YHBUserInfo *)storeInfo
{
    self = [super init];
    if (self) {
        self.storeInfo = storeInfo;
        self.itemID = 0;
    }
    return self;
}

- (instancetype)initWithItemID:(NSInteger)itemID
{
    self = [self init];
    if (self) {
        self.itemID = itemID;
        self.storeInfo = nil;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    self.title = @"店铺信息";
    self.currentY = 0.0;
    self.star1 = 0;
    self.star2 = 0;
    [self.view addSubview:self.scrollView];
    
    [self creatFirstSectionView];
    [self creatSecondSectionView];
    
    //Data
    if (self.storeInfo) {
        [self setUIWithStoreInfo:self.storeInfo];
    }else{
        __weak YHBStoreDetailViewController *weakself = self;
        [self.manager getUserInfoWithToken:nil orUserId:[NSString stringWithFormat:@"%li",(long)self.itemID] Success:^(NSDictionary *dataDic) {
            weakself.storeInfo = [YHBUserInfo modelObjectWithDictionary:dataDic];
            [weakself setUIWithStoreInfo:weakself.storeInfo];
            
        } failure:^{
            
        }];
    }
    
}
#pragma mark - 更新UI
- (void)setUIWithStoreInfo:(YHBUserInfo *)info
{
    self.nameLabel.text = info.truename;
    self.companyLabel.text = info.truename;
    self.companyName.text = info.company;
    self.trueName.text = info.truename;
    self.phoneLabel.text = info.mobile;
    self.addressLabel.text = info.address;
    self.majorProductTV.text = info.business;
    
    double dstar1 = 0;
    if(info.star1.length) dstar1 = [info.star1 doubleValue];
    double dstar2 = 0;
    if(info.star2.length) dstar2 = [info.star2 doubleValue];
    NSInteger i = 0;
    for (i=0; i < (int)dstar1; i++) {
        UIButton *btn = self.stars1Array[i];
        btn.selected = YES;
    }
    for (i=0; i < (int)dstar2; i++) {
        UIButton *btn = self.stars2Array[i];
        btn.selected = YES;
    }
    self.star1label.text = info.star1;
    self.star2label.text = info.star2;
}


- (void)creatFirstSectionView
{
    [self.scrollView addSubview:self.fistSectionView];
    
    [self.fistSectionView addSubview:self.headImageView];
    self.companyName.frame = CGRectMake(self.headImageView.right+5, 12, 200, kSmallFont);
    [self.fistSectionView addSubview:self.companyName];
    self.trueName.frame = CGRectMake(self.companyName.left, self.companyName.bottom+3, 180, kSmallFont);
    [self.fistSectionView addSubview:self.trueName];
    
    self.currentY = self.headImageView.bottom + 10;
    [self.fistSectionView addSubview:[self getLineWithY:self.currentY]];
    [self.fistSectionView addSubview:[self customTitleLabelWithY:self.currentY+10 Title:@"评分情况:" isBlackColor:YES]];
    self.currentY += 35;
    [self.fistSectionView addSubview:[self getLineWithY:self.currentY]];
    self.currentY += 10;
    [self.fistSectionView addSubview:[self customTitleLabelWithY:self.currentY Title:@"描述相符:" isBlackColor:NO]];
    self.currentY += 20;
    for (NSInteger i = 0; i < 5; i++) {
        UIButton *star = self.stars1Array[i];
        star.top = self.currentY;
        [self.fistSectionView addSubview:star];
    }
    self.star1label.bottom = ((UIButton *)self.stars1Array[4]).bottom;
    self.star1label.left = ((UIButton *)self.stars1Array[4]).right+10;
    [self.fistSectionView addSubview:self.star1label];
    self.currentY += kStarWidth + 15;
    
    [self.fistSectionView addSubview:[self customTitleLabelWithY:self.currentY Title:@"服务态度:" isBlackColor:NO]];
    self.currentY += 20;
    for (NSInteger i = 0; i < 5; i++) {
        UIButton *star = self.stars2Array[i];
        star.top = self.currentY;
        [self.fistSectionView addSubview:star];
    }
    self.star2label.bottom = ((UIButton *)self.stars2Array[4]).bottom;
    self.star2label.left = ((UIButton *)self.stars2Array[4]).right+10;
    [self.fistSectionView addSubview:self.star2label];
    if (isTest) {
        self.trueName.text = @"某某某";
        self.companyName.text = @"xxxx公司";
        self.star1label.text = @"0.0";
        self.star2label.text = @"0.0";
    }
}

- (void)creatSecondSectionView
{
    [self.scrollView addSubview:self.secondSectionView];
    self.currentY = 0;
    [self.secondSectionView addSubview:[self customTitleLabelWithY:self.currentY+13 Title:@"姓       名：" isBlackColor:YES]];
    if(!_nameLabel) [self.secondSectionView addSubview:self.nameLabel = [self customDetailLabelWithOrign:CGPointMake(75, self.currentY+13)]];
    
    self.currentY = kDetailCellHeight;
    [self.secondSectionView addSubview:[self getLineWithY:self.currentY]];
    
    [self.secondSectionView addSubview:[self customTitleLabelWithY:self.currentY+13 Title:@"店铺名称：" isBlackColor:YES]];
    if(!_companyLabel) [self.secondSectionView addSubview:self.companyLabel = [self customDetailLabelWithOrign:CGPointMake(75, self.currentY+13)]];
    self.currentY += kDetailCellHeight;
    [self.secondSectionView addSubview:[self getLineWithY:self.currentY]];
    
    [self.secondSectionView addSubview:[self customTitleLabelWithY:self.currentY+13 Title:@"联系电话：" isBlackColor:YES]];
    if(!_phoneLabel) [self.secondSectionView addSubview:self.phoneLabel = [self customDetailLabelWithOrign:CGPointMake(75, self.currentY+13)]];
    self.currentY += kDetailCellHeight;
    [self.secondSectionView addSubview:[self getLineWithY:self.currentY]];
    
    [self.secondSectionView addSubview:[self customTitleLabelWithY:self.currentY+13 Title:@"地       址：" isBlackColor:YES]];
    if(!_addressLabel) [self.secondSectionView addSubview:self.addressLabel = [self customDetailLabelWithOrign:CGPointMake(75, self.currentY+13)]];
    self.currentY += kDetailCellHeight;
    [self.secondSectionView addSubview:[self getLineWithY:self.currentY]];
    
    [self.secondSectionView addSubview:[self customTitleLabelWithY:self.currentY+13 Title:@"主营产品：" isBlackColor:YES]];
    self.currentY += (kDetailCellHeight-10);
    if (!self.majorProductTV) {
        self.majorProductTV = [[UILabel alloc] initWithFrame:CGRectMake(10, self.currentY, kMainScreenWidth-20, 50)];
        self.majorProductTV.backgroundColor = [UIColor clearColor];
        self.majorProductTV.numberOfLines = 0;
        //self.majorProductTV.editable = NO;
        self.majorProductTV.textColor = [UIColor lightGrayColor];
        self.majorProductTV.font = [UIFont systemFontOfSize:kTitleFont];
    }
    [self.secondSectionView addSubview:self.majorProductTV];
    
    if (isTest) {
        self.nameLabel.text = @"XXXX";
        self.companyLabel.text = @"xxxx公司";
        self.phoneLabel.text = @"12312312";
        self.addressLabel.text = @"我的地址asdfadsfasdf";
        self.majorProductTV.text = @"ajsdflksadjflkjasdjflasjdfljsadlfjklajsldfjkla老卡机法拉克两地分居氨基酸的放开粮食局";
    }
}

- (UIView *)getLineWithY:(CGFloat)y
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y-0.6, kMainScreenWidth, 0.5)];
    view.backgroundColor = kLineColor;
    return view;
}

- (UILabel *)customTitleLabelWithY:(CGFloat)y Title:(NSString *)title isBlackColor:(BOOL)isBlack
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, 73, kTitleFont)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:kTitleFont];
    label.textColor = isBlack ? [UIColor blackColor] : [UIColor lightGrayColor];
    label.text = title;
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

- (UILabel *)customDetailLabelWithOrign:(CGPoint)origin
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(origin.x, origin.y, kMainScreenWidth-93, kTitleFont)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:kTitleFont];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
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
