//
//  TableSectionHeaderView.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/13.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "TableSectionHeaderView.h"

#define topViewHeight 15
@implementation TableSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _isSelected = NO;
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, topViewHeight)];
        topView.backgroundColor = RGBCOLOR(239, 239, 239);
        [self addSubview:topView];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, topViewHeight, kMainScreenWidth, 40)];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomView];
        
        self.chooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, 20, 20)];
        [self.chooseBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.chooseBtn.layer.borderColor = [[UIColor blackColor] CGColor];
        self.chooseBtn.layer.borderWidth = 0.5;
        [bottomView addSubview:self.chooseBtn];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.chooseBtn.right+10, self.chooseBtn.top, kMainScreenWidth-50, 20)];
        nameLabel.font = kFont15;
        [bottomView addSubview:nameLabel];
    }
    return self;
}

- (void)setName:(NSString *)aName
{
    nameLabel.text = aName;
}

- (void)chooseBtn:(UIButton *)aBtn
{
    if (_isSelected==NO)
    {
        self.chooseBtn.backgroundColor = [UIColor redColor];
    }
    else
    {
        self.chooseBtn.backgroundColor = [UIColor whiteColor];
    }
    [self.headerViewDelegate selectHeadViewWithView:self Index:self.index];
    _isSelected = !_isSelected;
}

- (void)chooseBtnNo
{
    self.chooseBtn.backgroundColor = [UIColor whiteColor];
    _isSelected = NO;
}

- (void)chooseBtnYes
{
    self.chooseBtn.backgroundColor = [UIColor redColor];
    _isSelected = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
