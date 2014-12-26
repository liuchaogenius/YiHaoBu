//
//  YHBBuyDetailView.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBBuyDetailData.h"
#import "AttentionManage.h"

@interface YHBBuyDetailView : UIView
{
    UITextView *detailTextView;
    UILabel *timeLabel;
    UILabel *personLabel;
    UILabel *nameLabel;
    UIView *bottomLineView;
    UIImageView *vipImgView;
    UIImageView *starView;
    UILabel *likelabel;
    UIButton *likeBtn;
    BOOL isLiked;
    UILabel *contentLabel;
    YHBBuyDetailData *myModel;
}
@property(nonatomic, strong) AttentionManage *manage;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setDetailWithModel:(YHBBuyDetailData *)aModel;

@end
