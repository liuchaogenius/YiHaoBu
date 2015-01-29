//
//  YHBNumControl.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBNumControl.h"
#import "CCTextfieldToolView.h"

#define kbtnHeight 25
#define kTitleFont 12

@interface YHBNumControl()

@end

@implementation YHBNumControl
- (void)setNumber:(double)number
{
    _number = number;
    if (_numberTextfield) {
        _numberTextfield.text = self.isNumFloat ? [NSString stringWithFormat:@"%.1f",self.number] : [NSString stringWithFormat:@"%d",(int)self.number];
    }
}

- (void)setIsNumFloat:(BOOL)isNumFloat
{
    _isNumFloat = isNumFloat;
    if (_numberTextfield) {
        _numberTextfield.text = self.isNumFloat ? [NSString stringWithFormat:@"%.1f",self.number] : [NSString stringWithFormat:@"%d",(int)self.number];
        _numberTextfield.keyboardType = self.isNumFloat ? UIKeyboardTypeDecimalPad : UIKeyboardTypeNumberPad;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.number = 1.0;
        self.isNumFloat = NO;
        [self CreatnumControl];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordWShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)CreatnumControl
{
    self.frame = CGRectMake(0, 0, 45+2*kbtnHeight, kbtnHeight);
    self.backgroundColor = [UIColor clearColor];
    UIButton *decButton = [UIButton buttonWithType:UIButtonTypeCustom];
    decButton.frame = CGRectMake(0, 0, kbtnHeight, kbtnHeight);
    decButton.layer.borderWidth = 0.5f;
    decButton.layer.borderColor = [kLineColor CGColor];
    [decButton setTitle:@"-" forState:UIControlStateNormal];
    [decButton addTarget:self action:@selector(decNum) forControlEvents:UIControlEventTouchUpInside];
    [decButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    decButton.titleLabel.font = kFont14;
    [self addSubview:decButton];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(kbtnHeight+45, 0, kbtnHeight, kbtnHeight);
    addButton.layer.borderWidth = 0.5f;
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    addButton.layer.borderColor = [kLineColor CGColor];
    [addButton addTarget:self action:@selector(addNum) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = kFont14;
    [self addSubview:addButton];
    
    _numberTextfield = [[UITextField alloc] initWithFrame:CGRectMake(kbtnHeight, 0, 45, kbtnHeight)];
    _numberTextfield.layer.borderWidth = 0.5f;
    _numberTextfield.layer.borderColor = [kLineColor CGColor];
    _numberTextfield.textAlignment = NSTextAlignmentCenter;
    //_numberTextfield.delegate = self;
    _numberTextfield.keyboardType = self.isNumFloat ? UIKeyboardTypeDecimalPad : UIKeyboardTypeNumberPad;
    _numberTextfield.textColor = [UIColor lightGrayColor];
    _numberTextfield.font = [UIFont systemFontOfSize:kTitleFont];
    _numberTextfield.text = self.isNumFloat ? [NSString stringWithFormat:@"%.1f",self.number] : [NSString stringWithFormat:@"%d",(int)self.number];
    [self addSubview:_numberTextfield];
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
    if ([self.delegate respondsToSelector:@selector(numberControlValueDidChanged)]) {
        [self.delegate numberControlValueDidChanged];
    }
    //[self calulatePrice];
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
    if ([self.delegate respondsToSelector:@selector(numberControlValueDidChanged)]) {
        [self.delegate numberControlValueDidChanged];
    }
    //[self calulatePrice];
}

- (void)keybordWShow:(NSNotification *)notif
{
    
    if ([self.numberTextfield isFirstResponder]) {
        NSDictionary *info = [notif userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keyboardSize = [value CGRectValue].size;
        MLOG(@"通知--%@",(UITextField *)value);
        [self keyBoardShowActionWithKeybordHeight:keyboardSize.height];
    }
     
}

- (void)keyBoardShowActionWithKeybordHeight:(CGFloat)height
{
    NSString *oldText = self.numberTextfield.text;
    [[CCTextfieldToolView sharedView] showToolWithY:kMainScreenHeight-height-kTextFieldToolHeight comfirmBlock:^{
        [self.numberTextfield resignFirstResponder];
        double thNum = [self.numberTextfield.text doubleValue];
        self.number = ((int)(thNum *10))/10.0f;
        if ([self.delegate respondsToSelector:@selector(numberControlValueDidChanged)]) {
            [self.delegate numberControlValueDidChanged];
        }
    } cancelBlock:^{
        [self.numberTextfield resignFirstResponder];
        self.numberTextfield.text = [oldText copy];
    }];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
