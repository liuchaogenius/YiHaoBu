//
//  YHBFunctionView.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/20.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBFunctionCell.h"
#define buttonWidth (150*kMainScreenWidth/1080.0f)
#define buttonHeight buttonWidth
#define kTitleFont 15

@implementation YHBFunctionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self ) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSArray *titleArray = @[@"类目",@"团购",@"供应",@"采购"];
        CGFloat blankWidth = (kMainScreenWidth -2*(60*kMainScreenWidth/1080.0)- 4*buttonWidth)/3.0f;
        for (int i = 0; i < 4; i++) {
            UIButton *button = [self customedButtonWithFrame:CGRectMake((60*kMainScreenWidth/1080.0)+i*(blankWidth+buttonWidth), 10, buttonWidth, buttonHeight) andTag:i+fcViewTagBase andImage:[UIImage imageNamed:[NSString stringWithFormat:@"funcImage%d",i]]];
            [self.contentView addSubview:button];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(button.left-10, button.bottom+7, button.width+20, kTitleFont)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:kTitleFont];
            label.text = titleArray[i];
            [label setTextAlignment:NSTextAlignmentCenter];
            [self.contentView addSubview:label];
        }
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (UIButton *)customedButtonWithFrame:(CGRect)frame andTag:(NSInteger)tag andImage:(UIImage *)image
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.tag = tag;
    [button addTarget:self action:@selector(touchedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)touchedButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(touchedFunctionButtonWithTag:)]) {
        [self.delegate touchedFunctionButtonWithTag:sender.tag];
    }
}


@end
