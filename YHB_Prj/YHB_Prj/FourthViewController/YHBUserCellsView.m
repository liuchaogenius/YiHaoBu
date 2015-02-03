//
//  YHBUserCellsView.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/12.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBUserCellsView.h"
#define cellFont 16

@interface YHBUserCellsView ()
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation YHBUserCellsView

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data
{
    self = [super initWithFrame:frame];
    self.dataArray = data;
    self.backgroundColor = [UIColor clearColor];
    //self.layer.borderWidth = 0.5f;
    //self.layer.borderColor = [kLineColor CGColor];
    int i,j;
    CGFloat currentY = 0;
    for (i = 0; i < self.dataArray.count; i++) {
        NSArray *array = self.dataArray[i];
        for (j = 0; j < array.count; j++) {
            NSDictionary *dic = array[j];
            UIView *cellView = [self customCellWithNum:[dic[@"tag"] intValue] title:dic[@"title"] frame:CGRectMake(0, 0, kMainScreenWidth, KcellHeight)];
            [cellView setFrame:CGRectMake(0, currentY, kMainScreenWidth, KcellHeight)];
            currentY += (KcellHeight);
            [self addSubview:cellView];
            if (j != array.count-1) {
                [cellView addSubview:[self myLineWithY:KcellHeight-0.7]];
            }
            
        }
        currentY += kBlankHeight;
    }
    return self;
}

#pragma mark - Action
- (void)touchCellButton : (UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(touchCellWithTag:)]) {
        [self.delegate touchCellWithTag:sender.tag];
    }
}


- (UIView *)customCellWithNum : (int)num title : (NSString *)title frame : (CGRect)frame;
{
    UIView *cellView = [[UIView alloc] init];
    cellView.frame = frame;
    cellView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = cellView.frame;
    [button addTarget:self action:@selector(touchCellButton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = num;
    [cellView addSubview:button];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (KcellHeight-25)/2.0, 25, 25)];
    //设置图片
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"UserCellIcon_%d",num]];
    [cellView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+10, (KcellHeight-cellFont)/2.0, 100, cellFont)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:cellFont];
    titleLabel.text = title;
    //MLOG(@"%@",title);
    
    [cellView addSubview:titleLabel];
    //8-13
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-25, KcellHeight/2.0 - 9.5, 12, 19)];
    arrowImageView.image = [UIImage imageNamed:@"Arrow_right"];
    [arrowImageView setContentMode:UIViewContentModeScaleAspectFit];
    [cellView addSubview:arrowImageView];
    /*
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, cellView.height-0.5, kMainScreenWidth, 0.5)];
    line.backgroundColor = kLineColor;
    [cellView addSubview:line];
     */
    return cellView;
}

- (UIView *)myLineWithY:(CGFloat)y
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(35, y, kMainScreenWidth, 0.7)];
    view.backgroundColor = kLineColor;
    return view;
}

@end
