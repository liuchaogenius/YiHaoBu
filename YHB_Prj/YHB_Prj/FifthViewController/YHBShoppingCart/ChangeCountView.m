//
//  ChangeCountView.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/13.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "ChangeCountView.h"

@implementation ChangeCountView

- (instancetype)initWithFrame:(CGRect)frame andChangeBlock:(void (^)(float aCount))aChangeBlock
{
    if (self = [super initWithFrame:frame]) {
        UIButton *jianBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [jianBtn setTitle:@"-" forState:UIControlStateNormal];
        jianBtn.tag = 100;
        jianBtn.layer.borderColor = [[UIColor blackColor] CGColor];
        jianBtn.layer.borderWidth = 0.5;
        [jianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [jianBtn addTarget:self action:@selector(jianjiaBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:jianBtn];
        
        UIButton *jiaBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-20, 0, 20, 20)];
        [jiaBtn setTitle:@"+" forState:UIControlStateNormal];
        jiaBtn.tag = 101;
        jiaBtn.layer.borderColor = [[UIColor blackColor] CGColor];
        jiaBtn.layer.borderWidth = 0.5;
        [jiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [jiaBtn addTarget:self action:@selector(jianjiaBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:jiaBtn];
        
        countLabel = [[UILabel alloc] initWithFrame:CGRectMake(jianBtn.right, 0, jiaBtn.left-jianBtn.right, 20)];
        countLabel.font = kFont12;
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.layer.borderWidth = 0.5;
        countLabel.layer.borderColor = [[UIColor blackColor] CGColor];
        [self addSubview:countLabel];
        
        self.myBlock = aChangeBlock;
    }
    return self;
}

- (void)setCountLabel:(float)aCount
{
    self.count = aCount;
    countLabel.text = [NSString stringWithFormat:@"%.1f", self.count];
}

- (void)jianjiaBtn:(UIButton *)aBtn
{
    if (aBtn.tag==100)
    {
        if (self.count>1)
        {
            self.count--;
        }
    }
    else
    {
        self.count++;
    }
    countLabel.text = [NSString stringWithFormat:@"%.1f", self.count];
    self.myBlock(self.count);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
