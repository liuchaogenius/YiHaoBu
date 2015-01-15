//
//  YHBSelColorCell.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/14.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBSelColorCell.h"
#import "UIButton+WebCache.h"
#define kBlankWidth 20
#define kTitleFont 10
#define kImageWidth (kMainScreenWidth/3.0-20)
#define kImageHeight 80
#define kBackColor [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]

@interface YHBSelColorCell()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *leftBlankView;
@property (strong, nonatomic) UIView *midBlankView;
@property (strong, nonatomic) UIView *rightBlankView;

@end

@implementation YHBSelColorCell

#pragma mark - getter and setter
- (UIView *)leftBlankView
{
    if (!_leftBlankView) {
        _leftBlankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth/3.0, kCellHeight)];
        _leftBlankView.backgroundColor = kBackColor;
    }
    return _leftBlankView;
}


- (UIView *)midBlankView
{
    if (!_midBlankView) {
        _midBlankView = [[UIView alloc] initWithFrame:CGRectMake(1*kMainScreenWidth/3.0, 0, kMainScreenWidth/3.0, kCellHeight)];
        _midBlankView.backgroundColor = kBackColor;
    }
    return _midBlankView;
}

- (UIView *)rightBlankView
{
    if (!_rightBlankView) {
        _rightBlankView = [[UIView alloc] initWithFrame:CGRectMake(2*kMainScreenWidth/3.0, 0, kMainScreenWidth/3.0, kCellHeight)];
        _rightBlankView.backgroundColor = kBackColor;
    }
    return _rightBlankView;
}

- (NSMutableArray *)imageBtnArray
{
    if (!_imageBtnArray) {
        _imageBtnArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _imageBtnArray;
}

- (NSMutableArray *)titleLabelArray
{
    if (!_titleLabelArray) {
        _titleLabelArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _titleLabelArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kBackColor;
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        for (int i =0; i < 3; i++) {
            [self.contentView addSubview:[self customViewWithNum:i]];
        }
    }
    return self;
}

- (void)setUIwithTitle:(NSString *)title image:(NSString *)urlStr part:(int)part
{
    UIView *view;
    if(part == 0 ) view = self.leftBlankView;
    else if(part == 1 ) view = self.midBlankView;
    else view = self.rightBlankView;
    
    if (title.length) {
        UIButton *btn = self.imageBtnArray[part];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal];
        UILabel *label = self.titleLabelArray[part];
        label.text = title;
        if ([view superview]) {
            [view removeFromSuperview];
        }
    }else{
        if (![view superview]) {
            [self.contentView addSubview:view];
        }
    }
}


#pragma mark - Action
- (void)touchImgBtm:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(selectCellPartWithIndexPath:part:imgBtn:)]) {
        [self.delegate selectCellPartWithIndexPath:self.cellIndexPath part:sender.tag imgBtn:sender];
    }
}

- (void)longPress:(UIGestureRecognizer *)gr
{
    if ([self.delegate respondsToSelector:@selector(longPressCellPartWithIndexPath:part:)]) {
        [self.delegate longPressCellPartWithIndexPath:self.cellIndexPath part:gr.view.tag];
    }
}

- (UIView *)customViewWithNum:(int)num
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(num*kMainScreenWidth/3.0, 0, kMainScreenWidth/3.0, kCellHeight)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, kImageWidth, kImageHeight)];
    imgBtn.layer.borderWidth = 0.5f;
    imgBtn.layer.borderColor = [kLineColor CGColor];
    imgBtn.backgroundColor = [UIColor whiteColor];
    [imgBtn addTarget:self action:@selector(touchImgBtm:) forControlEvents:UIControlEventTouchUpInside];
    imgBtn.tag = num;
    UILongPressGestureRecognizer *lGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [imgBtn addGestureRecognizer:lGR];
    self.imageBtnArray[num] = imgBtn;
    [view addSubview:imgBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, view.bottom-kTitleFont, kImageWidth, kTitleFont)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:kTitleFont];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.titleLabelArray[num] = label;
    [view addSubview:label];
    
    return view;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
