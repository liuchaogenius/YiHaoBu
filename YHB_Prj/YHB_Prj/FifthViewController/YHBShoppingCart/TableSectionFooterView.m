//
//  TableSectionFooterView.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/10.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "TableSectionFooterView.h"

@implementation TableSectionFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-110, 5, 105, 20)];
        priceLabel.font = kFont14;
        priceLabel.text = @"合计￥0";
        [self addSubview:priceLabel];
        
        itemCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-200, 5, 80, 20)];
        itemCountLabel.textColor = [UIColor lightGrayColor];
        itemCountLabel.text = @"共0件商品";
        itemCountLabel.font = kFont14;
        [self addSubview:itemCountLabel];
    }
    return self;
}

-(void)setViewWith:(YHBShopCartRslist *)aModel
{
    int itemCount = 0;
    float price = 0;
    NSArray *array = aModel.cartlist;
    for (int i=0; i<array.count; i++)
    {
        YHBShopCartCartlist *model = [array objectAtIndex:i];
        itemCount += [model.number intValue];
        price += [model.number intValue]*[model.price intValue];
    }
    itemCountLabel.text = [NSString stringWithFormat:@"共%d件商品", itemCount];
    priceLabel.text = [NSString stringWithFormat:@"合计￥%.2f", price];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
