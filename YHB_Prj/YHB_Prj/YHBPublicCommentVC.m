//
//  YHBPublicCommentVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/26.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBPublicCommentVC.h"
#import "YHBOrderInfoView.h"
#import "YHBOrderDetail.h"
#import "UIImageView+WebCache.h"
#import "NetManager.h"
#import "YHBUser.h"
#import "SVProgressHUD.h"
#define kSmallFont 12
#define kCommentHeight 180
#define kStarWidth 25

@interface YHBPublicCommentVC ()<UITextViewDelegate,UIAlertViewDelegate>
{
    CGFloat _titleRight;
    UILabel *_placeLabel;
    NSInteger _star1;
    NSInteger _star2;
    Success_handler _handle;
}
@property (strong, nonatomic) YHBOrderInfoView *orderInfoView;
@property (strong, nonatomic) UIView *storeInfoView;

@property (strong, nonatomic) UITextView *commentTextView;
@property (strong, nonatomic) NSMutableArray *stars1Array;
@property (strong, nonatomic) NSMutableArray *stars2Array;

@property (strong, nonatomic) YHBOrderDetail *model;

@end

@implementation YHBPublicCommentVC

- (void)setPublishSuccessHandler:(Success_handler)handel
{
    _handle = handel;
}

- (NSMutableArray *)stars1Array
{
    if (!_stars1Array) {
        _stars1Array = [NSMutableArray arrayWithCapacity:5];
        for (NSInteger i = 0; i < 5; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(_titleRight+10+(10+kStarWidth)*i, 0, kStarWidth, kStarWidth)];
            [btn setBackgroundImage:[UIImage imageNamed:@"scoreStarHigh"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"scoreStar"] forState:UIControlStateNormal];
            btn.selected = NO;
            btn.tag = i;
            [btn addTarget:self action:@selector(touchStar1Btn:) forControlEvents:UIControlEventTouchUpInside];
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
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(_titleRight+10+(10+kStarWidth)*i, 0, kStarWidth, kStarWidth)];
            [btn setBackgroundImage:[UIImage imageNamed:@"scoreStarHigh"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"scoreStar"] forState:UIControlStateNormal];
            btn.selected = NO;
            btn.tag = i;
            [btn addTarget:self action:@selector(touchStar2Btn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setContentMode:UIViewContentModeScaleAspectFit];
            _stars2Array[i] = btn;
        }
    }
    return _stars2Array;
}

- (UIView *)storeInfoView
{
    if (!_storeInfoView) {
        _storeInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.orderInfoView.bottom+15, kMainScreenWidth, kCommentHeight)];
        _storeInfoView.backgroundColor = [UIColor whiteColor];
        
        UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 50, kSmallFont)];
        title1.textColor = [UIColor lightGrayColor];
        title1.text = @"描述相符";
        title1.font = [UIFont systemFontOfSize:kSmallFont];
        [_storeInfoView addSubview:title1];
        _titleRight = title1.right;
        
        UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 15+40, 50, kSmallFont)];
        title2.textColor = [UIColor lightGrayColor];
        title2.text = @"服务相关";
        title2.font = [UIFont systemFontOfSize:kSmallFont];
        [_storeInfoView addSubview:title2];
        
        for (int i=0; i < self.stars1Array.count; i++) {
            UIButton *btn = self.stars1Array[i];
            btn.centerY = title1.centerY;
            [_storeInfoView addSubview:btn];
        }
        for (int i=0; i < self.stars2Array.count; i++) {
            UIButton *btn = self.stars2Array[i];
            btn.centerY = title2.centerY;
            [_storeInfoView addSubview:btn];
        }
        
        self.commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, title2.bottom+20, kMainScreenWidth-20, 70)];
        self.commentTextView.layer.borderColor = [kLineColor CGColor];
        self.commentTextView.layer.borderWidth = 1.0;
        self.commentTextView.layer.cornerRadius = 4.0;
        self.commentTextView.delegate = self;
        self.commentTextView.font = kFont11;
        self.commentTextView.textColor = [UIColor lightGrayColor];
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 11)];
        _placeLabel.text = @"您的评价对其他买家很有帮助的哦!";
        _placeLabel.textColor = [UIColor lightGrayColor];
        _placeLabel.font = kFont11;
        [self.commentTextView addSubview:_placeLabel];
        _placeLabel.enabled = NO;
        [_storeInfoView addSubview:self.commentTextView];
    }
    return _storeInfoView;
}

- (YHBOrderInfoView *)orderInfoView
{
    if (!_orderInfoView) {
        _orderInfoView = [[YHBOrderInfoView alloc] init];
    }
    return _orderInfoView;
}


- (instancetype)initWithOrderDetailModel:(YHBOrderDetail *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        self.title = @"发表评价";
        _star1 = 0;
        _star2 = 0;
        _handle = nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:self.orderInfoView];
    
    [self.view addSubview:self.storeInfoView];
    [self.view addSubview:[self customButtonWithTitle:@"提交评价" andY:self.storeInfoView.bottom+30]];
    
    [self.orderInfoView.headImageView sd_setImageWithURL:[NSURL URLWithString:self.model.thumb]];
    self.orderInfoView.titleLabel.text = self.model.title;
    self.orderInfoView.numberLabel.text = [NSString stringWithFormat:@"数量：%@",self.model.number];
#warning money or price ?
    self.orderInfoView.priceLabel.text = [NSString stringWithFormat:@"价格：%@",self.model.money];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

- (void)touchSubBtn
{
    if (self.commentTextView.text.length) {
        [self publicComment];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认提交评论？" message:@"您还没有撰写评论内容，确认提交？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
        [alert show];
    }
}

- (void)touchStar1Btn:(UIButton *)sender
{
    if (sender.tag != _star1) {
        _star1 = sender.tag;
        for (NSInteger i = 0; i <self.stars1Array.count ;i++) {
            UIButton *btn = self.stars1Array[i];
            btn.selected = (i <= sender.tag ? YES : NO);
        }
    }
}

- (void)touchStar2Btn:(UIButton *)sender
{
    if (sender.tag != _star2) {
        _star2 = sender.tag;
        for (NSInteger i = 0; i <self.stars2Array.count; i++) {
            UIButton *btn = self.stars2Array[i];
            btn.selected = (i <= sender.tag ? YES : NO);
        }
    }
}

- (void)publicComment
{
    NSString *url = nil;
    kYHBRequestUrl(@"postOrderComment.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:[YHBUser sharedYHBUser].token?:@"",@"token",[NSNumber numberWithDouble:self.model.itemid],@"itemid",[NSString stringWithFormat:@"%ld",(long)_star1],@"star1",[NSString stringWithFormat:@"%ld",(long)_star2],@"star2",self.commentTextView.text?:@"",@"comment",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            [SVProgressHUD showSuccessWithStatus:@"评价成功！" cover:YES offsetY:0];
            if (_handle) {
                _handle();
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"评价失败，请重试！" cover:YES offsetY:0];
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"评价失败，您的网路有点问题" cover:YES offsetY:0];
    }];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.commentTextView isFirstResponder]) {
        [self.commentTextView resignFirstResponder];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _placeLabel.hidden = YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self publicComment];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)customButtonWithTitle:(NSString *)title andY:(CGFloat)y
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:KColor];
    [btn setTintColor:[UIColor whiteColor]];
    btn.layer.cornerRadius = 4.0;
    btn.titleLabel.font = kFont18;
    btn.frame = CGRectMake(10, y, kMainScreenWidth-20, 40);
    [btn addTarget:self action:@selector(touchSubBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
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
