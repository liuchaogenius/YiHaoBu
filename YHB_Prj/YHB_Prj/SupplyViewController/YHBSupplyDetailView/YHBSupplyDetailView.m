//
//  YHBSupplyDetailView.m
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBSupplyDetailView.h"
#import "SVProgressHUD.h"
#define interval 10
@implementation YHBSupplyDetailView

- (instancetype)initWithFrame:(CGRect)frame andIsMine:(BOOL)aBool
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        isLiked=NO;
        UIView *topLineView = [[UIView alloc]
                               initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 0.5)];
        topLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:topLineView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, topLineView.bottom+interval, kMainScreenWidth-80, 18)];
        nameLabel.font = kFont15;
        nameLabel.text = @"商品名";
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
//        CGSize size = [@"已收藏" sizeWithFont:kFont12];
        
        vipImgView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLabel.right, nameLabel.top+3, 16, 12)];
        vipImgView.image = [UIImage imageNamed:@"vipImgDetail"];
        [self addSubview:vipImgView];
        vipImgView.hidden = YES;
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom+interval, 130, 15)];
        timeLabel.font = kFont12;
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.text = @"发布时间 : ";//@"发布时间 : 2014-10-24";
        [self addSubview:timeLabel];
        
//        personLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-90, timeLabel.top, 90, 15)];
//        personLabel.font = kFont12;
//        personLabel.textColor = [UIColor lightGrayColor];
//        personLabel.backgroundColor = [UIColor clearColor];
//        personLabel.text = @"浏览量 : ";//@"浏览量 : 123";
//        [self addSubview:personLabel];
        
        bottomLineView = [[UIView alloc]
                            initWithFrame:CGRectMake(0, timeLabel.bottom+interval, kMainScreenWidth, 0.5)];
        bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomLineView];
        
        if (!aBool)
        {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kMainScreenWidth-60, 10, 0.5, bottomLineView.top-20)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:lineView];
            
            likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(lineView.right+12, lineView.top+3, 36, 40)];
            likeBtn.userInteractionEnabled=NO;
            [likeBtn addTarget:self action:@selector(touchLikeBtn) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:likeBtn];
            
            starView = [[UIImageView alloc] initWithFrame:CGRectMake((likeBtn.right-likeBtn.left-21)/2.0, 0, 21, 20)];
            starView.image = [UIImage imageNamed:@"starUnLike"];
            [likeBtn addSubview:starView];
            
            likelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, starView.bottom+2.5, 36, 15)];
            likelabel.textColor = KColor;
            likelabel.textAlignment = NSTextAlignmentCenter;
            likelabel.font = kFont12;
            likelabel.text=@"收藏";
            [likeBtn addSubview:likelabel];
        }
        
        NSArray *itemArray = @[@"价格 : ",@"状态 : ",@"分类 : ",@"面料详情 : "];
        CGFloat endY = 0.0;
        for (int i=0; i<4; i++)
        {
            float itemWidth = 43;
            if (i==3) {
                itemWidth=75;
            }
            UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, bottomLineView.bottom+interval+(18+interval*2)*i, itemWidth, 18)];
            itemLabel.text = [itemArray objectAtIndex:i];
            if (i==1)
            {
                itemLabel.textColor = [UIColor redColor];
            }
            itemLabel.font = kFont15;
            itemLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:itemLabel];
            if (i!=3)
            {
                UIView *lineView = [[UIView alloc]
                                    initWithFrame:CGRectMake(0, itemLabel.bottom+interval-0.5, kMainScreenWidth, 0.5)];
                lineView.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:lineView];
            }
            endY = itemLabel.bottom;
        }
        
        detailTextView = [[UITextView alloc]
                                initWithFrame:CGRectMake(5, endY, kMainScreenWidth-2*5, 60)];
        detailTextView.backgroundColor = [UIColor clearColor];
        detailTextView.textColor = [UIColor lightGrayColor];
        detailTextView.font = kFont15;
        detailTextView.text = @"无描述";
        [detailTextView setEditable:NO];
        [self addSubview:detailTextView];
//        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(interval, endY+interval, kMainScreenWidth-20, 18)];
//        contentLabel.textColor = [UIColor lightGrayColor];
//        contentLabel.text = @"无描述";
//        contentLabel.font = kFont15;
//        [self addSubview:contentLabel];
    }
    return self;
}

- (AttentionManage *)manage
{
    if (!_manage) {
        _manage = [[AttentionManage alloc] init];
    }
    return _manage;
}

- (void)touchLikeBtn
{
    [SVProgressHUD show:YES offsetY:100];
    [self.manage changeLikeStatusAction:@"sell" itemid:myModel.itemid SuccBlock:^{
        [SVProgressHUD dismiss];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:likeBtn cache:YES];
        if (isLiked)
        {
            starView.image = [UIImage imageNamed:@"starUnLike"];
            likelabel.text=@"收藏";
        }
        else
        {
            starView.image = [UIImage imageNamed:@"starLike"];
            likelabel.text=@"已收藏";
        }
        [UIView commitAnimations];
        isLiked = !isLiked;
    } andFailBlock:^(NSString *aStr){
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:100];
    }];
}

- (void)setDetailWithModel:(YHBSupplyDetailModel *)aModel
{
//    NSArray *array = [aModel.catname componentsSeparatedByString:@","];
    likeBtn.userInteractionEnabled = YES;
    NSMutableDictionary *dict = [NSMutableDictionary new];
    if (aModel.price)
    {
        [dict setValue:aModel.price forKey:@"price"];
    }
    if (aModel.typename)
    {
        [dict setValue:aModel.typename forKey:@"typename"];
    }
    if (aModel.catname)
    {
        [dict setValue:aModel.catname forKey:@"catname"];
    }
    for (int i=0; i<3; i++)
    {
        UILabel *valueLabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(55, bottomLineView.bottom+interval+(18+interval*2)*i, kMainScreenWidth-80, 18)];
        valueLabel.font = kFont15;
        if (i<2)
        {
            valueLabel.textColor = [UIColor redColor];
        }
        else
        {
            valueLabel.textColor = [UIColor lightGrayColor];
        }
        if (i==0)
        {
            NSString *str = [dict objectForKey:@"price"];
            if (str)
            {
                float price = [str floatValue];
                valueLabel.text = [NSString stringWithFormat:@"￥%.2f", price];
                CGSize size = [valueLabel.text sizeWithFont:kFont15];
                CGRect temFrame = valueLabel.frame;
                temFrame.size.width = size.width;
                valueLabel.frame = temFrame;
                UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(valueLabel.right+10, valueLabel.top, 100, 18)];
                unitLabel.textColor = [UIColor lightGrayColor];
                unitLabel.textAlignment = NSTextAlignmentLeft;
                unitLabel.font = kFont15;
                unitLabel.text = [NSString stringWithFormat:@"元/%@", aModel.unit];
                [self addSubview:unitLabel];
            }
        }
        else if(i==1)
        {
            NSString *str = [dict objectForKey:@"typename"];
            if (str)
            {
                valueLabel.text = str;
            }
        }
        else if(i==2)
        {
            NSString *str = [dict objectForKey:@"catname"];
            if (str)
            {
                valueLabel.text = str;
            }
        }
        [self addSubview:valueLabel];
    }
    detailTextView.text = aModel.content;
//    contentLabel.text = aModel.content;
    timeLabel.text = [NSString stringWithFormat:@"发布时间 : %@", aModel.editdate];
//    personLabel.text = [NSString stringWithFormat:@"浏览量 : %d", aModel.hits];
    nameLabel.text = aModel.title;
    if (aModel.vip==1)
    {
        CGSize nameSize = [nameLabel.text sizeWithFont:kFont15];
        CGRect temFrame = nameLabel.frame;
        temFrame.size.width = nameSize.width;
        nameLabel.frame = temFrame;
        vipImgView.left = nameLabel.right+5;
        vipImgView.hidden = NO;
    }
    if (aModel.favorite==1) {
        starView.image = [UIImage imageNamed:@"starLike"];
        likelabel.text=@"已收藏";
        isLiked = YES;
    }
}

@end
