//
//  YHBFuncBlockCell.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/20.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBFuncBlockCell.h"

@implementation YHBFuncBlockCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        MLOG(@"%f,%f",frame.size.height,self.height);
        UIButton *shopMallBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width/2.0, self.height)];
        [shopMallBtn setBackgroundImage:[UIImage imageNamed:@"shopMall"] forState:UIControlStateNormal];
        [shopMallBtn addTarget:self action:@selector(touchedButton:) forControlEvents:UIControlEventTouchUpInside];
        shopMallBtn.tag = button_shopMall;
        [self.contentView addSubview:shopMallBtn];
        
        UIButton *findButtton = [[UIButton alloc] initWithFrame:CGRectMake(shopMallBtn.right, 0, self.width/2.0f, self.height/2.0f)];
        [findButtton setBackgroundImage:[UIImage imageNamed:@"findWeave"] forState:UIControlStateNormal];
        [findButtton addTarget:self action:@selector(touchedButton:) forControlEvents:UIControlEventTouchUpInside];
        findButtton.tag = button_findWeave;
        [self.contentView addSubview:findButtton];
        
        UIButton *sellButtton = [[UIButton alloc] initWithFrame:CGRectMake(shopMallBtn.right, self.height/2.0f, self.width/2.0f, self.height/2.0f)];
        [sellButtton setBackgroundImage:[UIImage imageNamed:@"sellWeave"] forState:UIControlStateNormal];
        [sellButtton addTarget:self action:@selector(touchedButton:) forControlEvents:UIControlEventTouchUpInside];
        sellButtton.tag = button_sellWeave;
        [self.contentView addSubview:sellButtton];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)touchedButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(touchFuncBlockWithTag:)]) {
        [self.delegate touchFuncBlockWithTag:sender.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
