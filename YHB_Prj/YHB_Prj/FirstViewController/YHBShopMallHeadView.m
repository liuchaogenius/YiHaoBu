//
//  YHBShopMallHeadView.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/19.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShopMallHeadView.h"
#define kfont 15
@interface YHBShopMallHeadView()

@property (strong, nonatomic) UILabel *titleLable;

@end

@implementation YHBShopMallHeadView

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLable.text = title;
}

- (instancetype)init
{
    self = [super init];
    self.frame = CGRectMake(0, 0, kMainScreenWidth, kHeadViewHeight);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.6;
    self.layer.borderColor = [kLineColor CGColor];
    
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(5, (kHeadViewHeight-kfont)/2.0f, 100, kfont)];
    [self addSubview:self.titleLable];
    self.titleLable.font = [UIFont systemFontOfSize:kfont];
    self.title = @"";
    self.titleLable.text = self.title;
    
    return self;
}

@end
