//
//  YHBSupplyDetailView.h
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBSupplyDetailModel.h"
#import "AttentionManage.h"

@interface YHBSupplyDetailView : UIView
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
    YHBSupplyDetailModel *myModel;
}
@property(nonatomic, strong) AttentionManage *manage;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setDetailWithModel:(YHBSupplyDetailModel *)aModel;
@end
