//
//  YHBMyPrivateViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBMyPrivateViewController.h"
#define kSgmBtnHeight 35
#define kSelectTagBase 100
enum SgmBtn_tag
{
    SgmBtn_Buy = 100,
    SgmBtn_Sell,
    SgmBtn_Product,
    SgmBtn_Shops
};

@interface YHBMyPrivateViewController ()
@property (strong, nonatomic) UIScrollView *sgmBtmScrollView;
@property (strong, nonatomic) UIButton *selectSgmButton;
@property (assign, nonatomic) NSInteger sgmCount;
@property (strong, nonatomic) NSArray *titleArray;

@end

@implementation YHBMyPrivateViewController

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"求购收藏",@"供应收藏",@"产品收藏",@"商城收藏"];
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
        [_sgmBtmScrollView setFrame:CGRectMake(0, 0, kMainScreenWidth, kSgmBtnHeight)];
        _sgmBtmScrollView.backgroundColor = RGBCOLOR(245, 245, 245);
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
                self.selectSgmButton = sgmButton;
            }
            [_sgmBtmScrollView addSubview:sgmButton];
        }
        
    }
    return _sgmBtmScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.sgmBtmScrollView];
}


#pragma mark - action
- (void)touchSgmButton:(UIButton *)sender
{
    
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
    button.titleLabel.font = kFont14;
    //button.layer.borderWidth = 0.7f;
    //button.layer.borderColor = [RGBCOLOR(207, 207, 207) CGColor];
    button.selected = NO;
    [button addTarget:self action:@selector(touchSgmButton:) forControlEvents:UIControlEventTouchUpInside];
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
