//
//  CCTextfieldToolView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/14.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "CCTextfieldToolView.h"

#define kBtnWidth 40

@interface CCTextfieldToolView()
{
    unary_operation_cancel _cancelBlock;
    unary_operation_cancel _comfirmBlock;
}
@property (strong, nonatomic) UIButton *comfirmBtn;
@property (strong, nonatomic) UIButton *cancelBtn;
@end
@implementation CCTextfieldToolView

- (UIButton *)comfirmBtn
{
    if (!_comfirmBtn) {
        _comfirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-kBtnWidth, 0, kBtnWidth, kTextFieldToolHeight)];
        _comfirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _comfirmBtn.titleLabel.font = kFont15;
        _comfirmBtn.backgroundColor = [UIColor clearColor];
        [_comfirmBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_comfirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_comfirmBtn addTarget:self action:@selector(touchComfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _comfirmBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kBtnWidth, kTextFieldToolHeight)];
        _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cancelBtn.titleLabel.font = kFont15;
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(touchCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

+ (instancetype)sharedView
{
    static dispatch_once_t once;
    static CCTextfieldToolView *sharedView;
    dispatch_once(&once, ^{
        sharedView = [[CCTextfieldToolView alloc] init];
    });
    return sharedView;
}

- (instancetype)init
{
    self = [super init];
    self.frame = CGRectMake(0, 0, kMainScreenWidth, kTextFieldToolHeight);
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.comfirmBtn];
    self.layer.borderColor = [kLineColor CGColor];
    self.layer.borderWidth = 0.5f;
    
    return self;
}

- (void)showToolWithY:(CGFloat)y comfirmBlock: (unary_operation_confirm)cBlock cancelBlock:(unary_operation_cancel)cancleBlock
{
    _comfirmBlock = nil;
    _cancelBlock = nil;
    _comfirmBlock = cBlock;
    _cancelBlock = cancleBlock;
    self.top = kMainScreenHeight;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2f animations:^{
        self.top = y;
    } completion:^(BOOL finished) {
        
    }];
}



#pragma mark - Action
- (void)touchComfirmBtn
{
    if (_comfirmBlock) {
        _comfirmBlock();
    }
    [self dismiss];
}

- (void)touchCancelBtn
{
    if (_cancelBlock) {
        _cancelBlock();
    }
    [self dismiss];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.2f animations:^{
        self.top = kMainScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
