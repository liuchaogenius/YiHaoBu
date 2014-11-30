//
//  YHBContactView.m
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBContactView.h"

@implementation YHBContactView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, frame.size.width-6, frame.size.height)];
        backGroundView.layer.borderColor = [[UIColor grayColor] CGColor];
        backGroundView.layer.borderWidth = 0.5;
        [self addSubview:backGroundView];
        
        UILabel *personNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 7, 200, 15)];
        personNameLabel.font = kFont15;
        personNameLabel.text = @"联 系 人：何某某";
        
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(personNameLabel.left, personNameLabel.bottom+15, 200, 15)];
        phoneLabel.font = kFont15;
        phoneLabel.text = @"联系电话：13000000000";
        
        
        [self addSubview:personNameLabel];
        [self addSubview:phoneLabel];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
