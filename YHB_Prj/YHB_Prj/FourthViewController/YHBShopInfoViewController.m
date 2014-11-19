//
//  YHBShopInfoViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/17.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShopInfoViewController.h"
#define kImageWith 60
#define kTitleFont 15
#define isTest 1
#define kCellHeight 40

@interface YHBShopInfoViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *userImageView;
@property (strong, nonatomic) UILabel *userName;
@property (strong, nonatomic) UIView *cellsView;
@property (strong ,nonatomic) UIView *headBackView;
@property (strong, nonatomic) UIButton *confirmButton;

@property (strong, nonatomic) NSMutableArray *textFieldArray; 
@property (weak, nonatomic) UITextView *mProductTextView;//主营产品

@end

@implementation YHBShopInfoViewController

- (UIView *)headBackView
{
    if (!_headBackView) {
        _headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 110)];
        _headBackView.backgroundColor = RGBCOLOR(58, 155, 9);
        [self.scrollView addSubview:_headBackView];
        
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth - kImageWith)/2.0, 20, kImageWith, kImageWith)];
        _userImageView.backgroundColor = [UIColor whiteColor];
        [_headBackView addSubview:_userImageView];
        
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(0, self.userImageView.bottom+6, 100, kTitleFont)];
        _userName.centerX = _userImageView.centerX;
        _userName.textColor = [UIColor whiteColor];
        _userName.font = [UIFont systemFontOfSize:kTitleFont];
        _userName.textAlignment = NSTextAlignmentCenter;
        [_headBackView addSubview:_userName];
        if(isTest) _userName.text = @"名字";
    }
    return _headBackView;
}

- (UIView *)cellsView
{
    if (!_cellsView) {
        _cellsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headBackView.bottom + 20, kMainScreenWidth, kCellHeight *5.5)];
        _cellsView.backgroundColor = [UIColor whiteColor];
        _cellsView.layer.borderColor = [kLineColor CGColor];
        _cellsView.layer.borderWidth = 0.5f;
        NSArray *titleArray = @[@"名       称：",@"我的关注：",@"地       址：",@"主营产品："];
        for(int i = 0 ;i < titleArray.count; i++)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, (i)*kCellHeight, kMainScreenWidth, 0.7)];
            line.backgroundColor = kLineColor;
            [_cellsView addSubview:line];
            
            UIView *cellView = [self customCellViewWithframe:CGRectMake(0, i * kCellHeight, kMainScreenWidth, i < 3 ? kCellHeight : 2.5*kCellHeight) title:titleArray[i] tag:i];
            [_cellsView addSubview:cellView];
        }
        
    }
    return _cellsView;
}

- (UIView *)customCellViewWithframe:(CGRect)frame title:(NSString *)title tag:(NSInteger)i
{
    UIView *cellView = [[UIView alloc] initWithFrame:frame];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (kCellHeight-kTitleFont)/2.0f, kTitleFont*5.2, kTitleFont)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = title;
    //titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [cellView addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:kTitleFont];
    if (i < 3) {
         UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabel.right+2, cellView.top, kMainScreenWidth-titleLabel.right-2, kCellHeight)];
        textField.font = [UIFont systemFontOfSize:kTitleFont];
        [textField setBorderStyle:UITextBorderStyleNone];
        textField.textColor = [UIColor lightGrayColor];
        [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [textField setTextAlignment:NSTextAlignmentLeft];
        textField.delegate = self;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [cellView addSubview:textField];
        self.textFieldArray[i] = textField;
    }else{
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom+5, kMainScreenWidth-titleLabel.left*2, cellView.height-titleLabel.bottom-10)];
        textView.backgroundColor = [UIColor whiteColor];
        textView.font = [UIFont systemFontOfSize:kTitleFont];
        textView.textColor = [UIColor lightGrayColor];
        textView.delegate = self;
        //textView.backgroundColor = [UIColor blackColor];
        //textView.text = @"羊毛，羊毛，羊毛，羊毛，羊毛，羊毛，羊毛，羊毛，羊毛，羊毛，羊毛";
        [textView setTextAlignment:NSTextAlignmentLeft];
        [cellView addSubview:textView];
        self.mProductTextView = textView;
    }
    
    return cellView;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.backgroundColor = KColor;
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setFrame:CGRectMake(20, self.cellsView.bottom+30, kMainScreenWidth-40.0, 40)];
        _confirmButton.layer.cornerRadius = 5.0f;
        [_confirmButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(touchConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 49)];
    self.scrollView.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:self.scrollView];
    
    _textFieldArray = [NSMutableArray arrayWithCapacity:3];
    //ui
    [self.scrollView addSubview:self.headBackView];
    [self.scrollView addSubview:self.cellsView];
    [self.scrollView addSubview:self.confirmButton];
    //网络请求
#warning 待进行网络请求
}

#pragma mark - action
- (void)touchConfirmButton
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
