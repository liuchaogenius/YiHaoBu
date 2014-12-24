//
//  YHBSerchCell.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/23.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBSerchCell.h"


@implementation YHBSerchCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.frame = CGRectMake(0, 0, kMainScreenWidth, kSearchCellHeight);
    self.backgroundColor = [UIColor whiteColor];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kMainScreenWidth-66, 30)];
    [tf setPlaceholder:@"请输入关键词搜索"];
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    tf.layer.borderWidth = 0.6;
    tf.layer.borderColor = [KColor CGColor];
    tf.font = kFont13;
    tf.layer.cornerRadius = 2.0f;
    self.textFiled = tf;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(tf.right+10, tf.top, 36, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"searchHlight"] forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    self.searchbutton = button;
    
    
    
    [self.contentView addSubview:tf];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
