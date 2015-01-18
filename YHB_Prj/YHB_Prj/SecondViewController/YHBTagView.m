//
//  YHBTagView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/17.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBTagView.h"
#define kTagHeight 30
#define kBtnHeight 28

@implementation YHBTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
        self.layer.borderColor = [kLineColor CGColor];
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 2.0f;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.width, self.height)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.font = kFont14;
        _titleLabel = titleLabel;
        [self addSubview:titleLabel];
        
        UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [delBtn setFrame:CGRectMake(self.right-kBtnHeight, 0, kBtnHeight, kBtnHeight)];
        [delBtn setBackgroundImage:[UIImage imageNamed:@"TagDel"] forState:UIControlStateNormal];
        _delButton = delBtn;
        [delBtn setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:delBtn];
    }
    
    return self;

}


@end
