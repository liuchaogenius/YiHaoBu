//
//  YHBSupplyDetailView.m
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBSupplyDetailView.h"
#define interval 7
@implementation YHBSupplyDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UIView *topLineView = [[UIView alloc]
                               initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 0.5)];
        topLineView.backgroundColor = [UIColor blackColor];
        [self addSubview:topLineView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-100, topLineView.bottom+interval, 200, 15)];
        nameLabel.font = kFont14;
        nameLabel.text = @"商品名";
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, nameLabel.bottom+interval, 130, 15)];
        timeLabel.font = kFont12;
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.text = @"发布时间 : ";//@"发布时间 : 2014-10-24";
        [self addSubview:timeLabel];
        
        personLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-90, timeLabel.top, 90, 15)];
        personLabel.font = kFont12;
        personLabel.textColor = [UIColor lightGrayColor];
        personLabel.backgroundColor = [UIColor clearColor];
        personLabel.text = @"浏览量 : ";//@"浏览量 : 123";
        [self addSubview:personLabel];
        
        bottomLineView = [[UIView alloc]
                            initWithFrame:CGRectMake(0, personLabel.bottom+interval, kMainScreenWidth, 0.5)];
        bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomLineView];
        
        NSArray *itemArray = @[@"价       格 : ",@"状       态 : ",@"风       格 : ",@"成       分 : ",@"用       途 : ",@"工       艺 : ", @"面料详情 : "];
        CGFloat endY = 0.0;
        for (int i=0; i<7; i++)
        {
            UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, bottomLineView.bottom+interval+(20+interval*2)*i, 80, 20)];
            itemLabel.text = [itemArray objectAtIndex:i];
            if (i==1)
            {
                itemLabel.textColor = [UIColor redColor];
            }
            itemLabel.font = kFont16;
            itemLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:itemLabel];
            if (i!=6)
            {
                UIView *lineView = [[UIView alloc]
                                    initWithFrame:CGRectMake(0, itemLabel.bottom+interval-0.5, kMainScreenWidth, 0.5)];
                lineView.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:lineView];
            }
            endY = itemLabel.bottom;
        }
        
        detailTextView = [[UITextView alloc]
                                initWithFrame:CGRectMake(0, endY+interval, kMainScreenWidth, 50)];
        detailTextView.backgroundColor = [UIColor clearColor];
        detailTextView.textColor = [UIColor lightGrayColor];
        detailTextView.font = kFont13;
//        detailTextView.text = @"化纤，棉法防打发打发";
        [detailTextView setEditable:NO];
        [self addSubview:detailTextView];
    }
    return self;
}

- (void)setDetailWithModel:(YHBSupplyDetailModel *)aModel
{
    NSArray *array = [aModel.catname componentsSeparatedByString:@","];
    NSArray *valueArray = @[aModel.price,aModel.typename,array[0],array[1],array[2],@"提花"];
    for (int i=0; i<6; i++)
    {
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(83, bottomLineView.bottom+interval+(20+interval*2)*i, 80, 20)];
        if (i<2)
        {
            valueLabel.font = kFont16;
            valueLabel.textColor = [UIColor redColor];
        }
        else
        {
            valueLabel.font = kFont14;
            valueLabel.textColor = [UIColor lightGrayColor];
        }
        if (i==0)
        {
            valueLabel.text = [NSString stringWithFormat:@"%@ %@", [valueArray objectAtIndex:i], aModel.unit];
        }
        else
        {
            valueLabel.text = [valueArray objectAtIndex:i];
        }
        [self addSubview:valueLabel];
    }
    detailTextView.text = aModel.content;
    timeLabel.text = [NSString stringWithFormat:@"发布时间 : %@", aModel.editdate];
    personLabel.text = [NSString stringWithFormat:@"浏览量 : %d", aModel.hits];
    nameLabel.text = aModel.title;
}

@end
