//
//  YHBUserCellsView.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/12.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBUserCellsView.h"

#define cellFont 16
@implementation YHBUserCellsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    NSArray *titleArray = @[@"店铺信息",@"我的认证",@"我的收藏",@"关于我们",@"服务条款",@"使用帮助"];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [kLineColor CGColor];
    
    for (int i = 0; i < titleArray.count; i++) {
        UIView *cellView = [self customCellWithNum:i title:titleArray[i] frame:CGRectMake(0, 0, kMainScreenWidth, KcellHeight)];
        [cellView setFrame:CGRectMake(0, i * KcellHeight, kMainScreenWidth, KcellHeight)];
        [self addSubview:cellView];
        [self addSubview:[self myLineWithY:i * KcellHeight]];
    }
    
    return self;
}

#pragma mark - Action
- (void)touchCellButton : (UIButton *)sender
{
    
}

- (UIView *)customCellWithNum : (int)num title : (NSString *)title frame : (CGRect)frame;
{
    UIView *cellView = [[UIView alloc] init];
    cellView.frame = frame;
    cellView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    cellView.frame = CGRectMake(0, 0, cellView.width, cellView.height);
    [button addTarget:self action:@selector(touchCellButton:) forControlEvents:UIControlEventTouchUpInside];
    [cellView addSubview:button];
    button.tag = num;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (KcellHeight-20)/2.0, 20, 20)];
    //设置图片
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"UserCellIcon_%d",num]];
    [cellView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+10, (KcellHeight-cellFont)/2.0, 100, cellFont)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:cellFont];
    titleLabel.text = title;
    MLOG(@"%@",title);
    
    [cellView addSubview:titleLabel];
    
    return cellView;
}

- (UIView *)myLineWithY:(CGFloat)y
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y, kMainScreenWidth, 0.5)];
    view.backgroundColor = kLineColor;
    return view;
}

@end
