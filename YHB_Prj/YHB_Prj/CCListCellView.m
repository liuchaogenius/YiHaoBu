//
//  CCListCellView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/2/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "CCListCellView.h"
#define kCellheight 40
#define kTitleFont 16

@interface CCListCellView()
{
    CGFloat _width;
    CGFloat _height;
    long _number;
    
    CGFloat _angleX ;
    CGFloat _angleHeight;
    CGFloat _angleWidth;
    UIVisualEffectView *_visualEffectView;
}
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UIBezierPath *path;
@property (strong, nonatomic) UIView *dimView;

@end

@implementation CCListCellView

- (UIView *)dimView
{
    if (!_dimView) {
        _dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
        _dimView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchDimView)];
        [_dimView addGestureRecognizer:gr];
    }
    return _dimView;
}

- (instancetype)initWithTitleArray:(NSArray *)titleArray
{
    self = [super init];
    if (self) {
        //self.clipsToBounds = YES;
        _width = 150.0;
        self.titleArray = titleArray;
        _number = self.titleArray.count;
        _angleX = 30;
        _angleHeight = 20;
        _angleWidth = 25;
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    _height = _number * kCellheight + _angleHeight;
    self.frame = CGRectMake(0, 0, _width, _height);

 
    for (int i = 0; i < _number; i ++) {
        [self addSubview:[self customCellWithTitle:self.titleArray[i] andTag:i andFrame:CGRectMake(0, _angleHeight + i * (kCellheight), _width, kCellheight)]];
    }
    [self pathWithAngleX:_angleX angleHeight:_angleHeight frame:self.frame];
    
}

- (void)showWithPoint:(CGPoint)point Animate:(BOOL)animate
{
    self.clipsToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.dimView];
    if (animate) {
        self.frame = CGRectMake(point.x + _angleX, point.y, 1, 1);
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [UIView animateWithDuration:0.2f animations:^{
            self.frame = CGRectMake(point.x, point.y, _width, _height);
        }];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
}
- (void)disMissWithAnimate:(BOOL)animate
{
    if (animate) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake( self.left + _angleX, self.top, 1, 1);
        }completion:^(BOOL finished) {
            [self.dimView removeFromSuperview];
            [self removeFromSuperview];
            self.frame = CGRectMake(self.left -= _angleX, self.top, _width, _height);
        }];
    }
}

- (void)drawRect:(CGRect)rect {
    [[UIColor colorWithRed:73/255.0 green:78/255.0 blue:80/255.0 alpha:0.85] setFill];
    [self.path fill];
    [[UIColor lightTextColor] setStroke];
    [self.path stroke];
    //self.backgroundColor = [UIColor clearColor];
    //self.textFiled.text = @"slakdjflkajsdflk";
}


- (void)touchCell : (UIGestureRecognizer *)gz
{
    long tag = gz.view.tag;
    if ([self.delegate respondsToSelector:@selector(touchListCellWithRow:)]) {
        [self.delegate touchListCellWithRow:tag];
    }
    [self disMissWithAnimate:YES];
}

- (void)touchDimView
{
    [self disMissWithAnimate:YES];
}

- (void)pathWithAngleX:(CGFloat)angleX angleHeight:(CGFloat)angleHeight frame:(CGRect)frame
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, angleHeight)];
    [path addLineToPoint:CGPointMake(angleX-_angleWidth/2.0f, angleHeight)];
    [path addLineToPoint:CGPointMake(angleX, 0)];
    [path addLineToPoint:CGPointMake(angleX + _angleWidth/2.0f, angleHeight)];
    [path addLineToPoint:CGPointMake(frame.size.width, angleHeight)];
    [path addLineToPoint:CGPointMake(frame.size.width, frame.size.height)];
    [path addLineToPoint:CGPointMake(0, frame.size.height)];
    [path addLineToPoint:CGPointMake(0, angleHeight)];
    [path closePath];
    path.lineWidth = 0.5f;
    [path addClip];
    self.path = path;
    
    [self setNeedsDisplay];
    
}

- (UIView *)customCellWithTitle: (NSString *)title andTag: (int)tag andFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height)];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:kTitleFont];
    label.backgroundColor = [UIColor clearColor];
    
    [view addSubview:label];
    view.tag = tag;
    
    if (tag == _number-1) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        line.backgroundColor = [UIColor blackColor];
        [view addSubview:line];
    }
    
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCell:)];
    [view addGestureRecognizer:gr];
    
    return view;
}

@end
