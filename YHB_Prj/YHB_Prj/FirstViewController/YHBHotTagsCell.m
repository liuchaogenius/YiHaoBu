//
//  YHBHotTagsCell.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/20.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBHotTagsCell.h"
#define kHotTagBase 60
#define kTitleFont 10
#define kBlankWidth 10
#define kTagBtnHeight 20

@implementation YHBHotTagsCell

- (NSMutableArray *)tagsArray
{
    if (!_tagsArray) {
        _tagsArray = [NSMutableArray arrayWithCapacity:10];
        
        CGFloat btnWidth = (kMainScreenWidth-kBlankWidth*6)/5.0f;
        for (int i = 0; i < 10; i++) {
            UIButton *btn = [self customTagButtonWithFrame:CGRectMake(kBlankWidth + (i%5)*(kBlankWidth+btnWidth), 5+(i/5)*(10+kTagBtnHeight), btnWidth, kTagBtnHeight) andTag:i+kHotTagBase];

            _tagsArray[i] = btn;
            btn.hidden = NO;
            [self.contentView addSubview:btn];
        }
    }
    return _tagsArray;
}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainScreenWidth, kHotTagCellHeight);
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2.5, 100, 15)];
//        label.font = kFont14;
//        label.tintColor = [UIColor blackColor];
//        [self.contentView addSubview:label];
//        self.titleLabel = label;
        if (self.tagsArray) {
        }
    }
    return self;
}

- (UIButton *)customTagButtonWithFrame:(CGRect)frame andTag:(NSInteger)tag
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.tag = tag;
    button.layer.borderColor = [kLineColor CGColor];
    button.layer.borderWidth = 0.7;
    button.layer.cornerRadius = 2.0f;
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:kTitleFont];
    [button addTarget:self action:@selector(touchTagButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)touchTagButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(touchHotTagsWithTag:)]) {
        [self.delegate touchHotTagsWithTag:sender.tag%kHotTagBase];
    }
}
@end
