//
//  EMChatCommandBubbleView.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/27.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "EMChatCommandBubbleView.h"
#import "UIImageView+WebCache.h"

NSString *const kRouterEventCommandTapEventName = @"kRouterEventCommandTapEventName";

@interface EMChatCommandBubbleView()
{
    NSDictionary *dict;
    NSString *itemid;
    NSString *itemType;
    NSString *imageUrl;
    NSString *itemTitle;
}
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end


@implementation EMChatCommandBubbleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(BUBBLE_VIEW_PADDING, BUBBLE_VIEW_PADDING, 160, 70)];
        self.backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backView];
        
        self.itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
        [self.backView addSubview:self.itemImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.itemImageView.right+5, (70-40)/2, 90, 40)];
        self.titleLabel.font = kFont15;
        self.titleLabel.numberOfLines = 2;
        [self.backView addSubview:self.titleLabel];
    }
    return self;
}

-(void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventCommandTapEventName
                     userInfo:@{KMESSAGEKEY:self.model}];
}

- (void)setModel:(MessageModel *)model
{
    [super setModel:model];
    dict = model.ext;
    itemid = [dict objectForKey:@"itemId"];
    itemType = [dict objectForKey:@"itemType"];
    imageUrl = [dict objectForKey:@"itemImage"];
    itemTitle = [dict objectForKey:@"itemTitle"];
    
    self.titleLabel.text = itemTitle;
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"DefaultProduct"]];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(160 + BUBBLE_VIEW_PADDING * 2 + BUBBLE_ARROW_WIDTH, 2 * BUBBLE_VIEW_PADDING + 70);
}

+(CGFloat)heightForBubbleWithObject:(MessageModel *)object
{
    return 100;
}

@end
